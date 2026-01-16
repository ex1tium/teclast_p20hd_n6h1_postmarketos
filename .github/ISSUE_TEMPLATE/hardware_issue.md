---
name: Hardware Issue
about: Report a hardware component not working
title: '[HW] '
labels: 'type/bug, status/needs-device'
assignees: ''
---

## Component
- [ ] Display (ILI9881C)
- [ ] Touch (FocalTech FT5436)
- [ ] WiFi
- [ ] Bluetooth
- [ ] GPU (PowerVR GE8322)
- [ ] Audio
- [ ] Sensors
- [ ] Other: ___

## Symptom
Describe what's not working.

## Current Status
- **Driver loaded?** [ ] Yes / [ ] No / [ ] Unknown
- **Firmware present?** [ ] Yes / [ ] No / [ ] N/A
- **Device node exists?** (e.g., `/dev/input/event*`, `/dev/dri/*`)

## Diagnostic Commands Run

### lsmod (relevant modules)
```
Paste output
```

### dmesg | grep <component>
```
Paste output
```

### ls -la /dev/<relevant>
```
Paste output
```

## Device Tree Node
If applicable, paste the relevant DTS node from the extracted device tree.

```dts
Paste DTS snippet
```

## Attempted Fixes
What have you already tried?

## Reference
- Does this work on Samsung A03 Droidian? [ ] Yes / [ ] No / [ ] Unknown
- Link to any relevant upstream issues:
