//
// Created by mactty on 2020/12/28.
//

#include "register_StaticRegister.h"
#include <iostream>
#include <cstdio>

JNIEXPORT jstring JNICALL Java_register_StaticRegister_hello
        (JNIEnv *env, jobject jObject) {
    return env->NewStringUTF("Hello,I'm from JNI.");
}

//字符串拼接
JNIEXPORT jstring JNICALL Java_string_StringTest_sayHello
        (JNIEnv *env, jclass jclz, jstring jstr) {
    const char *pt;
    pt = env->GetStringUTFChars(jstr, nullptr);
    if (pt == nullptr) {
        return nullptr;
    }
    char dis_str[128];
    sprintf(dis_str, "<%s>您好，欢迎来到JNI的世界~~~", pt);
    env->ReleaseStringUTFChars(jstr, pt);//释放内存
    return env->NewStringUTF(dis_str);
}
//JNI访问Java非静态成员变量
JNIEXPORT void JNICALL Java_clz_FieldTest_getField
        (JNIEnv *env, jobject obj) {
    //获取Class对象
    jclass clz = env->GetObjectClass(obj);
    //获取FieldId对象
    jfieldID fieldId = env->GetFieldID(clz, "property", "I");
    //获取value值
    jint value = env->GetIntField(obj, fieldId);
    printf("property value is %d\n", value);
    //设置value
    env->SetIntField(obj, fieldId, value + 1000);

}
//JNI访问Java静态成员变量
JNIEXPORT void JNICALL Java_clz_FieldTest_getStaticField
        (JNIEnv *env, jobject obj) {
    //获取Class对象 或 env->FindClass("xxx)
    jclass clz = env->GetObjectClass(obj);
    //获取FieldId对象
    jfieldID fieldId = env->GetStaticFieldID(clz, "staProperty", "I");
    //获取value值
    jint value = env->GetStaticIntField(clz, fieldId);
    printf("staProperty value is %d\n", value);
    //设置value
    env->SetStaticIntField(clz, fieldId, value + 1000);
}

//JNI访问Java成员方法
JNIEXPORT void JNICALL Java_clz_MethodTest_nativeCallInstanceMethod
        (JNIEnv *env, jobject jObj, jstring jStr, jint jInt) {
    //获取Class
    jclass cls = env->FindClass("clz/MethodTest");
    if (cls == nullptr) {
        printf("MethodTest is null.");
        return;
    }
    //获取默认构造方法MethodId
    jmethodID constructorId = env->GetMethodID(cls, "<init>", "()V");
    if (constructorId == nullptr) {
        printf("constructorId is null");
        return;
    }
    //调用构造函数创建实例
    jobject instance = env->NewObject(cls, constructorId);
    //获得调用方法的MethodId
    jmethodID callInstanceMethod = env->GetMethodID(cls, "callInstanceMethod", "(Ljava/lang/String;I)V");
    //创建方法参数
    jstring str = env->NewStringUTF("hello from JNI.");
    //调用实例方法
    env->CallVoidMethod(instance, callInstanceMethod, str, 100);

    //删除对象
    env->DeleteLocalRef(cls);
    env->DeleteLocalRef(instance);
    env->DeleteLocalRef(str);

}


JNIEXPORT jstring JNICALL Java_clz_MethodTest_nativeCallInstanceMethod1
        (JNIEnv *env, jobject jObj, jstring jStr, jint jInt) {
    //获取Class
    jclass cls = env->FindClass("clz/MethodTest");
    if (cls == nullptr) {
        printf("MethodTest is null.");
        return nullptr;
    }
    //获取默认构造方法MethodId
    jmethodID constructorId = env->GetMethodID(cls, "<init>", "()V");
    if (constructorId == nullptr) {
        printf("constructorId is null");
        return nullptr;
    }
    //调用构造函数创建实例
    jobject instance = env->NewObject(cls, constructorId);
    //获得调用方法的MethodId
    jmethodID callInstanceMethod = env->GetMethodID(cls, "callInstanceMethod1",
                                                    "(Ljava/lang/String;I)Ljava/lang/String;");
    //调用实例方法
    jobject ret = env->CallObjectMethod(instance, callInstanceMethod, jStr, 100);

    //删除对象
    env->DeleteLocalRef(cls);
    env->DeleteLocalRef(instance);

    return jstring(ret);
}

//JNI访问Java静态方法
JNIEXPORT void JNICALL Java_clz_MethodTest_nativeCallStaticMethod
        (JNIEnv *env, jobject jObj, jstring jStr, jint jInt) {
    //获取Class
    jclass cls = env->FindClass("clz/MethodTest");
    if (cls == nullptr) {
        printf("MethodTest is null.");
        return;
    }
    //获得调用方法的MethodId
    jmethodID callStaticMethod = env->GetStaticMethodID(cls, "callStaticMethod", "(Ljava/lang/String;I)V");
    //创建方法参数
    jstring str = env->NewStringUTF("hello from JNI.");
    //调用实例方法
    env->CallStaticVoidMethod(cls, callStaticMethod, str, 100);

    //删除对象
    env->DeleteLocalRef(str);
    env->DeleteLocalRef(cls);
}

static jclass cls_string = nullptr;
static jmethodID cid_string = nullptr;
//野指针问题
JNIEXPORT jstring JNICALL Java_ref_Reference_newString
        (JNIEnv *env, jobject jObj, jint len) {
    jcharArray elemArray;
    jstring j_str;
    //定义静态的局部变量
    static jclass cls_string = nullptr;
    if (cls_string == nullptr) {
        printf("cls_string is null\n");
        cls_string = env->FindClass("java/lang/String");
        if (cls_string == nullptr) {
            return nullptr;
        }
    }
    if (cid_string == nullptr) {
        printf("cid_string is null\n");
        cid_string = env->GetMethodID(cls_string, "<init>", "([C)V");
        if (cls_string == nullptr) {
            return nullptr;
        }
    }

    printf("this is a line -------------\n");
    elemArray = env->NewCharArray(len);
    j_str = jstring(env->NewObject(cls_string, cid_string, elemArray));//
    env->DeleteLocalRef(elemArray);

    env->DeleteLocalRef(cls_string);
    cls_string = nullptr;
    //env->DeleteLocalRef(cid_string);此处的 delete不能存在，因为 cid_string不是jobject，应用只需要对object类型的引用而言的
    cid_string = nullptr;

    printf("end of function \n");
    return j_str;

}

JNIEXPORT void JNICALL Java_ref_Reference_JCall
        (JNIEnv *env, jobject jObj) {
    Java_ref_Reference_newString(env, jObj, 1024);
}


