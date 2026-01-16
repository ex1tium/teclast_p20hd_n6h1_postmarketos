# Bringup Report (Teclast P20HD / Unisoc SC9863A)

**Generated:** 2026-01-16T02:39:00+02:00

**Project root:** `/home/ex1tium/projects/teclast_p20hd_n6h1_postmarketos`


---

## Host Environment

### Host uname


```
$ uname -a
Linux bazzite 6.17.7-ba22.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Dec 31 05:41:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```

### Host /etc/os-release

✅ **Found**


```
PRETTY_NAME="Ubuntu 22.04.5 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.5 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```


---

## Tooling Versions (sanity)

### adb (Android Debug Bridge — device communication tool)


```
$ adb --version
Android Debug Bridge version 1.0.41
Version 28.0.2-debian
Installed as /usr/lib/android-sdk/platform-tools/adb
```

### fastboot (Android Fastboot — bootloader flashing tool)


```
$ fastboot --version
fastboot version 28.0.2-debian
Installed as /usr/lib/android-sdk/platform-tools/fastboot
```

### dtc (Device Tree Compiler — DTB/DTS compiler/decompiler)


```
$ dtc --version
Version: DTC 1.6.1
```

### python3 (Python — scripting runtime)


```
$ python3 --version
Python 3.10.12
```

### simg2img (Sparse image converter — converts Android sparse images to raw)


```
$ /usr/bin/simg2img --help
Usage: simg2img <sparse_image_files> <raw_image_file>
```


---

## Boot Image Analysis (critical for image repacking)

✅ **Boot header parameters extracted**

### Boot Header Parameters


These values are required for `mkbootimg` when building postmarketOS boot images:


```
HEADER_VERSION=2
BASE=00000000
PAGESIZE=2048
KERNEL_OFFSET=00008000
RAMDISK_OFFSET=05400000
TAGS_OFFSET=00000100
CMDLINE=console=ttyS1,115200n8 buildvariant=user
RAMDISK_COMP=gzip
KERNEL_SIZE=16560140
RAMDISK_SIZE=783810
```

### mkbootimg Command Template


Use this template for building postmarketOS boot images:


```bash
# See boot_header.txt for full mkbootimg command
```

✅ **Kernel version extracted**

### Stock Kernel Version



```
Linux version 4.14.133 (yhg225@yk225) (Android (5484270 based on r353983c) clang version 9.0.3 (https://android.googlesource.com/toolchain/clang 745b335211bb9eadfa6aa6301f84715cee4b37c5) (https://android.googlesource.com/toolchain/llvm 60cf23e54e46c807513f7a36d0a7b777920b5881) (based on LLVM 9.0.3svn)) #1 SMP PREEMPT Sat Oct 23 15:42:51 CST 2021
```

**Kernel:** `4.14.133` (Android downstream kernel)


---

## Device Identity (from getprop if available)

✅ **getprop dump found**

### Key properties (ro.boot / ro.product / ro.hardware)

✅ **Found matches**


```
209:[ro.boot.avb_version]: [1.1]
210:[ro.boot.boot_devices]: [soc/soc:ap-ahb/20600000.sdio]
211:[ro.boot.bootreason]: [bootloader]
212:[ro.boot.ddrsize]: [4096M]
213:[ro.boot.ddrsize.range]: [[2048,)]
214:[ro.boot.dtbo_idx]: [0]
215:[ro.boot.dynamic_partitions]: [true]
216:[ro.boot.flash.locked]: [1]
217:[ro.boot.hardware]: [s9863a1h10]
218:[ro.boot.serialno]: [51830042830977]
219:[ro.boot.vbmeta.avb_version]: [1.1]
220:[ro.boot.vbmeta.device_state]: [locked]
221:[ro.boot.vbmeta.digest]: [288267447839b018502a04e7c05593f973bfd836cd42d2a94af9842bc40006be]
222:[ro.boot.vbmeta.hash_alg]: [sha256]
223:[ro.boot.vbmeta.invalidate_on_error]: [yes]
224:[ro.boot.vbmeta.size]: [38592]
225:[ro.boot.verifiedbootstate]: [green]
226:[ro.boot.veritymode]: [enforcing]
288:[ro.hardware.egl]: [POWERVR_ROGUE]
308:[ro.product.board]: [sp9863a_1h10]
309:[ro.product.brand]: [Teclast]
310:[ro.product.build.date]: [Fri Jul 10 19:07:45 CST 2020]
311:[ro.product.build.date.utc]: [1594379265]
312:[ro.product.build.fingerprint]: [Teclast/P20HD_EEA/P20HD_EEA:10/QP1A.190711.020/26621:user/release-keys]
313:[ro.product.build.id]: [QP1A.190711.020]
314:[ro.product.build.tags]: [release-keys]
315:[ro.product.build.type]: [user]
316:[ro.product.build.version.incremental]: [26621]
317:[ro.product.build.version.release]: [10]
318:[ro.product.build.version.sdk]: [29]
319:[ro.product.cpu.abi]: [arm64-v8a]
320:[ro.product.cpu.abilist]: [arm64-v8a,armeabi-v7a,armeabi]
321:[ro.product.cpu.abilist32]: [armeabi-v7a,armeabi]
322:[ro.product.cpu.abilist64]: [arm64-v8a]
323:[ro.product.device]: [P20HD_EEA]
324:[ro.product.first_api_level]: [29]
325:[ro.product.hardware]: [s9863a1h10]
326:[ro.product.locale]: [en-US]
327:[ro.product.manufacturer]: [Teclast]
328:[ro.product.model]: [P20HD_EEA]
329:[ro.product.name]: [P20HD_EEA]
330:[ro.product.odm.brand]: [Teclast]
331:[ro.product.odm.device]: [P20HD_EEA]
332:[ro.product.odm.manufacturer]: [Teclast]
333:[ro.product.odm.model]: [P20HD_EEA]
334:[ro.product.odm.name]: [P20HD_EEA]
335:[ro.product.product.brand]: [Teclast]
336:[ro.product.product.device]: [P20HD_EEA]
337:[ro.product.product.manufacturer]: [Teclast]
338:[ro.product.product.model]: [P20HD_EEA]
339:[ro.product.product.name]: [P20HD_EEA]
340:[ro.product.system.brand]: [Teclast]
341:[ro.product.system.device]: [P20HD_EEA]
342:[ro.product.system.manufacturer]: [Teclast]
343:[ro.product.system.model]: [P20HD_EEA]
344:[ro.product.system.name]: [P20HD_EEA]
345:[ro.product.vendor.brand]: [Teclast]
346:[ro.product.vendor.device]: [P20HD_EEA]
347:[ro.product.vendor.manufacturer]: [Teclast]
348:[ro.product.vendor.model]: [P20HD_EEA]
349:[ro.product.vendor.name]: [P20HD_EEA]
```

### Build fingerprint + SDK + release

✅ **Found matches**


```
216:[ro.boot.flash.locked]: [1]
225:[ro.boot.verifiedbootstate]: [green]
312:[ro.product.build.fingerprint]: [Teclast/P20HD_EEA/P20HD_EEA:10/QP1A.190711.020/26621:user/release-keys]
317:[ro.product.build.version.release]: [10]
318:[ro.product.build.version.sdk]: [29]
```

### GPU / Graphics properties



```
[ro.board.platform]: [sp9863a]
[ro.hardware.egl]: [POWERVR_ROGUE]
[ro.opengles.version]: [196610]
```


---

## Partition Layout (from live device)

✅ **Partition layout collected from device**

Block device mapping from `/dev/block/by-name/`:


```
total 0
drwxr-xr-x 2 root root  920 2026-01-15 18:38 .
drwxr-xr-x 6 root root 1920 2026-01-15 18:38 ..
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 boot -> /dev/block/mmcblk0p28
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 cache -> /dev/block/mmcblk0p31
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 dtbo -> /dev/block/mmcblk0p29
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 fbootlogo -> /dev/block/mmcblk0p13
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 gnssmodem -> /dev/block/mmcblk0p18
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 l_deltanv -> /dev/block/mmcblk0p22
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 l_fixnv1 -> /dev/block/mmcblk0p14
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 l_fixnv2 -> /dev/block/mmcblk0p15
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 l_gdsp -> /dev/block/mmcblk0p23
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 l_ldsp -> /dev/block/mmcblk0p24
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 l_modem -> /dev/block/mmcblk0p21
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 l_runtimenv1 -> /dev/block/mmcblk0p16
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 l_runtimenv2 -> /dev/block/mmcblk0p17
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 logo -> /dev/block/mmcblk0p12
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 metadata -> /dev/block/mmcblk0p36
lrwxrwxrwx 1 root root   20 2026-01-15 18:38 misc -> /dev/block/mmcblk0p4
lrwxrwxrwx 1 root root   20 2026-01-15 18:38 miscdata -> /dev/block/mmcblk0p2
lrwxrwxrwx 1 root root   18 2026-01-15 18:38 mmcblk0 -> /dev/block/mmcblk0
lrwxrwxrwx 1 root root   23 2026-01-15 18:38 mmcblk0boot0 -> /dev/block/mmcblk0boot0
lrwxrwxrwx 1 root root   23 2026-01-15 18:38 mmcblk0boot1 -> /dev/block/mmcblk0boot1
lrwxrwxrwx 1 root root   22 2026-01-15 18:38 mmcblk0rpmb -> /dev/block/mmcblk0rpmb
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 odmko -> /dev/block/mmcblk0p33
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 persist -> /dev/block/mmcblk0p20
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 pm_sys -> /dev/block/mmcblk0p25
lrwxrwxrwx 1 root root   20 2026-01-15 18:38 prodnv -> /dev/block/mmcblk0p1
lrwxrwxrwx 1 root root   20 2026-01-15 18:38 recovery -> /dev/block/mmcblk0p3
lrwxrwxrwx 1 root root   20 2026-01-15 18:38 sml -> /dev/block/mmcblk0p7
lrwxrwxrwx 1 root root   20 2026-01-15 18:38 sml_bak -> /dev/block/mmcblk0p8
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 socko -> /dev/block/mmcblk0p32
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 super -> /dev/block/mmcblk0p30
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 sysdumpdb -> /dev/block/mmcblk0p37
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 teecfg -> /dev/block/mmcblk0p26
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 teecfg_bak -> /dev/block/mmcblk0p27
lrwxrwxrwx 1 root root   20 2026-01-15 18:38 trustos -> /dev/block/mmcblk0p5
lrwxrwxrwx 1 root root   20 2026-01-15 18:38 trustos_bak -> /dev/block/mmcblk0p6
lrwxrwxrwx 1 root root   20 2026-01-15 18:38 uboot -> /dev/block/mmcblk0p9
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 uboot_bak -> /dev/block/mmcblk0p10
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 uboot_log -> /dev/block/mmcblk0p11
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 userdata -> /dev/block/mmcblk0p40
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 vbmeta -> /dev/block/mmcblk0p34
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 vbmeta_bak -> /dev/block/mmcblk0p35
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 vbmeta_system -> /dev/block/mmcblk0p38
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 vbmeta_vendor -> /dev/block/mmcblk0p39
lrwxrwxrwx 1 root root   21 2026-01-15 18:38 wcnmodem -> /dev/block/mmcblk0p19
```

### Key partitions for porting


| Partition | Block Device | Purpose |
|-----------|--------------|---------|
| boot | /dev/block/mmcblk0p28 | Kernel + ramdisk |
| dtbo | /dev/block/mmcblk0p29 | Device tree overlays |
| l_modem | /dev/block/mmcblk0p21 | LTE modem firmware |
| persist | /dev/block/mmcblk0p20 | Persistent data (calibration) |
| recovery | /dev/block/mmcblk0p3 | Recovery mode image |
| super | /dev/block/mmcblk0p30 | Dynamic partitions (system/vendor/product) |
| userdata | /dev/block/mmcblk0p40 | User data partition |
| vbmeta | /dev/block/mmcblk0p34 | AVB verification metadata |
| vbmeta_system | /dev/block/mmcblk0p38 | System partition AVB |
| vbmeta_vendor | /dev/block/mmcblk0p39 | Vendor partition AVB |
| wcnmodem | /dev/block/mmcblk0p19 | WiFi/BT firmware |


---

## Loaded Kernel Modules (from live device)

✅ **Loaded modules collected from device**

Modules from `/sys/module/` — shows what kernel drivers are active:

### Hardware-critical modules



```
binder
binder_alloc
cfg80211
dpu_lite_r2p0
dpu_r3p0
dpu_r4p0
drm
drm_kms_helper
marlin
pvrsrvkm
rfkill
sprd_camera
sprd_cpp
sprd_dpu
sprd_flash_drv
sprd_fm
sprd_iq
sprd_sensor
sprdbt_tty
sprdwl_ng
```

### Full module list



```
binder
binder_alloc
block
brd
cfg80211
configfs
coresight_etm4x
cpufreq
cpuidle
cryptomgr
dm_bufio
dm_mod
dm_verity
dns_resolver
dpu_lite_r2p0
dpu_r3p0
dpu_r4p0
drm
drm_kms_helper
dummy
edac_core
ehci_hcd
emem
fb
firmware_class
flash_ic_sc2721
fscrypto
fuse
hid
hid_apple
hid_logitech
hid_logitech_hidpp
hid_magicmouse
hid_ntrig
hid_prodikeys
i2c_algo_bit
ims_bridge
ip6_tunnel
ipv6
kernel
l2tp_core
l2tp_ppp
loop
marlin
mmcblk
module
mousedev
musb_hdrc
nf_conntrack
nf_conntrack_amanda
nf_conntrack_ftp
nf_conntrack_h323
nf_conntrack_ipv4
nf_conntrack_irc
nf_conntrack_netbios_ns
nf_conntrack_sane
nf_conntrack_sip
nf_conntrack_tftp
otg_wakelock
overlay
ppp_generic
ppp_mppe
printk
process_reclaim
pstore
pvrsrvkm
r8152
ramoops
random
rc_core
rcupdate
rcutree
rfkill
sch_htb
scsi_mod
shub_core
sit
smsg
snd
snd_pcm
snd_timer
snd_usb_audio
sprd_camera
sprd_cpp
sprd_dpu
sprd_flash_drv
sprd_fm
sprd_iq
sprd_sensor
sprdbt_tty
sprdwl_ng
spurious
srcutree
suspend
sysrq
tcp_cubic
tcs3430
uinput
usb_storage
usbcore
usbhid
vmpressure
wacom
watchdog
workqueue
xt_quota2
```


---

## Kernel Command Line (bootargs)

### Saved boot cmdline (device-info/bootimg_cmdline.txt)

✅ **Found**


```
console=ttyS1,115200n8 buildvariant=user
```

### Saved /proc/cmdline (device-info/proc_cmdline.txt)

⚠️ **File exists but empty:** `/home/ex1tium/projects/teclast_p20hd_n6h1_postmarketos/device-info/proc_cmdline.txt`


---

## Device Tree (DTB — Device Tree Blob, hardware description)

✅ **DTB DTS found (trimmed)**

### DTB model / compatible

✅ **Found matches**


```
8:	model = "Spreadtrum SC9863A-1H10 Board";
9:	compatible = "sprd,sp9863a-1h10\0sprd,sc9863a";
50:		compatible = "simple-bus";
57:			compatible = "sprd,dbg-log-sharkl3";
73:			compatible = "syscon";
80:			compatible = "syscon";
87:			compatible = "syscon";
94:			compatible = "sprd,mailbox";
106:			compatible = "syscon";
113:			compatible = "syscon";
120:			compatible = "sprd,sharkl3-disp-domain";
129:			compatible = "syscon";
136:			compatible = "syscon";
143:			compatible = "syscon";
150:			compatible = "syscon";
157:			compatible = "syscon";
164:			compatible = "syscon";
171:			compatible = "syscon";
178:			compatible = "syscon";
185:			compatible = "syscon";
192:			compatible = "syscon";
199:			compatible = "syscon";
206:			compatible = "syscon";
213:			compatible = "syscon";
220:			compatible = "syscon";
227:			compatible = "syscon";
234:			compatible = "syscon";
241:			compatible = "syscon";
248:			compatible = "simple-bus";
254:				compatible = "sprd,sc9863-uart\0sprd,sc9836-uart";
264:				compatible = "sprd,sc9863-uart\0sprd,sc9836-uart";
274:				compatible = "sprd,sc9863-uart\0sprd,sc9836-uart";
284:				compatible = "sprd,sc9863-uart\0sprd,sc9836-uart";
294:				compatible = "sprd,sc9863-uart\0sprd,sc9836-uart";
304:				compatible = "sprd,sharkl3-i2c";
316:					compatible = "sprd,sensor-main";
332:					compatible = "sprd,sensor-sub";
349:				compatible = "sprd,sharkl3-i2c";
362:					compatible = "sprd,sensor-main2";
380:					compatible = "sprd,sensor-sub2";
```

### Touchscreen hints

✅ **Found matches**


```
421:				adaptive-touchscreen@38 {
423:					compatible = "adaptive-touchscreen";
434:				gslx680@40 {
435:					compatible = "gslx680,gslx680_ts";
```

### Display/Panel/DSI (Display Serial Interface — mobile display bus)

✅ **Found matches**


```
60:			sprd,syscon-dsi-apb = <0x03>;
1519:							regulator-name = "vddsim2";
1718:				compatible = "sprd,display-processor";
1815:			dsi@63100000 {
1816:				compatible = "sprd,dsi-host";
1821:				sprd,ip = "sprd,dsi-ctrl\0r3p0";
1854:				panel {
1855:					compatible = "sprd,generic-mipi-panel";
1876:				compatible = "sprd,dsi-phy";
3605:	lcds {
3607:		lcd_dummy_mipi_hd {
3608:			sprd,dsi-work-mode = <0x01>;
3609:			sprd,dsi-lane-number = <0x04>;
3610:			sprd,dsi-color-format = "rgb888";
3616:			display-timings {
3632:		lcd_nt35695_truly_mipi_fhd {
3633:			sprd,dsi-work-mode = <0x01>;
3634:			sprd,dsi-lane-number = <0x04>;
3635:			sprd,dsi-color-format = "rgb888";
3650:			display-timings {
3667:		lcd_nt35532_truly_mipi_fhd {
3668:			sprd,dsi-work-mode = <0x01>;
3669:			sprd,dsi-lane-number = <0x04>;
3670:			sprd,dsi-color-format = "rgb888";
3684:			display-timings {
3700:		lcd_nt35596_boe_mipi_fhd {
3701:			sprd,dsi-work-mode = <0x01>;
3702:			sprd,dsi-lane-number = <0x04>;
3703:			sprd,dsi-color-format = "rgb888";
3718:			display-timings {
3735:		lcd_sc9863a_ek79007_boe_4lane {
3736:			sprd,dsi-work-mode = <0x01>;
3737:			sprd,dsi-lane-number = <0x04>;
3738:			sprd,dsi-color-format = "rgb888";
3755:			display-timings {
3771:		lcd_sc9863_hjc_hx8279_mipi {
3772:			sprd,dsi-work-mode = <0x01>;
3773:			sprd,dsi-lane-number = <0x04>;
3774:			sprd,dsi-color-format = "rgb888";
3787:			display-timings {
3803:		lcd_sc9863a_jd9365_boe_sq_mipi {
3804:			sprd,dsi-work-mode = <0x01>;
3805:			sprd,dsi-lane-number = <0x04>;
3806:			sprd,dsi-color-format = "rgb888";
3823:			display-timings {
3839:		lcd_s9863a_fx_boe_9881c_mipi {
3840:			sprd,dsi-work-mode = <0x01>;
3841:			sprd,dsi-lane-number = <0x04>;
3842:			sprd,dsi-color-format = "rgb888";
3859:			display-timings {
3875:		lcd_s9863a_fx_boe_jd9365_mipi {
3876:			sprd,dsi-work-mode = <0x01>;
3877:			sprd,dsi-lane-number = <0x04>;
3878:			sprd,dsi-color-format = "rgb888";
3895:			display-timings {
3911:		lcd_sc9863_ota7290b_boe_fx_mipi {
3912:			sprd,dsi-work-mode = <0x01>;
3913:			sprd,dsi-lane-number = <0x04>;
3914:			sprd,dsi-color-format = "rgb888";
3927:			display-timings {
3943:		lcd_sc9863_qx_cpt_hx8279_mipi {
3944:			sprd,dsi-work-mode = <0x01>;
3945:			sprd,dsi-lane-number = <0x04>;
3946:			sprd,dsi-color-format = "rgb888";
3959:			display-timings {
3975:		lcd_sc9863_qc_hx8279_mipi {
3976:			sprd,dsi-work-mode = <0x01>;
3977:			sprd,dsi-lane-number = <0x04>;
3978:			sprd,dsi-color-format = "rgb888";
3991:			display-timings {
4319:	display-subsystem {
4320:		compatible = "sprd,display-subsystem";
4768:		vddsim2 = "/soc/aon/spi@41800000/pmic@0/power-controller@c00/LDO_VDDSIM2";
4796:		dsi = "/soc/mm/dsi@63100000";
4797:		dsi_out = "/soc/mm/dsi@63100000/ports/port@0/endpoint";
4798:		dsi_in = "/soc/mm/dsi@63100000/ports/port@1/endpoint";
4799:		panel = "/soc/mm/dsi@63100000/panel";
4800:		panel_in = "/soc/mm/dsi@63100000/panel/port/endpoint";
4933:		lcd_dummy_mipi_hd = "/lcds/lcd_dummy_mipi_hd";
4934:		lcd_nt35695_truly_mipi_fhd = "/lcds/lcd_nt35695_truly_mipi_fhd";
4935:		lcd_nt35695_fhd_timing0 = "/lcds/lcd_nt35695_truly_mipi_fhd/display-timings/timing0";
4936:		lcd_nt35532_truly_mipi_fhd = "/lcds/lcd_nt35532_truly_mipi_fhd";
4937:		lcd_nt35596_boe_mipi_fhd = "/lcds/lcd_nt35596_boe_mipi_fhd";
4938:		lcd_nt35596_fhd_timing0 = "/lcds/lcd_nt35596_boe_mipi_fhd/display-timings/timing0";
4939:		lcd_sc9863a_ek79007_boe_4lane = "/lcds/lcd_sc9863a_ek79007_boe_4lane";
4940:		lcd_sc9863_hjc_hx8279_mipi = "/lcds/lcd_sc9863_hjc_hx8279_mipi";
4941:		lcd_sc9863a_jd9365_boe_sq_mipi = "/lcds/lcd_sc9863a_jd9365_boe_sq_mipi";
4942:		lcd_s9863a_fx_boe_9881c_mipi = "/lcds/lcd_s9863a_fx_boe_9881c_mipi";
4943:		lcd_s9863a_fx_boe_jd9365_mipi = "/lcds/lcd_s9863a_fx_boe_jd9365_mipi";
4944:		lcd_sc9863_ota7290b_boe_fx_mipi = "/lcds/lcd_sc9863_ota7290b_boe_fx_mipi";
4945:		lcd_sc9863_qx_cpt_hx8279_mipi = "/lcds/lcd_sc9863_qx_cpt_hx8279_mipi";
4946:		lcd_sc9863_qc_hx8279_mipi = "/lcds/lcd_sc9863_qc_hx8279_mipi";
```

### WiFi/BT (Bluetooth — short-range radio) / WCN (Wireless Connectivity Node)

✅ **Found matches**


```
530:				sprd,dai_name = "i2s_bt_sco0";
706:				sprd,name = "sdio_wifi";
742:				sprd,iis_bt_fm_loop = <0x03 0x04>;
743:				pinctrl-names = "vbc_iis1_0\0ap_iis0_0\0ap_iis1_0\0tgdsp_iis0_0\0tgdsp_iis1_0\0pubcp_iis0_0\0vbc_iis1_3\0ap_iis0_3\0tgdsp_iis0_3\0tgdsp_iis1_3\0pubcp_iis0_3\0wcn_iis0_3\0vbc_iis1_4\0ap_iis0_4\0tgdsp_iis0_4\0tgdsp_iis1_4\0pubcp_iis0_4\0wcn_iis0_4\0iis_bt_fm_loop_3_4_enable\0iis_bt_fm_loop_3_4_disable";
881:				wcn-alpha@14 {
886:				wcn-beta@18 {
891:				wcn-gamma@1c {
896:				wcn-delta@20 {
1561:							regulator-name = "vddwifipa";
3191:	cpwcn_btwf {
3193:		sprd,name = "wcn_btwf";
3197:		sprd,syscon-anlg-wrap-wcn = <0xb2>;
3198:		sprd,syscon-wcn-reg = <0xb3>;
3214:		sprd,file-name = "/dev/block/platform/soc/soc:ap-ahb/20600000.sdio/by-name/wcnmodem";
3217:		vddwcn-supply = <0xb5>;
3218:		vddwifipa-supply = <0xb6>;
3222:		nvmem-cell-names = "wcn_efuse_blk0\0wcn_efuse_blk1\0wcn_efuse_blk2";
3226:	cpwcn_gnss {
3228:		sprd,name = "wcn_gnss";
3232:		sprd,syscon-anlg-wrap-wcn = <0xb2>;
3233:		sprd,syscon-wcn-reg = <0xb3>;
3253:		vddwcn-supply = <0xb5>;
3261:	wcn_sipc {
3265:			sprd,name = "sipc-wcn";
3279:	wcn_spipe {
3282:		spipe_cpwcn {
3283:			sprd,name = "spipe_wcn";
3301:	wcn_wifi_cmd {
3302:		compatible = "sprd,swcnblk";
3303:		sprd,name = "wcn_wifi_cmd";
3312:	wcn_wifi_data0 {
3313:		compatible = "sprd,swcnblk";
3314:		sprd,name = "wcn_wifi_data0";
3323:	wcn_wifi_data1 {
3324:		compatible = "sprd,swcnblk";
3325:		sprd,name = "wcn_wifi_data1";
3334:	wcn_bt {
3335:		compatible = "sprd,wcn_internal_chip";
3343:	wcn_fm {
3344:		compatible = "sprd,wcn_internal_chip";
4372:		wcn-mem@84000000 {
4472:		sprd,btwf-file-name = "/dev/block/platform/soc/soc:ap-ahb/20600000.sdio/by-name/wcnmodem";
4481:		compatible = "sprd,sc2355-wifi";
4639:		anlg_wrap_wcn_regs = "/soc/syscon@40366000";
4640:		wcn_regs = "/soc/syscon@403a0000";
4694:		wcn_alpha = "/soc/aon/efuse@40240000/wcn-alpha@14";
4695:		wcn_beta = "/soc/aon/efuse@40240000/wcn-beta@18";
4696:		wcn_gamma = "/soc/aon/efuse@40240000/wcn-gamma@1c";
4697:		wcn_delta = "/soc/aon/efuse@40240000/wcn-delta@20";
4714:		wcn_iis0_3 = "/soc/aon/pinctrl@402a0000/iismtx-inf3-11";
4720:		wcn_iis0_4 = "/soc/aon/pinctrl@402a0000/iismtx-inf4-11";
4773:		vddwifipa = "/soc/aon/spi@41800000/pmic@0/power-controller@c00/LDO_VDDWIFIPA";
4911:		wcn_btwf = "/cpwcn_btwf";
4912:		wcn_gnss = "/cpwcn_gnss";
4913:		sipc2 = "/wcn_sipc/sipc@84180000";
4914:		sipc3 = "/wcn_sipc/sipc@8441b000";
4968:		wcn_reserved = "/reserved-memory/wcn-mem@84000000";
```


---

## DTBO Overlays (DTBO — Device Tree Blob Overlays, board-specific patches)

✅ **DTBO overlays extracted (1 overlays)**

### Extracted overlays directory

✅ **Found** (3 files)


```
total 16K
drwxr-xr-x. 1 ex1tium ex1tium  236 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium  200 Jan 16 02:38 ..
-rw-r--r--. 1 ex1tium ex1tium 2.1K Jan 16 02:38 dtbo_000_id00000000_rev00000000.dtb
-rw-r--r--. 1 ex1tium ex1tium 2.3K Jan 16 02:38 dtbo_000_id00000000_rev00000000.dts
-rw-r--r--. 1 ex1tium ex1tium  947 Jan 16 02:38 dtbo_000_id00000000_rev00000000.dts.warnings.txt
```

#### Overlay compatibles (quick scan)


```
- **dtbo_000_id00000000_rev00000000.dts**
  11:				compatible = "microarray,afs121";
  16:				compatible = "pwm-backlight";

```


---

## Ramdisk init artifacts (init — Android init config, fstab — mount rules)

✅ **Ramdisk init extraction found**

### Ramdisk init extraction root

✅ **Found** (2 files)


```
total 8.0K
drwxr-xr-x. 1 ex1tium ex1tium   66 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium  200 Jan 16 02:38 ..
drwxr-xr-x. 1 ex1tium ex1tium   32 Jan 16 02:38 fstab
drwxr-xr-x. 1 ex1tium ex1tium    0 Jan 16 02:38 init
-rw-r--r--. 1 ex1tium ex1tium 1.2K Jan 16 02:38 ramdisk_index.txt
drwxr-xr-x. 1 ex1tium ex1tium    0 Jan 16 02:38 ueventd
```

ℹ️ **No init*.rc scripts in ramdisk** (normal for Android 10+ first_stage_mount)

### init scripts

ℹ️ **Directory empty** (expected)


```
total 0
drwxr-xr-x. 1 ex1tium ex1tium  0 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium 66 Jan 16 02:38 ..
```

✅ **fstab files found (1 files)**

### fstab files

✅ **Found** (1 files)


```
total 4.0K
drwxr-xr-x. 1 ex1tium ex1tium  32 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium  66 Jan 16 02:38 ..
-rw-r-----. 1 ex1tium ex1tium 560 Jan 16 02:38 fstab.s9863a1h10
```

### fstab content (fstab.s9863a1h10)


This file defines how partitions are mounted during boot:


```
#Dynamic partitions fstab file
#<dev> <mnt_point> <type> <mnt_flags options>  <fs_mgr_flags>

system /system ext4 ro,barrier=1 wait,avb=vbmeta_system,logical,first_stage_mount,avb_keys=/avb/q-gsi.avbpubkey:/avb/r-gsi.avbpubkey:/avb/s-gsi.avbpubkey
vendor /vendor ext4 ro,barrier=1 wait,avb=vbmeta_vendor,logical,first_stage_mount
product /product ext4 ro,barrier=1 wait,avb=vbmeta,logical,first_stage_mount
/dev/block/platform/soc/soc:ap-ahb/20600000.sdio/by-name/metadata /metadata    ext4 nodev,noatime,nosuid,errors=panic wait,formattable,first_stage_mount
```

ℹ️ **No ueventd*.rc in ramdisk** (normal for Android 10+ first_stage_mount)

### ueventd rules

ℹ️ **Directory empty** (expected)


```
total 0
drwxr-xr-x. 1 ex1tium ex1tium  0 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium 66 Jan 16 02:38 ..
```

### init: services summary (service …)


```
```

### init: mount_all usage


```
```

### fstab: first_stage_mount flags


```
./fstab.s9863a1h10:4:system /system ext4 ro,barrier=1 wait,avb=vbmeta_system,logical,first_stage_mount,avb_keys=/avb/q-gsi.avbpubkey:/avb/r-gsi.avbpubkey:/avb/s-gsi.avbpubkey
./fstab.s9863a1h10:5:vendor /vendor ext4 ro,barrier=1 wait,avb=vbmeta_vendor,logical,first_stage_mount
./fstab.s9863a1h10:6:product /product ext4 ro,barrier=1 wait,avb=vbmeta,logical,first_stage_mount
./fstab.s9863a1h10:7:/dev/block/platform/soc/soc:ap-ahb/20600000.sdio/by-name/metadata /metadata    ext4 nodev,noatime,nosuid,errors=panic wait,formattable,first_stage_mount
```


---

## Dynamic Partitions (super.img — contains system/vendor/product as logical partitions)

ℹ️ **super.img not present** (already extracted via lpunpack — this is expected)

✅ **Logical partitions extracted (3 partitions)**

### Extracted logical partitions (lpunpack output)

✅ **Found** (3 files)


```
total 3.0G
drwxr-xr-x. 1 ex1tium ex1tium   62 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium  200 Jan 16 02:38 ..
-rw-r--r--. 1 ex1tium ex1tium 1.5G Jan 16 02:38 product.img
-rw-r--r--. 1 ex1tium ex1tium 1.2G Jan 16 02:38 system.img
-rw-r--r--. 1 ex1tium ex1tium 343M Jan 16 02:38 vendor.img
```

### List extracted *.img partitions


```
-rw-r--r--. 1 ex1tium ex1tium 1.5G Jan 16 02:38 product.img
-rw-r--r--. 1 ex1tium ex1tium 1.2G Jan 16 02:38 system.img
-rw-r--r--. 1 ex1tium ex1tium 343M Jan 16 02:38 vendor.img
```


---

## Vendor blobs (vendor — hardware userspace drivers/firmware)

✅ **Vendor blobs directory exists**

### Vendor blobs root

✅ **Found** (9 files)


```
total 12K
drwxr-xr-x. 1 ex1tium ex1tium   48 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium  200 Jan 16 02:38 ..
-rw-r--r--. 1 ex1tium ex1tium 4.4K Jan 16 02:38 build.prop
drwxr-xr-x. 1 ex1tium ex1tium   10 Jan 16 02:38 etc
drwxr-xr-x. 1 ex1tium ex1tium  214 Jan 16 02:38 firmware
drwxr-xr-x. 1 ex1tium ex1tium   14 Jan 16 02:38 lib
```

✅ **vendor/build.prop found**

### vendor/build.prop key properties


Hardware and platform identification from vendor partition:


```properties
ro.vendor.product.cpu.abilist=arm64-v8a,armeabi-v7a,armeabi
ro.vendor.product.cpu.abilist32=armeabi-v7a,armeabi
ro.vendor.product.cpu.abilist64=arm64-v8a
ro.product.board=sp9863a_1h10
ro.board.platform=sp9863a
ro.product.vendor.brand=Teclast
ro.product.vendor.device=P20HD_EEA
ro.product.vendor.manufacturer=Teclast
ro.product.vendor.model=P20HD_EEA
ro.product.vendor.name=P20HD_EEA
ro.vendor.product.partitionpath=/dev/block/platform/soc/soc:ap-ahb/20600000.sdio/by-name/
ro.vendor.modem.dev=/proc/cptl/
ro.vendor.modem.tty=/dev/stty_lte
ro.vendor.modem.eth=seth_lte
ro.vendor.modem.snd=1
ro.vendor.modem.diag=/dev/sdiag_lte
ro.vendor.modem.log=/dev/slog_lte
ro.vendor.modem.loop=/dev/spipe_lte0
ro.vendor.modem.nv=/dev/spipe_lte1
ro.vendor.modem.assert=/dev/spipe_lte2
ro.vendor.modem.fixnv_size=0x100000
ro.vendor.modem.runnv_size=0x120000
ro.vendor.modem.support=1
ro.vendor.wcn.hardware.product=marlin3
ro.vendor.wcn.hardware.etcpath=/vendor/etc
ro.vendor.gnsschip=marlin3
ro.vendor.modem.wcn.enable=1
ro.vendor.modem.wcn.diag=/dev/slog_wcn0
ro.vendor.modem.wcn.id=1
ro.vendor.modem.wcn.count=1
```


✅ **vendor/firmware found (6 files)**

### vendor/firmware

✅ **Found** (6 files)


```
total 272K
drwxr-xr-x. 1 ex1tium ex1tium  214 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium   48 Jan 16 02:38 ..
-rw-r--r--. 1 ex1tium ex1tium  11K Jan 16 02:38 EXEC_CALIBRATE_MAG_IMAGE
-rw-r--r--. 1 ex1tium ex1tium  81K Jan 16 02:38 faceid.elf
-rw-r--r--. 1 ex1tium ex1tium  51K Jan 16 02:38 focaltech-FT5x46.bin
-rw-r--r--. 1 ex1tium ex1tium    0 Jan 16 02:38 rgx.fw.22.86.104.218
-rw-r--r--. 1 ex1tium ex1tium 124K Jan 16 02:38 rgx.fw.signed.22.86.104.218
-rw-r--r--. 1 ex1tium ex1tium    0 Jan 16 02:38 vbc_eq
```

### Firmware files inventory


These files are needed for hardware initialization (GPU, WiFi, sensors, etc.):


```
drwxr-xr-x. 1 ex1tium ex1tium    214 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium     48 Jan 16 02:38 ..
-rw-r--r--. 1 ex1tium ex1tium  11248 Jan 16 02:38 EXEC_CALIBRATE_MAG_IMAGE
-rw-r--r--. 1 ex1tium ex1tium  82244 Jan 16 02:38 faceid.elf
-rw-r--r--. 1 ex1tium ex1tium  51228 Jan 16 02:38 focaltech-FT5x46.bin
-rw-r--r--. 1 ex1tium ex1tium      0 Jan 16 02:38 rgx.fw.22.86.104.218
-rw-r--r--. 1 ex1tium ex1tium 126976 Jan 16 02:38 rgx.fw.signed.22.86.104.218
-rw-r--r--. 1 ex1tium ex1tium      0 Jan 16 02:38 vbc_eq
```

ℹ️ **vendor/lib/modules empty** (monolithic kernel — drivers built into kernel, not as modules)

### vendor/lib/modules

ℹ️ **Directory empty** (expected)


```
total 0
drwxr-xr-x. 1 ex1tium ex1tium  0 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium 14 Jan 16 02:38 ..
```

✅ **vendor/etc/vintf found (2 files)**

### vendor/etc/vintf

✅ **Found** (2 files)


```
total 20K
drwxr-xr-x. 1 ex1tium ex1tium   72 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium   10 Jan 16 02:38 ..
-rw-r--r--. 1 ex1tium ex1tium 2.0K Jan 16 02:38 compatibility_matrix.xml
-rw-r--r--. 1 ex1tium ex1tium  13K Jan 16 02:38 manifest.xml
```

### VINTF manifest HAL summary


Hardware Abstraction Layers (HALs) declared by vendor — critical for hardware support:


```
| HAL Name | Version | Interface |
|----------|---------|-----------|
| IDevicesFactory | 5.0 | @5.0::IDevicesFactory/default |
| IEffectsFactory | 5.0 | @5.0::IEffectsFactory/default |
| IBluetoothHci | 1.0 | @1.0::IBluetoothHci/default |
| IBluetoothAudioProvidersFactory | 2.0 | @2.0::IBluetoothAudioProvidersFactory/default |
| IBroadcastRadio | 2.0 | @2.0::IBroadcastRadio/default |
| ICameraProvider | 2.4 | @2.4::ICameraProvider/legacy/0 |
| ISurfaceFlingerConfigs | 1.1 | @1.1::ISurfaceFlingerConfigs/default |
| IDrmFactory | 1.0 | @1.0::ICryptoFactory/default |
| IDrmFactory | 1.0 | @1.0::IDrmFactory/default |
| IDrmFactory | 1.0 | @1.2::ICryptoFactory/clearkey |
| IDrmFactory | 1.0 | @1.2::ICryptoFactory/widevine |
| IDrmFactory | 1.0 | @1.2::IDrmFactory/clearkey |
| IDrmFactory | 1.0 | @1.2::IDrmFactory/widevine |
| IGatekeeper | 1.0 | @1.0::IGatekeeper/default |
| IGnss | 1.1 | @1.1::IGnss/default |
| IGnss | 2.0 | @2.0::IGnss/default |
| IAllocator | 2.0 | @2.0::IAllocator/default |
| IComposer | 2.1 | @2.1::IComposer/default |
| IMapper | 2.1 | @2.1::IMapper/default |
| IHealth | 2.0 | @2.0::IHealth/default |
| IKeymasterDevice | 4.0 | @4.0::IKeymasterDevice/default |
| ILight | 2.0 | @2.0::ILight/default |
| IOmxStore | 1.0 | @1.0::IOmx/default |
| IOmxStore | 1.0 | @1.0::IOmxStore/default |
| IMemtrack | 1.0 | @1.0::IMemtrack/default |
| IPower | 1.3 | @1.3::IPower/default |
| IDevice | 1.0 | @1.0::IDevice/default |
| ISensors | 1.0 | @1.0::ISensors/default |
| ISoundTriggerHw | 2.0 | @2.0::ISoundTriggerHw/default |
| IUsb | 1.1 | @1.1::IUsb/default |
| IVibrator | 1.0 | @1.0::IVibrator/default |
| IWifi | 1.3 | @1.3::IWifi/default |
| IHostapd | 1.1 | @1.1::IHostapd/default |
| ISupplicant | 1.2 | @1.2::ISupplicant/default |
| IAprdInfoSync | 1.0 | @1.0::IAprdInfoSync/default |
| IConnmgr | 1.0 | @1.0::IConnmgr/default |
| IConnectControl | 1.0 | @1.0::IConnectControl/default |
| IEnhance | 1.0 | @1.0::IEnhance/default |
| ILogControl | 1.0 | @1.0::ILogControl/default |
| INetworkControl | 1.0 | @1.0::INetworkControl/default |
```

### Vendor-specific HALs (Spreadtrum/Unisoc)



```
vendor.sprd.hardware.aprd
vendor.sprd.hardware.connmgr
vendor.sprd.hardware.cplog_connmgr
vendor.sprd.hardware.enhance
vendor.sprd.hardware.log
vendor.sprd.hardware.network
vendor.sprd.hardware.power
vendor.sprd.hardware.thermal
vendor.sprd.hardware.wifi.hostapd
```


---

## AVB / vbmeta inventory (AVB — Android Verified Boot, verification metadata)

✅ **vbmeta images found (3 files)**

### vbmeta images in backup/

✅ **Found** (7 files)


```
total 63M
drwxr-xr-x. 1 ex1tium ex1tium  226 Jan 16 02:38 .
drwxr-xr-x. 1 ex1tium ex1tium  330 Jan 16 02:37 ..
-rw-r--r--. 1 ex1tium ex1tium  35M Jan 16 02:38 boot-stock.img
-rw-r--r--. 1 ex1tium ex1tium 8.0M Jan 16 02:38 dtbo.img
-rw-r--r--. 1 ex1tium ex1tium  19M Jan 16 02:38 dtb-stock-trimmed.dtb
-rw-r--r--. 1 ex1tium ex1tium 171K Jan 16 02:38 dtb-stock-trimmed.dts
-rw-r--r--. 1 ex1tium ex1tium 1.0M Jan 16 02:38 vbmeta-sign.img
-rw-r--r--. 1 ex1tium ex1tium 4.0K Jan 16 02:38 vbmeta_system.img
-rw-r--r--. 1 ex1tium ex1tium 4.0K Jan 16 02:38 vbmeta_vendor.img
```

### vbmeta checksums


```
b2eae2954847900dcc268b58f3348e45adb1656c255347448181431ec24876cc  /home/ex1tium/projects/teclast_p20hd_n6h1_postmarketos/backup/vbmeta-sign.img
e9ae6676bfbe51477065467d8e14f5331c33e036621c8e1326fc38b0c45560fa  /home/ex1tium/projects/teclast_p20hd_n6h1_postmarketos/backup/vbmeta_system.img
01003e9575081114ba5c277eed48a16b999182aaeffbdfa142fc10990c6de111  /home/ex1tium/projects/teclast_p20hd_n6h1_postmarketos/backup/vbmeta_vendor.img

```


---

## High-signal bringup conclusions

- **SoC (System on Chip — CPU/GPU/IO package):** Unisoc/Spreadtrum **SC9863A**
- **Board string:** `s9863a1h10` (from ro.boot.hardware)
- **Android version:** Android 10 (SDK 29) (from ro.product.build.version.*)
- **Dynamic partitions:** enabled (super.img present + ro.boot.dynamic_partitions=true)
- **Bootloader locked:** ro.boot.flash.locked=1 (expect restrictions)
- **DTB base model:** "Spreadtrum SC9863A-1H10 Board" (from extracted DTB)


---

## 📋 postmarketOS Porting Readiness Summary


### ✅ Found Artifacts (20)

- ✅ Boot image header
- ✅ Kernel version
- ✅ Device properties (getprop)
- ✅ Partition layout
- ✅ Loaded kernel modules
- ✅ Boot cmdline
- ✅ DTB DTS (trimmed)
- ✅ DTB model/compatible
- ✅ Touchscreen DTB nodes
- ✅ Display DTB nodes
- ✅ WiFi/BT DTB nodes
- ✅ DTBO overlays
- ✅ Ramdisk extraction
- ✅ fstab files
- ✅ Super partitions (lpunpack)
- ✅ Vendor blobs directory
- ✅ vendor/build.prop
- ✅ Vendor firmware
- ✅ Vendor VINTF manifest
- ✅ vbmeta images

### ❌ Missing Artifacts (0)

_All tracked items present!_

### ⚠️ Warnings (0)

_No warnings._


---

## 🚀 Porting Readiness & Action Items


### ✅ Ready for Porting

These essentials are confirmed and ready:

| Requirement | Status | Notes |
|-------------|--------|-------|
| SoC identified | ✅ | Unisoc SC9863A (sharkl3 platform) |
| DTB/DTS extracted | ✅ | Device tree from boot.img |
| Partition layout | ✅ | super.img with system/vendor/product |
| Boot cmdline | ✅ | Kernel parameters known |
| fstab | ✅ | Mount points defined |
| Vendor manifest | ✅ | HAL interfaces documented |

### 🔧 Action Items

Issues requiring attention (if any):

_No action items — all artifacts extracted successfully!_

### ℹ️ Expected Warnings (No Action Needed)

These warnings are **normal for Android 10+** devices and don't require fixes:

| Warning | Explanation |
|---------|-------------|
| Init scripts empty | Android 10+ uses first_stage_mount; init.rc lives in system.img |
| Ueventd rules empty | Same reason; postmarketOS uses udev anyway |
| super.img not present | Normal — deleted after successful lpunpack extraction |
| vendor/lib/modules empty | Monolithic kernel — drivers built-in, not as modules |

### 🎯 postmarketOS Porting Checklist

With the extracted artifacts, you can now:

1. **Create device package** — Use DTB model/compatible strings for `deviceinfo`
2. **Configure kernel** — Reference loaded modules list for required drivers
3. **Package firmware** — Copy from `extracted/vendor_blobs/firmware/` to `linux-firmware`
4. **Identify panel** — Grep DTS for `panel` or `dsi` compatible strings
5. **Identify touchscreen** — Firmware shows `focaltech-FT5x46.bin` (Focaltech FT5x46)
6. **GPU driver** — PowerVR Rogue (rgx.fw.signed) — needs proprietary blob packaging


---

## 📁 Appendix: Artifact Locations


| Artifact | Path | Status |
|----------|------|--------|
| Boot image | `backup/boot-stock.img` | ✅ |
| DTBO image | `backup/dtbo.img` | ✅ |
| DTB (trimmed) | `backup/dtb-stock-trimmed.dtb` | ✅ |
| DTS (decompiled) | `backup/dtb-stock-trimmed.dts` | ✅ |
| vbmeta images | `backup/vbmeta*.img` | ✅ (3 files) |
| Boot header info | `extracted/bootimg_info/` | ✅ |
| Extracted DTBs | `extracted/dtb_from_bootimg/` | ✅ (1 files) |
| DTBO overlays | `extracted/dtbo_split/` | ✅ (1 files) |
| Super partitions | `extracted/super_lpunpack/` | ✅ (3 partitions) |
| Vendor blobs | `extracted/vendor_blobs/` | ✅ |
| Ramdisk init | `extracted/ramdisk_init/` | ✅ |

