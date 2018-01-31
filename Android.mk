LOCAL_PATH := $(call my-dir)

ifeq ($(filter tuna maguro toro toroplus,$(TARGET_DEVICE)),)

include $(CLEAR_VARS)
LOCAL_MODULE       := Chromium

ifeq ($(shell test $(PLATFORM_SDK_VERSION) -ge 23 || echo 1),)
# minSdkVersion=23 (Marshmallow)
LOCAL_SRC_FILES    := ChromeModernPublic.apk
else
# minSdkVersion=16 (Jelly Bean)
LOCAL_SRC_FILES    := ChromePublic/ChromePublic.apk
ifeq ($(shell test $(PLATFORM_SDK_VERSION) -ge 21 || echo 1),)
# required for Lollipop
LOCAL_PREBUILT_JNI_LIBS_arm := @lib/armeabi-v7a/libchrome.so
LOCAL_PREBUILT_JNI_LIBS_arm += @lib/armeabi-v7a/libchromium_android_linker.so
else
LOCAL_REQUIRED_MODULES := libchrome libchromium_android_linker
endif
endif

LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := APPS
LOCAL_CERTIFICATE   := PRESIGNED
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_MULTILIB := 32
include $(BUILD_PREBUILT)

# KitKat Compatibility
ifneq ($(shell test $(PLATFORM_SDK_VERSION) -ge 21 || echo 1),)
include $(CLEAR_VARS)
LOCAL_MODULE := libchrome
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := ChromePublic/lib/armeabi-v7a/libchrome.so
LOCAL_MODULE_TAGS := optional
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libchromium_android_linker
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := ChromePublic/lib/armeabi-v7a/libchromium_android_linker.so
LOCAL_MODULE_TAGS := optional
include $(BUILD_PREBUILT)
endif

endif
