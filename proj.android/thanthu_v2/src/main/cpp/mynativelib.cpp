#include <jni.h>
#include <string>
#include <android/log.h>

#define  LOG_TAG    "CCEnhanceAPI_android Debug"
#define  LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)
//#include "platform/android/CCApplication-android.h"
#include "platform/CCFileUtils.h"

//extern "C" JNIEXPORT jstring JNICALL
//Java_com_tianji_mynativelib_NativeLib_stringFromJNI(
//        JNIEnv* env,
//        jobject /* this */) {
//    std::string hello = "Hello from C++";
////    cocos2d::FileUtils::getInstance()->getContents("login_updater.json", &hello);
//    return env->NewStringUTF(hello.c_str());
//}
extern "C"
JNIEXPORT void JNICALL
Java_com_tianji_mynativelib_NativeLib_stringFromJNI(JNIEnv *env, jclass clazz) {
    LOGD("idk Hello from C++");
//    std::string hello;
//    cocos2d::FileUtils::getInstance()->getContents("common_prompt_box.json", &hello);
//    LOGD("idk common_prompt_box: '%s'", hello.c_str());
}