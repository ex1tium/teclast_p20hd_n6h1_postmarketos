# Droidian Port Project Plan: Teclast P20HD

This document outlines the comprehensive development plan and Git workflow for porting Droidian to the Teclast P20HD tablet.

## Project Overview

| Property | Value |
|----------|-------|
| Target Device | Teclast P20HD (N6H1) |
| SoC | Unisoc SC9863A (Sharkl3) |
| Stock Kernel | 4.14.133 (Android 10) |
| Reference Kernel | Samsung A03 Core (IverCoder/Droidian branch) |
| Target OS | Droidian (Debian-based mobile Linux) |

---

## Architecture: Why This Approach Works

The Samsung A03 kernel is ~99% reusable because both devices share the same SoC:

```
┌─────────────────────────────────────────────────────────────┐
│  DEVICE-SPECIFIC (~1%) - Must change for P20HD              │
│  • Panel: ILI9881C (vs Samsung's panel)                     │
│  • Touch: FocalTech FT5436 @ I2C 0x38                       │
│  • Partition layout (mmcblk0p numbers)                      │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  SoC-SPECIFIC (~4%) - SHARED (same SC9863A chip)            │
│  • Clock/power drivers (drivers/clk/sprd/)                  │
│  • PowerVR GE8322 GPU driver                                │
│  • SPRD modem/WiFi/BT subsystem                             │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  GENERIC LINUX (~95%) - Identical everywhere                │
│  • Scheduler, memory, filesystems, networking               │
└─────────────────────────────────────────────────────────────┘
```

**Porting effort**: ~75 lines of device tree + config changes.

---

## Git Strategy: Simplified

Since this is a personal project with minimal device-specific changes, we use a simple approach:

### Repository Structure

```
device-teclast-p20hd-n6h1/        ← This repo (main branch only)
├── kernel/
│   └── linux-teclast-p20hd/      ← Submodule → your kernel fork
├── droidian/
│   ├── kernel/                   ← Build configs (kernel-info.mk, etc.)
│   └── adaptation/               ← Debian packaging
└── scripts/                      ← Extraction pipeline
```

### Two Repositories

| Repo | Purpose | Branches |
|------|---------|----------|
| `device-teclast-p20hd-n6h1` | Main project, configs, scripts | `main` only |
| `linux-teclast-p20hd` (fork) | Kernel source with P20HD patches | `droidian` (upstream tracking), `p20hd` (your changes) |

### Kernel Fork Setup

```bash
# 1. Fork IverCoder/linux-android-samsung-a03 on GitHub
#    Rename to: linux-teclast-p20hd

# 2. Clone your fork and create device branch
git clone https://github.com/ex1tium/linux-teclast-p20hd.git
cd linux-teclast-p20hd
git checkout -b p20hd droidian
git push -u origin p20hd

# 3. Add as submodule to main repo
cd ../device-teclast-p20hd-n6h1
git submodule add -b p20hd \
    https://github.com/ex1tium/linux-teclast-p20hd.git \
    kernel/linux-teclast-p20hd
```

### Daily Workflow

```bash
# Work directly on main (no feature branches needed for small project)
git add -A
git commit -m "feat(kernel): add P20HD device tree"
git push

# For kernel changes, work in the submodule
cd kernel/linux-teclast-p20hd
git checkout p20hd
# make changes...
git commit -m "dts: add ILI9881C panel node for P20HD"
git push

# Update submodule pointer in main repo
cd ../..
git add kernel/linux-teclast-p20hd
git commit -m "chore: update kernel submodule"
git push
```

### Commit Message Convention

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>
```

**Types:** `feat`, `fix`, `docs`, `chore`, `refactor`
**Scopes:** `kernel`, `adaptation`, `scripts`, `dts`

**Examples:**
```
feat(kernel): add P20HD device tree overlay
fix(dts): correct ILI9881C panel timing
docs: update hardware compatibility status
chore: update kernel submodule to latest
```

---

## Development Phases & Milestones

### Phase 0: Repository Setup ✅
**Milestone: `v0.0-repo-setup`**

- [x] Extraction pipeline complete
- [x] Documentation structure
- [x] Droidian skeleton created
- [x] Git workflow configured
- [ ] Issue templates created
- [ ] Milestone labels created

### Phase 1: Kernel Acquisition & Preparation ✅
**Milestone: `v0.1-kernel-prep`**

| Task | Status | Notes |
|------|--------|-------|
| Clone Samsung A03 kernel source | ✅ | Forked to linux-teclast-p20hd |
| Set up kernel submodule | ✅ | On `p20hd` branch |
| Create P20HD defconfig | ✅ | `arch/arm64/configs/teclast/p20hd_defconfig` |
| Create P20HD device tree | ✅ | `sp9863a-p20hd-overlay.dts` |
| Disable Samsung-specific configs | ✅ | SEC_DEBUG, DRV_SAMSUNG, etc. |

**Exit Criteria:**
- ✅ Kernel compiles without errors
- ⬜ defconfig passes mer-kernel-check (pending)
- ⬜ fixup-mountpoints has real partition numbers (pending)

### Phase 2: Kernel Build ✅
**Milestone: `v0.2-kernel-build`**

| Task | Status | Notes |
|------|--------|-------|
| Fix -Werror for GCC 12+ | ✅ | Removed from Makefile |
| Fix trace header include paths | ✅ | 3 headers fixed |
| Add power supply stubs | ✅ | battery_id_via_adc.h |
| Make Samsung code conditional | ✅ | sec_cmd, cts_sec, headset notifier |
| Build kernel Image.gz | ✅ | 9.1 MB |
| Build DTB/DTBO | ✅ | sp9863a.dtb + sp9863a-p20hd-overlay.dtbo |

**Build Artifacts:**
- `arch/arm64/boot/Image.gz` (9.1 MB)
- `arch/arm64/boot/dts/sprd/sp9863a.dtb` (89 KB)
- `arch/arm64/boot/dts/sprd/sp9863a-p20hd-overlay.dtbo` (21 KB)

### Phase 3: First Boot (Current)
**Milestone: `v0.3-first-boot`**

| Task | Status | Priority |
|------|--------|----------|
| Build halium-boot ramdisk | ⬜ | P0 |
| Create boot.img with correct offsets | ⬜ | P0 |
| RAM boot test (no flash) | ⬜ | P0 |
| Serial console debugging | ⬜ | P1 |
| Telnet debugging (initramfs) | ⬜ | P1 |
| Document boot failure modes | ⬜ | P2 |

**Exit Criteria:**
- Device boots to initramfs (telnet accessible)
- Serial console shows kernel boot logs
- No immediate kernel panic

### Phase 4: Display Bringup
**Milestone: `v0.4-display`**

| Task | Branch | Priority |
|------|--------|----------|
| Verify ILI9881C panel driver | `feature/hardware-display` | P0 |
| Adapt panel DTS node if needed | `feature/hardware-display` | P0 |
| Test framebuffer console | — | P0 |
| Configure DRM/KMS for Phosh | `feature/hardware-display` | P1 |

**Exit Criteria:**
- Display shows boot console or splash
- Framebuffer accessible from userspace

### Phase 5: Touch Input
**Milestone: `v0.5-touch`**

| Task | Branch | Priority |
|------|--------|----------|
| Verify FT5436 driver loads | `feature/hardware-touch` | P0 |
| Copy touch firmware to rootfs | `feature/adaptation-firmware` | P0 |
| Test /dev/input/event* generation | — | P0 |
| Coordinate rotation with display | `feature/hardware-touch` | P1 |

**Exit Criteria:**
- Touch events registered in evtest
- Single-touch and multi-touch working
- Correct coordinate mapping

### Phase 6: Core System Boot
**Milestone: `v0.6-userspace`**

| Task | Branch | Priority |
|------|--------|----------|
| Flash rootfs to userdata | — | P0 |
| Verify systemd boot | — | P0 |
| Test libhybris/binder | `feature/adaptation-hybris` | P0 |
| Phosh/UI startup | — | P1 |
| SSH access via WiFi/USB | — | P1 |

**Exit Criteria:**
- Droidian boots to lock screen
- Can SSH into device
- Basic touch UI interaction

### Phase 7: Wireless (WiFi/BT)
**Milestone: `v0.7-wireless`**

| Task | Branch | Priority |
|------|--------|----------|
| Identify WiFi chipset/driver | `feature/hardware-wifi` | P0 |
| Load WiFi firmware | `feature/adaptation-firmware` | P0 |
| Configure wpa_supplicant | `feature/hardware-wifi` | P1 |
| Bluetooth bringup | `feature/hardware-bluetooth` | P2 |

**Exit Criteria:**
- WiFi scan shows networks
- Can connect and obtain IP
- Bluetooth pairing functional (P2)

### Phase 8: GPU Acceleration
**Milestone: `v0.8-gpu`**

| Task | Branch | Priority |
|------|--------|----------|
| Load PowerVR firmware | `feature/adaptation-firmware` | P0 |
| Configure libhybris for GPU | `feature/hardware-gpu` | P0 |
| Test EGL/GLES rendering | — | P0 |
| Verify Phosh compositor | — | P1 |

**Exit Criteria:**
- glmark2-es2 runs without errors
- Phosh animations smooth
- No GPU-related crashes

### Phase 9: Audio & Sensors
**Milestone: `v0.9-peripherals`**

| Task | Branch | Priority |
|------|--------|----------|
| Audio output (speaker) | `feature/hardware-audio` | P1 |
| Audio input (microphone) | `feature/hardware-audio` | P2 |
| Accelerometer/gyroscope | `feature/hardware-sensors` | P2 |
| Light sensor | `feature/hardware-sensors` | P3 |

**Exit Criteria:**
- Audio playback working
- Screen rotation based on sensor

### Phase 10: Polish & Release
**Milestone: `v1.0-release`**

| Task | Branch | Priority |
|------|--------|----------|
| Create final adaptation package | `release/v1.0` | P0 |
| Write installation guide | `docs/install-guide` | P0 |
| Test clean install flow | — | P0 |
| Submit to droidian-devices | — | P1 |

**Exit Criteria:**
- Reproducible build from source
- Complete installation documentation
- Stable daily-driver ready

---

## Issue Tracking Labels

### Priority Labels
| Label | Color | Description |
|-------|-------|-------------|
| `P0-critical` | #d73a4a | Blocking - must fix immediately |
| `P1-high` | #ff6b6b | Important - should fix soon |
| `P2-medium` | #ffa500 | Normal priority |
| `P3-low` | #0e8a16 | Nice to have |

### Type Labels
| Label | Color | Description |
|-------|-------|-------------|
| `type/bug` | #d73a4a | Something isn't working |
| `type/feature` | #0075ca | New feature or enhancement |
| `type/docs` | #0052cc | Documentation improvement |
| `type/question` | #d876e3 | Further information requested |

### Component Labels
| Label | Color | Description |
|-------|-------|-------------|
| `component/kernel` | #fbca04 | Kernel source or config |
| `component/adaptation` | #c5def5 | Adaptation package |
| `component/display` | #bfdadc | Display/panel issues |
| `component/touch` | #bfdadc | Touch input issues |
| `component/wifi` | #bfdadc | WiFi/network issues |
| `component/audio` | #bfdadc | Audio issues |
| `component/gpu` | #bfdadc | GPU/graphics issues |
| `component/scripts` | #e4e669 | Extraction scripts |

### Status Labels
| Label | Color | Description |
|-------|-------|-------------|
| `status/blocked` | #000000 | Blocked by external factor |
| `status/needs-device` | #f9d0c4 | Requires physical device testing |
| `status/needs-info` | #d876e3 | Waiting for more information |
| `status/wontfix` | #ffffff | Will not be addressed |

---

## Immediate Next Actions

### 1. Fork Kernel Repository

On GitHub:
1. Go to https://github.com/IverCoder/linux-android-samsung-a03
2. Click "Fork"
3. Rename to `linux-teclast-p20hd`

### 2. Set Up Kernel Fork

```bash
git clone https://github.com/ex1tium/linux-teclast-p20hd.git
cd linux-teclast-p20hd
git checkout -b p20hd droidian
git push -u origin p20hd
```

### 3. Add Kernel Submodule

```bash
cd /path/to/device-teclast-p20hd-n6h1
git submodule add -b p20hd \
    https://github.com/ex1tium/linux-teclast-p20hd.git \
    kernel/linux-teclast-p20hd
git commit -m "chore: add kernel submodule"
git push
```

### 4. Get Partition Numbers (Device Required)

```bash
adb shell ls -la /dev/block/platform/soc/soc:ap-ahb/20600000.sdio/by-name/
```

Then update `droidian/kernel/fixup-mountpoints.patch` with real values.

---

## Hardware Compatibility Matrix

| Component | Status | Driver | Notes |
|-----------|--------|--------|-------|
| Display (ILI9881C) | Untested | ili9881c | Panel init in DTB |
| Touch (FT5436) | Untested | focaltech | Firmware extracted |
| WiFi | Untested | ? | Need to identify |
| Bluetooth | Untested | ? | Need to identify |
| GPU (GE8322) | Untested | pvrsrvkm | Firmware extracted |
| Audio | Untested | ? | VBC eq extracted |
| Accelerometer | Untested | ? | Need to identify |
| Camera | Untested | ? | Low priority |

---

## Risk Register

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Kernel doesn't boot | High | Medium | Serial console debugging, reference A03 kernel |
| PowerVR GPU issues | High | Medium | Use software rendering as fallback |
| Panel init fails | High | Low | Extract sequences from stock DTB |
| Touch miscalibrated | Medium | Low | Use calibration tools, check DTS |
| WiFi driver missing | Medium | Medium | Check vendor kernel for config |

---

## External Dependencies

| Dependency | URL | Purpose |
|------------|-----|---------|
| Samsung A03 Kernel | https://github.com/IverCoder/linux-android-samsung-a03 | Base kernel source |
| Halium Hybris Patches | https://github.com/halium/hybris-patches | Kernel patches |
| Droidian Build System | https://github.com/droidian/build | Boot image creation |
| Droidian Rootfs | https://images.droidian.org | Rootfs images |

---

## Success Criteria

**Minimum Viable Port (MVP):**
- [x] Bootloader unlocked
- [x] Kernel compiles successfully
- [ ] Kernel boots to initramfs
- [ ] Display shows content
- [ ] Touch input works
- [ ] Boots to Droidian UI
- [ ] WiFi connects

**Full Port:**
- [ ] All MVP criteria
- [ ] GPU acceleration
- [ ] Audio playback
- [ ] Bluetooth
- [ ] Sensors
- [ ] Stable for daily use

---

## Kernel Build Notes

### Build Environment
- **Container**: Ubuntu 22.04 (via distrobox `teclast-dev`)
- **Toolchain**: `aarch64-linux-gnu-` (GCC 11.4.0)
- **Cross-compile**: Yes (ARM64 on x86_64)

### Key Fixes Applied
| Issue | Fix | Files |
|-------|-----|-------|
| GCC 12+ -Werror failures | Disabled -Werror flags | `Makefile` |
| Trace header include paths | Use absolute paths | `sprd_dfs_trace.h`, `gsp_trace.h`, `sprd_ptm_trace.h` |
| Battery ID undefined | Added stubs for non-Samsung | `battery_id_via_adc.h` |
| sec_device_create undefined | Made sec_cmd conditional | `drivers/input/Makefile` |
| headset_notifier undefined | Wrapped with SC2730 guard | `bq2560x-charger.c` |
| sdio_pin undefined | Wrapped with WCN_BOOT guard | `sysfs.c` |
| ums9620 DTB missing includes | Disabled in DTS Makefile | `arch/arm64/boot/dts/sprd/Makefile` |

### Build Command
```bash
distrobox enter teclast-dev -- bash -c "
  export ARCH=arm64
  export CROSS_COMPILE=aarch64-linux-gnu-
  make teclast/p20hd_defconfig
  make -j$(nproc) Image.gz dtbs
"
```

---

*Last Updated: 2026-01-16*
