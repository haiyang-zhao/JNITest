[TOC]
# 什么是JNI
> JNi就是java调用本地方法的技术，最简单的来说，java运行一个程序需要要和不同的系统平台打交道，在windows里 就是和windows平台底层打交道，mac就是要和mac打交道，jvm就是通过大量的jni技术使得java能够在不同平台上 运行。

使用了这技术的一个标志就是native,如果一个类里的一个方法被native修饰，那就说明这个方法是jni来实现的，他是 通过本地系统api里的方法来实现的。当然这个本地方法可能是c或者C++，当然也可能是别的语言。jni是java跨平台 的基础，jvm通过在不同系统上调用不同的本地方法使得jvm可以在不同平台间移植。

如下图所示

![04ac6da11968f9ad7ff4f2123ca78a52.png](evernotecid://8A2485BE-7365-4851-A3F6-97FBC9BCC325/appyinxiangcom/23840206/ENResource/p177)

* 上图中有一处不太严谨的地方，那便是(C/C++)，如果是mac os那就不能说是C/C++了，但是在Android系统中我 们只能用C/C++。

## Java和C/C++ 中的基本类型的映射关系
> JNI是接口语言，因而，会有一个中间的转型过程，在这个过程中，有一个非常重要的也是非常关键的类型对接方
式，这个方式便是，数据类型的转变，下表给出了相关的对于的数据格式。

下表中的数据为JNI基本数据类型及对应的长度:
![51d5c94edb4c27e2162e19b97be4139a.png](evernotecid://8A2485BE-7365-4851-A3F6-97FBC9BCC325/appyinxiangcom/23840206/ENResource/p189)


# 动态库和静态库
> Android NDK种的动态库和静态库就是linux下的动态库和静态库，因为NDK的开发可以理解从基于Linux的开发。
在平时工作中我们经常把一些常用的函数或者功能封装为一个个库供给别人使用，java开发我们可以封装为jar包提供 给别人用，安卓平台后来可以打包成aar包，同样的，C/C++中我们封装的功能或者函数可以通过静态库或者动态库 的方式提供给别人使用。

* **Linux平台静态库以.a结尾，而动态库以.so结尾。**
  要分析链接库首先要分析交叉编译

## 什么是交叉编译
> 交叉编译就是在A平台编译出可以在B平台执行的文件，对于我们安卓开发者来说交叉编译就是在window或者mac或 者linux系统上编译出可在安卓系统上运行的可执行文件，什么时候需要用到交叉编译呢?音视频开发基本都会用到 ffmpeg，opengl es等三方库，这时我们就需要在window或者mac或者linux系统上编译出可在安卓系统执行的文 件，这里可编译出静态库或者动态库使用，这时候就会用到交叉编译。

* 交叉编译的目的很清楚，就是编译出除了自己平台意外其他平台可以用的库的过程。那么在Android 平台的代码， 由于Android平台是基于linux，因此很多Android 中可以运行的库就是在linux中编译的，或者是在mac上面编 译，而在windows上面编译就比较难了。那么到底什么是动态库和静态库呢?

## 动态库和静态库(共享库)
### 静态库

> 这类库的名字一般是libxxx.a;利用静态函数库编译成的文件比较大，因为整个 函数库的所有数据都会被整合进目标 代码中，他的优点就显而易见了，即编译后的执行程序不需要外部的函数库支持，因为所有使用的函数都已经被编译 进去了。当然这也会成为他的缺点，因为如果静态函数库改变了，那么你的程序必须重新编译。

### 动态库

> 这类库的名字一般是libxxx.so;相对于静态函数库，动态函数库在编译的时候 并没有被编译进目标代码中，你的程序 执行到相关函数时才调用该函数库里的相应函数，因此动态函数库所产生的可执行文件比较小。由于函数库没有被整 合进你的程序，而是程序运行时动态的申请并调用，所以程序的运行环境中必须提供相应的库。动态函数库的改变并 不影响你的程序，所以动态函数库的升级比较方便

***静态库的代码在编译过程中已经被载入可执行程序,因此体积比较大;动态库(共享库)的代码在可执行程序运行时才载 入内存，在编译过程中仅简单的引用，因此代码体积比较小。***

### Android如何配置cmakelist.txt 配置编译动态库和静态库
```c
add_library(jinInterface SHARED library.c library.h)// SHARED 表示是动态库 add_library(jinInterface STATIC library.c library.h)// STATIC 表示是静态库 ADD_LIBRARY(...)
语法:ADD_LIBRARY(libname [SHARED|STATIC] )
上面的表达式等同于:
set(LIB_SRC library.c library.h)
add_library(jinInterface SHARED ${LIB_SRC})
```

# JNI 静态注册与动态注册

## 静态注册
步骤
### 1、编写Java类
```java
package register;

public class StaticRegister {
    public native String hello();
}
```

### 2、使用javac编译,生成class文件
```bash
➜  register javac StaticRegister.java 
➜  register ls
StaticRegister.class StaticRegister.java
```

### 3、使用javah 生成h文件

```bash
➜  register javah --help
Usage: 
  javah [options] <classes>
where [options] include:
  -o <file>                Output file (only one of -d or -o may be used)
  -d <dir>                 Output directory
  -v  -verbose             Enable verbose output
  -h  --help  -?           Print this message
  -version                 Print version information
  -jni                     Generate JNI-style header file (default)
  -force                   Always write output files
  -classpath <path>        Path from which to load classes
  -cp <path>               Path from which to load classes
  -bootclasspath <path>    Path from which to load bootstrap classes
<classes> are specified with their fully qualified names
(for example, java.lang.Object).

```

在src目录下执行javah register.StaticRegister命令会生成头文件register_StaticRegister.h
```bash
➜  src javah register.StaticRegister
➜  src ls
register                  register_StaticRegister.h
➜  src
```

### 4、编写xxx_JniTest.c 源文件，并拷贝xxx_JniTest.h 下的函数，并实现这些函数，且在其中添加jni.h头文件；
Clion中创建C++ Library工程，Library Type选择shared共享库
![6b5be4366d6636c2bcf5fe9a9a08bd87.png](evernotecid://8A2485BE-7365-4851-A3F6-97FBC9BCC325/appyinxiangcom/23840206/ENResource/p978)@w=1000

拷贝 register_StaticRegister.h文件

jni.h和jni_md.h在下面目录找
/Library/Java/JavaVirtualMachines/jdk1.8.0_261.jdk/Contents/Home

![d46799b7417508dde7c76ddd1806b940.png](evernotecid://8A2485BE-7365-4851-A3F6-97FBC9BCC325/appyinxiangcom/23840206/ENResource/p979)@w=500

![791ba6e9803409b0ab4c8112c1255b41.png](evernotecid://8A2485BE-7365-4851-A3F6-97FBC9BCC325/appyinxiangcom/23840206/ENResource/p982)
@w=1000

### 5、编写 cmakelist.txt 文件，编译生成动态/静态链接库

CMakeLists.txt
```
add_library(JNITest SHARED register_StaticRegister.cpp register_StaticRegister.h)
```
make project后在/cmake-build-debug/目录下生成libJNITest.dylib文件

![466a5817b3bd8b553facf1324e914690.png](evernotecid://8A2485BE-7365-4851-A3F6-97FBC9BCC325/appyinxiangcom/23840206/ENResource/p983)@w=500

### 6、Java代码使用System.load()加载

```java
public class StaticRegister {
    public native String hello();

    public static void main(String[] args) {
        System.out.println(new StaticRegister().hello());
    }

    static {
        System.load("/Users/mactty/workspace/study/JNITest/cmake-build-debug/libJNITest.dylib");
    }
}
```

## 动态注册
在此之前我们一直在jni中使用的 Java_PACKAGENAME_CLASSNAME_METHODNAME 来进行与java方法的匹配，这
种方式我们称之为静态注册。

而动态注册则意味着方法名可以不用这么长了，在android aosp源码中就大量的使用了动态注册的形式

### 1、java中声明native方法
```java
package register;

public class DynamicRegister {
    public native void dynamicRegister();

    public native String dynamicRegister(int value);
}
```

### 2、编写动态注册c代码

```c
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
```

# System.load()、System.loadLibray()的区别

## System.load() 参数必须为库文件的绝对路径
例如:
System.load("C:\Documents and Settings\TestJNI.dll"); //Windows
System.load("/usr/lib/TestJNI.so"); //Linux

```java
//System.java
@CallerSensitive
public static void load(String filename) {
    Runtime.getRuntime().load0(Reflection.getCallerClass(), filename);
}

//Runtime.java
synchronized void load0(Class<?> fromClass, String filename) {
    SecurityManager security = System.getSecurityManager();
    if (security != null) {
        security.checkLink(filename);
    }
    if (!(new File(filename).isAbsolute())) {//不是绝对路径就抛异常
        throw new UnsatisfiedLinkError(
            "Expecting an absolute path of the library: " + filename);
    }
    ClassLoader.loadLibrary(fromClass, filename, true);
}
```
## System.loadLibrary() 参数为库文件名，不包含库文件的扩展名
例如:
System.loadLibrary ("TestJNI"); //加载Windows下的TestJNI.dll本地库
System.loadLibrary ("TestJNI"); //加载Linux下的libTestJNI.so本地库

```java
//System.java
@CallerSensitive
public static void loadLibrary(String libname) {
    Runtime.getRuntime().loadLibrary0(Reflection.getCallerClass(), libname);
}
//Runtime.java
synchronized void loadLibrary0(Class<?> fromClass, String libname) {
    SecurityManager security = System.getSecurityManager();
    if (security != null) {
        security.checkLink(libname);
    }
    if (libname.indexOf((int)File.separatorChar) != -1) {//不能包含路径分隔符
        throw new UnsatisfiedLinkError(
"Directory separator should not appear in library name: " + libname);
    }
    ClassLoader.loadLibrary(fromClass, libname, false);
}
```

注意：**TestJNI.dll 或 libTestJNI.so 必须是在JVM属性java.library.path所指向的路径中。**
loadLibary需要配置当前项目的java.library.path 路径，具体办法如：[java no XXX in java.library.path怎么配置](https://zhidao.baidu.com/question/1241601021778319299.html)

# JNIEnv类型和jobject类型的解释
```c++
JNIEXPORT void JNICALL Java_com_jni_demo_JNIDemo_sayHello (JNIEnv * env, jobject obj) {          printf(hello); 
}
```

这里JNIEXPORT 与 JNICALL 都是JNI的关键字，表示此函数是要被JNI调用的.

## JNIEnv* env参数的解释

> JNIEnv类型实际上代表了Java环境，通过这个JNIEnv* 指针，就可以对Java端的代码进行操作。例如，创建Java类中
的对象，调用Java对象的方法，获取Java对象中的属性等等。JNIEnv的指针会被JNI传入到本地方法的实现函数中来对
Java端的代码进行操作。如下代码所示

```c
#ifdef __cplusplus
typedef JNIEnv_ JNIEnv;
#else
typedef const struct JNINativeInterface_ *JNIEnv;
#endif

...
struct JNIInvokeInterface_;
...
struct JNINativeInterface_ {
    void *reserved0;
    void *reserved1;
    void *reserved2;

    void *reserved3;
    
    //全是函数指针
    jint (JNICALL *GetVersion)(JNIEnv *env);

    jclass (JNICALL *DefineClass)
      (JNIEnv *env, const char *name, jobject loader, const jbyte *buf,
       jsize len);
    jclass (JNICALL *FindClass)
      (JNIEnv *env, const char *name);

    jmethodID (JNICALL *FromReflectedMethod)
      (JNIEnv *env, jobject method);
    jfieldID (JNICALL *FromReflectedField)
      (JNIEnv *env, jobject field);
    ....\
}
```

可以看到如果是C语言JNIEnv 是JNINativeInterface_类型的指针，如果是c++语言JNIEnv是JNIEnv_
调用方式有所区别

```c
/*
 * We use inlined functions for C++ so that programmers can write:
 *
 *    env->FindClass("java/lang/String")
 *
 * in C++ rather than:
 *
 *    (*env)->FindClass(env, "java/lang/String")
 *
 * in C.
 */
```

## 参数:jobject obj的解释

* 如果native方法不是static的话，这个obj就代表这个native方法的类实例。
* 如果native方法是static的话，这个obj就代表这个native方法的类的class对象实例(static方法不需要类实例的，所
  以就代表这个类的class对象)。

```java
public native void test(); 
public static native void testStatic();
```
生成的jni头文件

```c
JNIEXPORT void JNICALL Java_Hello_test (JNIEnv *, jobject); 
JNIEXPORT void JNICALL Java_Hello_testStatic (JNIEnv *, jclass);

```

# C/C++代码调用Java代码

上面讲解的大多数内容用于阐述java调用C/C++端代码，然而在JNI中还有 一个非常重要的内容，那便是在C/C++本地
代码中访问Java端的代码，一个常见的应用就是获取类的属性和调用类的方法，为了在C/C++中表示属性和方法，JNI
在jni.h头文件中定义了jfieldId,jmethodID类型来分别代表Java端的属性和方法。

我们在访问，或者设置Java属性的时候，首先就要先在本地代码取得代表该Java属性的jfieldID,然后才能在本地代码
中进行Java属性操作，同样的，我们需要呼叫Java端的方法时，也是需要取得代表该方法的jmethodID才能进行Java
方法调用。

使用JNIEnv的：
* GetFieldID/GetMethodID
* GetStaticFieldID/GetStaticMethodID

来取得相应的jfieldID和jmethodID。


```c
/**
* clazz:这个简单就是这个方法依赖的类对象的class对象 
* name:这个是这个字段的名称 
* sign:这个是这个字段的签名(我们知道每个变量，每个方法都是有签名的)
*/
GetFieldID(jclass clazz,const char* name,const char* sign) 
```

## 签名问题

### 怎么查看类中的字段和方法的签名

方法一：使用Javap命令

```
javap -s -p xxx
```

![b1d7860d1c7c66f1335eb7e3d0588fab.png](evernotecid://8A2485BE-7365-4851-A3F6-97FBC9BCC325/appyinxiangcom/23840206/ENResource/p988)@w=1000

方法二：idea上使用ASM反编译工具

![e98106249ed5e81cdd55918eaf724e65.png](evernotecid://8A2485BE-7365-4851-A3F6-97FBC9BCC325/appyinxiangcom/23840206/ENResource/p989)=1000

方法三：手写


#### 基本数据类型的转换


| Java | Native | Signature |
| --- | --- | --- |
| byte |  jbyte| B |
|  char|  jchar| C |
| double |  jdouble| D |
| float | jfloat | F |
| int | jint |I  |
| short | jshort |S  |
| long |  jlong|  J|
| boolean | jboolean |Z  |
|  void| void | V |

#### 引用数据类型的转换
| Java | Native | Signature |
| --- | --- | --- |
| 所有对象	 |  jobject| L+classname +; |
|  Class|  jclass| Ljava/lang/Class; |
| String |  jstring| Ljava/lang/String; |
| Throwable | jthrowable | Ljava/lang/Throwable; |
| Object[]	 | jobjectArray |[L+classname +;|
| byte[]	 | jbyteArray |[B |
| char[]	 |  jcharArray|  [C|
| double[]	 | jdoubleArray |[D |
| float[]	 | jfloatArray | [F |
| int[]		 | jintArray | [I |
| short[]	 | jshortArray | [S |
| long[]	 | jlongArray | [J |
| boolean[]	 | jbooleanArray | [Z |

注意：对应自己创建的类
```java
package signature;
class User {

}
```
对于下面方法

```java
public User a(Object obj, float f) {
    return null;
}
```
对应的方法签名是:(参数签名)+返回值签名
```c
(Ljava/lang/Object;F)Lsignature/User;//注意包名
```


## JNI访问字符串
* java层使用的字符串是utf-18格式的编码，
* jni层用utf-8 unicode的编码，英文一个字节，中文3个字节
* c/C++ 使用ASCII编码,中文编码方式GB2312,中文2个字节
  ![df6e6a623ecc4d4ededa3b2fbee107a3.png](evernotecid://8A2485BE-7365-4851-A3F6-97FBC9BCC325/appyinxiangcom/23840206/ENResource/p990)@w=1000

```java
package string;

public class StringTest {
    public native String sayHello(String string);

    public static void main(String[] args) {
        StringTest test = new StringTest();
        System.out.println(test.sayHello("我是张三"));
    }
    static {
        System.load("/Users/mactty/workspace/study/JNITest/cmake-build-debug/libJNIStatic_reg.dylib");
    }
}
```

jni层代码:

```c++
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
```

### 异常处理

```c++
if (pt == nullptr) {
    return nullptr;
}
```
以上代码是很关键的，调用完GetStringUTFChars之后不要忘记安全检查，因为JVM需要为新诞生的字符串分配内存空 间，当内存空间不够分配的时候，会导致调用失败，失败后GetStringUTFChars会返回NULL，并抛出一个 OutOfMemoryError异常。JNI的异常和Java中的异常处理流程是不一样的，Java遇到异常如果没有捕获，程序会立即停止 运行。而JNI遇到未决的异常不会改变程序的运行流程，也就是程序会继续往下走，这样后面针对这个字符串的所有操作都是非 常危险的，因此，我们需要用return语句跳过后面的代码，并立即结束当前方法。

### 释放字符串

调用GetStringUTFChars函数后，必须再调用一下ReleaseStringUTFChars函数

> 在调用GetStringUTFChars函数从JVM内部获取一个字符串之后，JVM内部会分配一块新的内存，用于存储源字符串
的拷贝，以便本地代码访问和修改。即然有内存分配，用完之后马上释放是一个编程的好习惯。通过调用
ReleaseStringUTFChars函数通知JVM这块内存已经不使用了，你可以清除了。注意：这两个函数是配对使用的，用
了GetXXX就必须调用ReleaseXXX，而且这两个函数的命名也有规律，除了前面的Get和Release之外，后面的都一
样。

## 访问Java中的成员变量

java代码如下
```java
package clz;

public class FieldTest {
    public int property = 200;
    public static int staProperty = 1;

    public native void getField();

    public native void getStaticField();

    public static void main(String[] args) {
        FieldTest fieldTest = new FieldTest();
        fieldTest.getField();
        fieldTest.getStaticField();
        System.out.println(fieldTest.property);
        System.out.println(FieldTest.staProperty);
    }

    static {
        System.load("/Users/mactty/workspace/study/JNITest/cmake-build-debug/libJNIStatic_reg.dylib");
    }
}
```
jni代码如下:

```C++
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
    //获取Class对象
    jclass clz = env->GetObjectClass(obj);
    //获取FieldId对象
    jfieldID fieldId = env->GetStaticFieldID(clz, "staProperty", "I");
    //获取value值
    jint value = env->GetStaticIntField(clz, fieldId);
    printf("staProperty value is %d\n", value);
    //设置value
    env->SetStaticIntField(clz, fieldId, value + 1000);
}
```

总结：
* 由于JNI函数是直接操作JVM中的数据结构，不受Java访问修饰符的限制。即，在本地代码中可以调用JNI函数可以
  访问Java对象中的非public属性和方法
* 访问和修改实例变量操作步聚：
    - 1、调用GetObjectClass函数获取实例对象的Class引用
    - 2、调用GetFieldID函数获取Class引用中的某个实例变量的ID
    - 3、调用GetXXXField函数获取变量的值，需要传入实例变量所属对象、变量ID
    - 4、调用SetXXXField函数修改变量的值,需要传入实例变量所属对象、变量ID和变量的值
* 访问和修改静态变量操作步聚：
    - 1、调用FindClass函数获取类的Class引用
    - 2、调用GetStaticFieldID函数获取Class引用中某个静态变量ID
    - 3、调用GetStaticXXXField函数获取静态变量的值，需要传入变量所属Class的引用和变量ID
    - 4、调用SetStaticXXXField函数设置静态变量的值，需要传入变量所属Class的引用、变量ID和变量的值

## 访问Java中的函数
> Java成员函数一般有两类：静态和非静态。所以在JNI中对这两种不同的类型就有了两种不太相同的调用方法，这两
种不同类型虽然他们的调用方式有些许不同，但是，他们的实质上是一样的。只是调用的接口的名字有区别，而对于
流程是没有区别的
### 非静态方法

```java
package clz;

public class MethodTest {

    public MethodTest() {
        System.out.println("Call MethodTest()");
    }
    
    public void callInstanceMethod(String str, int i) {
        System.out.format("MethodTest:callInstanceMethod(%s,%d)\n", str, i);
    }
    
    public native void nativeCallStaticMethod(String str, int i);
}    
```

jni层代码: 调用callInstanceMethod方法:
步骤：
1. FindClass()获取jclass
2. GetMethodID(cls, "<init>", "()V") 获取Constructor方法 constructorId
3. NewObject(jclass,constructorId) 创建实例对象instance
4. GetMethodID(cls, "callInstanceMethod", "(Ljava/lang/String;I)V") 获取被调用方法ID methodID
5. CallXXXMethod(instance,methodID)调用instance对象的methodID方法
```c++
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
```


### 调用静态方法

```java
public static void callStaticMethod(String str, int i) {
    System.out.format("MethodTest:callStaticMethod(%s,%d)\n", str, i);
}
public native void nativeCallStaticMethod(String str, int i);
```

jni代码:

主要用到了GetStaticMethodID()和CallStaticVoidMethod()
```C++
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
```