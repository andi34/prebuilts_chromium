LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE       := Chromium

ifeq ($(shell test $(PLATFORM_SDK_VERSION) -ge 21 || echo 1),)
# minSdkVersion=21 (Lollipop)
LOCAL_SRC_FILES    := ChromeModernPublic.apk
else
# minSdkVersion=16 (Jelly Bean)
LOCAL_SRC_FILES    := ChromePublic.apk
endif

LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := APPS
LOCAL_CERTIFICATE   := PRESIGNED
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_OVERRIDES_PACKAGES := Browser Browser2
LOCAL_MULTILIB := 32
include $(BUILD_PREBUILT)
