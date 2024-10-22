LOCAL_PATH := $(call my-dir)

# include $(CLEAR_VARS)
# LOCAL_MODULE := cocos2dluar-prebuilt
# LOCAL_SRC_FILES := ./libcocos2dluar.so
# # LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/..
# include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := mynativelib
LOCAL_SRC_FILES := mynativelib.cpp
# LOCAL_SHARED_LIBRARIES := cocos2dluar-prebuilt
include $(BUILD_SHARED_LIBRARY)
