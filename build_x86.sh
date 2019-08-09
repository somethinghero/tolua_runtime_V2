# Android/x86, x86 (i686 SSE3), Android 4.0+ (ICS)
mkdir -p ./Plugins/Android/libs/x86/
NDK=D:/Android/sdk/ndk-bundle/android-ndk-r10e
NDKABI=19
NDKVER=$NDK/toolchains/x86-4.9
NDKP=$NDKVER/prebuilt/windows-x86_64/bin/i686-linux-android-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-x86"

cd luajit-2.1/src
make clean
make HOST_CC="gcc -m32" CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean

cd ../../android
$NDK/ndk-build clean APP_ABI="x86"
$NDK/ndk-build APP_ABI="x86"
cp ./libs/x86/libtolua.so ../Plugins/Android/libs/x86
$NDK/ndk-build clean APP_ABI="x86"