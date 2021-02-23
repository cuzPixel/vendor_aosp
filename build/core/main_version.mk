# Build fingerprint
ifeq ($(BUILD_FINGERPRINT),)
BUILD_NUMBER_CUSTOM := $(shell date -u +%m%d%H%M)
ifneq ($(filter user,$(TARGET_BUILD_VARIANT)),)
BUILD_SIGNATURE_KEYS := release-keys
else
BUILD_SIGNATURE_KEYS := test-keys
endif
BUILD_FINGERPRINT := $(PRODUCT_BRAND)/$(TARGET_DEVICE)/$(TARGET_DEVICE):$(PLATFORM_VERSION)/$(BUILD_ID)/$(BUILD_NUMBER_CUSTOM):$(TARGET_BUILD_VARIANT)/$(BUILD_SIGNATURE_KEYS)
endif
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)

# AOSP recovery flashing
ifeq ($(TARGET_USES_AOSP_RECOVERY),true)
ADDITIONAL_BUILD_PROPERTIES += \
    persist.sys.recovery_update=true
endif

# Branding
CUSTOM_ROM_VERSION ?= 11.2.4

CUSTOM_DATE_YEAR := $(shell date -u +%Y)
CUSTOM_DATE_MONTH := $(shell date -u +%m)
CUSTOM_DATE_DAY := $(shell date -u +%d)
CUSTOM_BUILD_DATE := $(CUSTOM_DATE_YEAR)$(CUSTOM_DATE_MONTH)$(CUSTOM_DATE_DAY)

CUSTOM_VERSION_PROP := 11.0

TARGET_PRODUCT_SHORT := $(subst aosp_,,$(CUSTOM_BUILD))

CUSTOM_VERSION := cuzPixel-$(CUSTOM_VERSION_PROP)-$(CUSTOM_BUILD_DATE)-$(CUSTOM_BUILD)-v$(CUSTOM_ROM_VERSION)

ADDITIONAL_BUILD_PROPERTIES += \
    org.cuzpixel.version=$(CUSTOM_VERSION_PROP) \
    org.cuzpixel.version.custom=$(CUSTOM_ROM_VERSION) \
    org.cuzpixel.version.display=$(CUSTOM_VERSION) \
    org.cuzpixel.build_date=$(CUSTOM_BUILD_DATE) \
    org.cuzpixel.build_type=$(TARGET_BUILD_VARIANT)
