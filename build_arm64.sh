# Android/ARM, armeabi-v8a (ARMv7 VFP), Android 4.0+ (ICS)
mkdir -p ./Plugins/Android/libs/arm64-v8a/
NDK=D:/Android/sdk/ndk-bundle/android-ndk-r10e
NDKABI=21
NDKTRIPLE=aarch64-linux-android
NDKVER=$NDK/toolchains/aarch64-linux-android-4.9
NDKP=$NDKVER/prebuilt/windows-x86_64/bin/aarch64-linux-android-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm64" 
NDKARCH="-DLJ_ABI_SOFTFP=0 -DLJ_ARCH_HASFPU=1 -DLUAJIT_ENABLE_GC64=1"

cd luajit-2.1/src
make clean
make HOST_CC="gcc -m64" CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean

if [[ "$OSTYPE" == "msys" ]]; then
       cd ../../
       # can't pass $NDK to bat
       powershell -c "./link_arm64.bat"
else
       cd ../../android
       $NDK/ndk-build clean APP_ABI="arm64-v8a"
       $NDK/ndk-build APP_ABI="arm64-v8a"
       cp ./libs/arm64-v8a/libtolua.so ../Plugins/Android/libs/arm64-v8a/libtolua.so
       $NDK/ndk-build clean APP_ABI="arm64-v8a"
fi