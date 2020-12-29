//
// Created by mactty on 2020/12/28.
//

#include "jni.h"
#include <stdio.h>

void dynamicNative1(JNIEnv *env, jobject jobj) {
    printf("dynamicNative1 动态注册.");
}

jstring dynamicNative2(JNIEnv *env, jobject jobj, jint i) {
    return (*env)->NewStringUTF(env, "我是动态注册的dynamicNative2方法");
}


//需要动态注册native方法的类名
static const char *class_name = "register/DynamicRegister";
//需要动态注册的方法数组
static const JNINativeMethod methods[] = {
        {"dynamicRegister", "()V",                   (void *) dynamicNative1},
        {"dynamicRegister", "(I)Ljava/lang/String;", (jstring *) dynamicNative2}
};

JNIEXPORT jint JNICALL
JNI_OnLoad(JavaVM *vm, void *reserved) {
    printf("hello dynamic0");
    JNIEnv *env = NULL;
    //获得 JniEnv
    int r = (*vm)->GetEnv(vm, (void **) &env, JNI_VERSION_1_4);
    if (r != JNI_OK) {
        return -1;
    }
    jclass class = (*env)->FindClass(env, class_name);
    // 注册 如果小于0则注册失败
    r = (*env)->RegisterNatives(env, class, methods, 2);
    if (r != JNI_OK) {
        return -1;
    }
    printf("hello dynamic");
    return JNI_VERSION_1_4;
}

