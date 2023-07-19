#
# Copyright (C) 2023 The Android Open Source Project
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
#

#
# All components inherited here go to system image (same as GSI system)
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_system.mk)

PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := relaxed

#
# All components inherited here go to system_ext image (same as GSI system_ext)
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system_ext.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system_ext.mk)

#
# All components inherited here go to product image (same as GSI product)
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)

#
# All components inherited here go to vendor image
#
LOCAL_PREFER_VENDOR_APEX := true
$(call inherit-product, device/google/cuttlefish/shared/phone/device_vendor.mk)

# TODO: Nested virtualization support
# $(call inherit-product, packages/modules/Virtualization/apex/product_packages.mk)

#
# Special settings for the target
#
$(call inherit-product, device/google/cuttlefish/vsoc_riscv64/bootloader.mk)

# Exclude features that are not available on AOSP devices.
ifeq ($(LOCAL_PREFER_VENDOR_APEX),true)
PRODUCT_PACKAGES += com.google.aosp_cf_phone.hardware.core_permissions
else
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/aosp_excluded_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/aosp_excluded_hardware.xml
endif

# TODO(b/206676167): This property can be removed when renderscript is removed.
# Prevents framework from attempting to load renderscript libraries, which are
# not supported on this architecture.
PRODUCT_SYSTEM_PROPERTIES += \
    config.disable_renderscript=1 \

# TODO(b/271573990): This property can be removed when ART support for JIT on
# this architecture is available. This is an override as the original property
# is defined in runtime_libart.mk.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.usejit=false

PRODUCT_NAME := aosp_cf_riscv64_phone
PRODUCT_DEVICE := vsoc_riscv64
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Cuttlefish riscv64 phone

# Window sidecar and extensions to enhance activity embedding, multi-display,
# tablet, and foldable support.
PRODUCT_PACKAGES += \
    androidx.window.extensions \
    androidx.window.sidecar \

PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=$(PRODUCT_MANUFACTURER) \
    ro.soc.model=$(PRODUCT_DEVICE)
