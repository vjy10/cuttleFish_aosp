#
# Copyright (C) 2019 The Android Open Source Project
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

PRODUCT_MANIFEST_FILES += device/google/cuttlefish/shared/config/product_manifest.xml
SYSTEM_EXT_MANIFEST_FILES += device/google/cuttlefish/shared/config/system_ext_manifest.xml
# Permission to access services for phone
LOCAL_HARDWARE_PERMISSIONS_PRODUCT_PACKAGE := com.google.cf_handheld.hardware.core_permissions

PRODUCT_MAX_PAGE_SIZE_SUPPORTED := 65536

$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_vendor.mk)

$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product, device/google/cuttlefish/shared/bluetooth/device_vendor.mk)
$(call inherit-product, device/google/cuttlefish/shared/camera/device_vendor.mk)
$(call inherit-product, device/google/cuttlefish/shared/graphics/device_vendor.mk)
$(call inherit-product, device/google/cuttlefish/shared/swiftshader/device_vendor.mk)
$(call inherit-product, device/google/cuttlefish/shared/telephony/device_vendor.mk)
$(call inherit-product, device/google/cuttlefish/shared/virgl/device_vendor.mk)
$(call inherit-product, device/google/cuttlefish/shared/device.mk)

PRODUCT_EXTRA_VNDK_VERSIONS := 29 30 31

TARGET_PRODUCT_PROP := $(LOCAL_PATH)/product.prop

# Runtime Resource Overlays
PRODUCT_PACKAGES += com.google.aosp_cf_phone.rros


TARGET_BOARD_INFO_FILE ?= device/google/cuttlefish/shared/phone/android-info.txt
