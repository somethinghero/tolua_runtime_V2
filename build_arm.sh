# Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.0+ (ICS)
mkdir -p ./Plugins/Android/libs/armeabi-v7a/
NDK=D:/Android/sdk/ndk-bundle/android-ndk-r10e
NDKABI=19
NDKVER=$NDK/toolchains/arm-linux-androideabi-4.9
NDKP=$NDKVER/prebuilt/windows-x86_64/bin/arm-linux-androideabi-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm" 
NDKARCH="-march=armv7-a -mfloat-abi=softfp -Wl,--fix-cortex-a8"

cd luajit-2.1/src
make clean
make HOST_CC="gcc -m32" CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean

cd ../../android
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86"
$NDK/ndk-build APP_ABI="armeabi-v7a"
cp ./libs/armeabi-v7a/libtolua.so ../Plugins/Android/libs/armeabi-v7a/libtolua.so
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86"