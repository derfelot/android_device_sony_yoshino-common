#
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PLATFORM_PATH := device/sony/yoshino-common

### BOARD
BOARD_USES_QCOM_HARDWARE := true
BOARD_VENDOR := sony
TARGET_BOARD_PLATFORM := msm8998
TARGET_BOARD_PLATFORM_GPU := qcom-adreno540

### PROCESSOR
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a73

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a73

### KERNEL
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CLANG_VERSION := 6.0.2
TARGET_KERNEL_VERSION := 4.4
TARGET_KERNEL_SOURCE  := kernel/sony/msm8998
TARGET_COMPILE_WITH_MSM_KERNEL := true

# Taken from unpacked stock boot.img / README_Xperia in Kernel source
BOARD_KERNEL_CMDLINE += user_debug=31
BOARD_KERNEL_CMDLINE += ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += sched_enable_hmp=1
BOARD_KERNEL_CMDLINE += sched_enable_power_aware=1
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += swiotlb=2048
BOARD_KERNEL_CMDLINE += androidboot.configfs=true
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a800000.dwc3
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += zram.backend=z3fold
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

# See README_Xperia in Kernel Source
BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096

BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb

### PARTITIONS
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ROOT_EXTRA_FOLDERS := ocm

# Build ext4 tools - system/vold
TARGET_USERIMAGES_USE_EXT4 := true

### VENDOR SECURITY PATCH LEVEL
VENDOR_SECURITY_PATCH := 2019-09-01

PRODUCT_FULL_TREBLE_OVERRIDE := false

### RECOVERY

ifneq ($(filter maple maple_dsds, $(TARGET_DEVICE)),)
    TARGET_RECOVERY_FSTAB := $(PLATFORM_PATH)/recovery/twrp_maple.fstab
    TARGET_COPY_OUT_VENDOR := system/vendor
else
    TARGET_RECOVERY_FSTAB := $(PLATFORM_PATH)/recovery/twrp.fstab
    TARGET_COPY_OUT_VENDOR := vendor
endif

BOARD_NEEDS_VENDORIMAGE_SYMLINK := false

# INIT
TW_EXCLUDE_DEFAULT_USB_INIT := true
TARGET_RECOVERY_DEVICE_MODULES := init.recovery.usb.rc

# Install kernel modules to root directory
NEED_KERNEL_MODULE_ROOT := true

# QCOM
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_NEW_ION_HEAP := true

### SCREEN BRIGHTNESS
TW_BRIGHTNESS_PATH := /sys/class/leds/wled/brightness
TW_MAX_BRIGHTNESS := 4095
TW_DEFAULT_BRIGHTNESS := 1600

TW_CUSTOM_CPU_TEMP_PATH := /sys/class/thermal/thermal_zone4/temp

# Add logcat support
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# Use toolbox instead of busybox
TW_USE_TOOLBOX := true

# Does not allow to partition the sdcard
BOARD_HAS_NO_REAL_SDCARD := true
# Media on data partition
RECOVERY_SDCARD_ON_DATA := true

# ENCRYPTED FILESYSTEMS
TARGET_HW_DISK_ENCRYPTION := true
TW_INCLUDE_CRYPTO := true
ifneq ($(filter lilac poplar poplar_canada poplar_dsds, $(TARGET_DEVICE)),)
    # ext4 file based crypto
    TW_INCLUDE_CRYPTO_FBE := true
endif
TARGET_CRYPTFS_HW_PATH := vendor/qcom/opensource/commonsys/cryptfs_hw

# QSEECOMD DEPENDENCIES
TARGET_RECOVERY_DEVICE_MODULES      += libxml2.so
TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(PRODUCT_OUT)/system/lib64/libxml2.so

TARGET_RECOVERY_DEVICE_MODULES      += libicuuc.so
TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(PRODUCT_OUT)/system/lib64/libicuuc.so

# KEYMASTER DEPENDENCIES
TARGET_RECOVERY_DEVICE_MODULES      += libion.so
TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(PRODUCT_OUT)/system/lib64/libion.so

TARGET_RECOVERY_DEVICE_MODULES      += android.hardware.weaver@1.0
TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(PRODUCT_OUT)/system/lib64/android.hardware.weaver@1.0.so

# F2FS SUPPORT
CM_PLATFORM_SDK_VERSION := 3
TARGET_USERIMAGES_USE_F2FS := true

# TWRP FEATURES
TW_EXCLUDE_SUPERSU := true
TW_EXTRA_LANGUAGES := true

TW_THEME := portrait_hdpi

# Use a future date for the security patchlevel.  As TWRP doesn't do key
# upgrades it should just be fine using it for decryption.
PLATFORM_SECURITY_PATCH := 2025-12-31

PLATFORM_VERSION := 16.1.0
