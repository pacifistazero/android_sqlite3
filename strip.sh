#!/bin/bash

DEFAULT_MACHINE_TYPE=darwin-x86_64
#DEFAULT_MACHINE_TYPE=linux-x86_64
NDK_LOG=0
NDK_TOOLCHAIN_PATH=${ANDROID_NDK_HOME}/toolchains

MACHINE_TYPE="$1"
if [ "$MACHINE_TYPE" == "" ]; then
    echo "default MACHINE_TYPE darwin-x86_64"
    MACHINE_TYPE=${DEFAULT_MACHINE_TYPE}
fi

stripSymbol() {
    echo ============ stripSymbol ${1}
    STRIP=${NDK_TOOLCHAIN_PATH}/${2}/prebuilt/${MACHINE_TYPE}/${3}/bin/strip
    cd ${1}/lib
    ${STRIP} -g -S -d --strip-debug libsqlite3.a
    cd ../..
}

cd lib

cd debug
stripSymbol arm64-v8a aarch64-linux-android-4.9 aarch64-linux-android
stripSymbol armeabi arm-linux-androideabi-4.9 arm-linux-androideabi
stripSymbol armeabi-v7a arm-linux-androideabi-4.9 arm-linux-androideabi
stripSymbol x86 x86-4.9 i686-linux-android
stripSymbol x86_64 x86_64-4.9 x86_64-linux-android
cd ..

cd release
stripSymbol arm64-v8a aarch64-linux-android-4.9 aarch64-linux-android
stripSymbol armeabi arm-linux-androideabi-4.9 arm-linux-androideabi
stripSymbol armeabi-v7a arm-linux-androideabi-4.9 arm-linux-androideabi
stripSymbol x86 x86-4.9 i686-linux-android
stripSymbol x86_64 x86_64-4.9 x86_64-linux-android
cd ..
