#!/bin/bash

echo Start Compile.

starttime=`date +'%Y-%m-%d %H:%M:%S'`

export ARCH=arm64 

export SUBARCH=arm64 

if [ "$1" == "-c" ]; then
	echo make clean.
	make clean && make mrproper
	rm -rf out
	mkdir -p out
	echo done.
fi

# args="-j$(nproc --all) \
args="-j6 \
	ARCH=arm64 \
	SUBARCH=arm64 \
	O=out \
	CC=clang \
	CLANG_TRIPLE=aarch64-linux-gnu- \
	CROSS_COMPILE=aarch64-linux-gnu- \
	CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
	NM=llvm-nm \
	OBJCOPY=llvm-objcopy \
	LD=ld.lld \
	AR=llvm-ar \
	OBJDUMP=llvm-objdump \
	READELF=llvm-readelf \
	OBJSIZE=llvm-size \
	STRIP=llvm-strip \
	LDGOLD=aarch64-linux-gnu-ld.gold \
	LLVM_AR=llvm-ar \
	LLVM_DIS=llvm-dis "

make O=out /sagit_defconfig

make ${args} 

2>&1 | tee error.log

endtime=`date +'%Y-%m-%d %H:%M:%S'`

start_seconds=$(date --date=" $starttime" +%s);

end_seconds=$(date --date="$endtime" +%s);

echo Start: $starttime.

echo End: $endtime.

echo "Build Time: "$((end_seconds-start_seconds))"s."
