#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

SUPER_DIR="${1:-$PROJECT_DIR/extracted/super_lpunpack}"
OUTDIR="${2:-$PROJECT_DIR/extracted/vendor_blobs}"

mkdir -p "$OUTDIR"
mkdir -p "$PROJECT_DIR/work"

VENDOR_IMG="$(find "$SUPER_DIR" -maxdepth 1 -type f -name "vendor*.img" | head -n 1 || true)"
if [[ -z "$VENDOR_IMG" || ! -f "$VENDOR_IMG" ]]; then
  echo "ERROR: vendor*.img not found in: $SUPER_DIR"
  echo "Hint: run scripts/03_unpack_super_img.sh first."
  exit 1
fi

echo "[*] vendor image: $VENDOR_IMG"
file "$VENDOR_IMG" || true

# Convert sparse vendor.img -> raw if needed
VENDOR_RAW="$PROJECT_DIR/extracted/vendor.raw.img"
if file "$VENDOR_IMG" | grep -qi "sparse"; then
  if ! command -v simg2img >/dev/null 2>&1; then
    echo "ERROR: simg2img not found."
    echo "Install: sudo apt install -y android-sdk-libsparse-utils"
    exit 2
  fi
  if [[ ! -f "$VENDOR_RAW" || ! -s "$VENDOR_RAW" ]]; then
    echo "[*] Sparse vendor image detected -> converting: $VENDOR_RAW"
    simg2img "$VENDOR_IMG" "$VENDOR_RAW"
  fi
else
  VENDOR_RAW="$VENDOR_IMG"
fi

MNT="$PROJECT_DIR/work/mnt_vendor"
mkdir -p "$MNT"

copy_if_exists() {
  local src="$1"
  local dst="$2"
  if [[ -e "$src" ]]; then
    mkdir -p "$(dirname "$dst")"
    cp -a "$src" "$dst"
  fi
}

# Flatten nested directory structure (fixes debugfs rdump quirk)
flatten_nested() {
  local dir="$1"
  local basename
  basename=$(basename "$dir")
  # Check for nested dir with same name (e.g., firmware/firmware/)
  if [[ -d "${dir}/${basename}" ]]; then
    echo "[*] Flattening nested ${basename}/${basename}/ structure..."
    # Move contents up one level
    find "${dir}/${basename}" -maxdepth 1 ! -name "$basename" -exec mv {} "$dir/" \; 2>/dev/null || true
    rmdir "${dir}/${basename}" 2>/dev/null || true
  fi
}

EXTRACTION_METHOD="none"

# -----------------------------------------------------------------------------
# Method 1: Try FUSE-based extraction with ext4fuse or fuse2fs (no root needed)
# -----------------------------------------------------------------------------
try_fuse_mount() {
  if command -v fuse2fs >/dev/null 2>&1; then
    echo "[*] Trying fuse2fs (FUSE ext2/3/4 mount, no root)..."
    if fuse2fs -o ro,fakeroot "$VENDOR_RAW" "$MNT" 2>/dev/null; then
      echo "[*] Mounted vendor via fuse2fs -> $MNT"
      return 0
    fi
  fi

  if command -v ext4fuse >/dev/null 2>&1; then
    echo "[*] Trying ext4fuse (FUSE ext4 mount, no root)..."
    if ext4fuse "$VENDOR_RAW" "$MNT" -o ro 2>/dev/null; then
      echo "[*] Mounted vendor via ext4fuse -> $MNT"
      return 0
    fi
  fi

  return 1
}

# -----------------------------------------------------------------------------
# Method 2: Try regular mount (may need sudo)
# -----------------------------------------------------------------------------
try_regular_mount() {
  echo "[*] Trying regular mount..."

  # Try without sudo first
  if mount -o loop,ro "$VENDOR_RAW" "$MNT" 2>/dev/null; then
    echo "[*] Mounted vendor (non-sudo) -> $MNT"
    return 0
  fi

  # Try with sudo if available without password
  if sudo -n true 2>/dev/null; then
    if sudo mount -o loop,ro "$VENDOR_RAW" "$MNT" 2>/dev/null; then
      echo "[*] Mounted vendor (with sudo) -> $MNT"
      USED_SUDO=true
      return 0
    fi
  fi

  return 1
}

# -----------------------------------------------------------------------------
# Method 3: Use debugfs for individual file extraction
# -----------------------------------------------------------------------------
extract_with_debugfs() {
  echo "[*] Using debugfs for extraction (limited but works everywhere)..."

  if ! command -v debugfs >/dev/null 2>&1; then
    echo "ERROR: debugfs not found."
    echo "Install: sudo apt install -y e2fsprogs"
    return 1
  fi

  mkdir -p "$OUTDIR/lib/modules" "$OUTDIR/firmware" "$OUTDIR/etc/vintf"

  # Extract kernel modules - need to handle subdirectories
  echo "[*] Extracting kernel modules..."
  # First, list the modules directory structure
  MODULES_CONTENT=$(debugfs -R "ls -l /lib/modules" "$VENDOR_RAW" 2>/dev/null || true)
  if [[ -n "$MODULES_CONTENT" ]]; then
    # Try to find .ko files recursively using debugfs
    # debugfs doesn't have recursive ls, so we check common subdirs
    for subdir in "" "4.14.98" "4.14.117" "4.14.138" "4.14.186" "4.4.176"; do
      local path="/lib/modules"
      [[ -n "$subdir" ]] && path="/lib/modules/$subdir"

      MODULE_LIST=$(debugfs -R "ls $path" "$VENDOR_RAW" 2>/dev/null | tr -s ' \t' '\n' | grep -E '\.ko$' || true)
      if [[ -n "$MODULE_LIST" ]]; then
        [[ -n "$subdir" ]] && mkdir -p "$OUTDIR/lib/modules/$subdir"
        for mod in $MODULE_LIST; do
          local outpath="$OUTDIR/lib/modules"
          [[ -n "$subdir" ]] && outpath="$OUTDIR/lib/modules/$subdir"
          debugfs -R "dump $path/$mod $outpath/$mod" "$VENDOR_RAW" 2>/dev/null || true
        done
      fi
    done
  fi

  # Extract firmware files
  echo "[*] Extracting firmware..."
  FW_LIST=$(debugfs -R "ls /firmware" "$VENDOR_RAW" 2>/dev/null | tr -s ' \t' '\n' | grep -v '^$' | grep -v '^\.$' | grep -v '^\.\.$' || true)
  if [[ -n "$FW_LIST" ]]; then
    for fw in $FW_LIST; do
      # Check if it's a directory or file
      local ftype
      ftype=$(debugfs -R "stat /firmware/$fw" "$VENDOR_RAW" 2>/dev/null | grep -o 'Type: [a-z]*' | cut -d' ' -f2 || echo "file")
      if [[ "$ftype" == "directory" ]]; then
        # It's a subdirectory, extract its contents
        mkdir -p "$OUTDIR/firmware/$fw"
        SUB_FW=$(debugfs -R "ls /firmware/$fw" "$VENDOR_RAW" 2>/dev/null | tr -s ' \t' '\n' | grep -v '^$' | grep -v '^\.$' | grep -v '^\.\.$' || true)
        for sf in $SUB_FW; do
          debugfs -R "dump /firmware/$fw/$sf $OUTDIR/firmware/$fw/$sf" "$VENDOR_RAW" 2>/dev/null || true
        done
      else
        debugfs -R "dump /firmware/$fw $OUTDIR/firmware/$fw" "$VENDOR_RAW" 2>/dev/null || true
      fi
    done
  fi

  # Extract config files
  echo "[*] Extracting config files..."
  debugfs -R "dump /etc/vintf/manifest.xml $OUTDIR/etc/vintf/manifest.xml" "$VENDOR_RAW" 2>/dev/null || true
  debugfs -R "dump /etc/vintf/compatibility_matrix.xml $OUTDIR/etc/vintf/compatibility_matrix.xml" "$VENDOR_RAW" 2>/dev/null || true
  debugfs -R "dump /build.prop $OUTDIR/build.prop" "$VENDOR_RAW" 2>/dev/null || true

  return 0
}

# -----------------------------------------------------------------------------
# Main extraction logic
# -----------------------------------------------------------------------------
USED_SUDO=false
MOUNT_SUCCESS=false

# Try FUSE first (works in containers without privileges)
if try_fuse_mount; then
  MOUNT_SUCCESS=true
  EXTRACTION_METHOD="fuse"
# Try regular mount
elif try_regular_mount; then
  MOUNT_SUCCESS=true
  EXTRACTION_METHOD="mount"
fi

if [[ "$MOUNT_SUCCESS" == "true" ]]; then
  echo "[*] Extracting files from mounted filesystem..."
  mkdir -p "$OUTDIR/lib" "$OUTDIR/etc/vintf" "$OUTDIR/firmware"

  # Check if mount actually shows content (FUSE mounts can appear empty in some containers)
  MOUNT_HAS_CONTENT=false
  if [[ -f "$MNT/build.prop" ]] || [[ -d "$MNT/lib" && "$(ls -A "$MNT/lib" 2>/dev/null)" ]]; then
    MOUNT_HAS_CONTENT=true
  fi

  if [[ "$MOUNT_HAS_CONTENT" == "true" ]]; then
    if [[ -d "$MNT/lib/modules" ]]; then
      echo "[*] Copying kernel modules..."
      cp -a "$MNT/lib/modules" "$OUTDIR/lib/" 2>/dev/null || true
    fi

    if [[ -d "$MNT/firmware" ]]; then
      echo "[*] Copying firmware..."
      cp -a "$MNT/firmware"/* "$OUTDIR/firmware/" 2>/dev/null || true
    fi

    copy_if_exists "$MNT/etc/vintf/manifest.xml" "$OUTDIR/etc/vintf/manifest.xml"
    copy_if_exists "$MNT/etc/vintf/compatibility_matrix.xml" "$OUTDIR/etc/vintf/compatibility_matrix.xml"
    copy_if_exists "$MNT/build.prop" "$OUTDIR/build.prop"
  else
    echo "[!] Mount appears empty (FUSE permission issue in container)."
    echo "[*] Will fall back to debugfs after unmounting..."
    MOUNT_SUCCESS=false
  fi

  # Unmount
  echo "[*] Unmounting..."
  if [[ "$EXTRACTION_METHOD" == "fuse" ]]; then
    fusermount -u "$MNT" 2>/dev/null || umount "$MNT" 2>/dev/null || true
  elif [[ "$USED_SUDO" == "true" ]]; then
    sudo umount "$MNT"
  else
    umount "$MNT" 2>/dev/null || sudo umount "$MNT" 2>/dev/null || true
  fi
  echo "[*] Unmounted."
fi

# Fall back to debugfs if mount failed or was empty
if [[ "$MOUNT_SUCCESS" == "false" ]]; then
  EXTRACTION_METHOD="debugfs"
  extract_with_debugfs || true
fi

# -----------------------------------------------------------------------------
# Post-extraction: flatten nested directories
# -----------------------------------------------------------------------------
echo "[*] Post-processing extracted files..."
flatten_nested "$OUTDIR/firmware"
flatten_nested "$OUTDIR/lib/modules"

# -----------------------------------------------------------------------------
# Summary
# -----------------------------------------------------------------------------
echo
echo "[*] Extraction summary (method: $EXTRACTION_METHOD):"
MODULE_COUNT=$(find "$OUTDIR/lib/modules" -name "*.ko" 2>/dev/null | wc -l || echo 0)
FW_COUNT=$(find "$OUTDIR/firmware" -type f 2>/dev/null | wc -l || echo 0)
echo "    Kernel modules (.ko): $MODULE_COUNT"
echo "    Firmware files:       $FW_COUNT"
[[ -f "$OUTDIR/build.prop" && -s "$OUTDIR/build.prop" ]] && echo "    build.prop:           ✓" || echo "    build.prop:           ✗"
[[ -f "$OUTDIR/etc/vintf/manifest.xml" && -s "$OUTDIR/etc/vintf/manifest.xml" ]] && echo "    manifest.xml:         ✓" || echo "    manifest.xml:         ✗"

if [[ "$MODULE_COUNT" -eq 0 ]]; then
  echo
  echo "[!] Warning: No kernel modules extracted."
  echo "    This may be a debugfs limitation or the vendor.img structure."
  echo ""
  echo "    Alternative extraction methods to try:"
  echo ""
  echo "    1. Install fuse2fs (recommended for containers):"
  echo "       sudo apt install fuse2fs"
  echo "       # Then re-run this script"
  echo ""
  echo "    2. Run outside container with sudo:"
  echo "       sudo mount -o loop,ro $VENDOR_RAW /mnt"
  echo "       sudo cp -a /mnt/lib/modules $OUTDIR/lib/"
  echo "       sudo chown -R \$(id -u):\$(id -g) $OUTDIR/lib/modules"
  echo "       sudo umount /mnt"
fi

echo
echo "[*] Done. Extracted vendor bringup blobs:"
find "$OUTDIR" -maxdepth 4 -type f | sed 's|^'"$PROJECT_DIR/"'||' | head -n 120
