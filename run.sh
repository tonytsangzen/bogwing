#!/bin/sh

ROOT_DIR=$PWD/${0%/*}

if [ -n $1 ] && [ -d $ROOT_DIR/$1 ] && [ -f $ROOT_DIR/$1/config ]; then
    TARGET_DIR=$ROOT_DIR/$1
else
    echo select a platform:
    exit
fi

HOST="$(uname)"

if [ "$HOST" = "Linux" ];then
    EXEC=$ROOT_DIR/bin/qemu-system-aarch64
elif [ "$HOST" = "Darwin" ];then
    EXEC=qemu-system-aarch64
else
    echo Unsupport Host: $HOST
fi

if [ -f "/.dockerenv" ];then
	cd $ROOT_DIR
	git pull origin master 
	cd -
fi

. $TARGET_DIR/config

$EXEC \
	-M virt \
	-m   $MEMORY \
 	-smp $SMP \
	-cpu $CPU \
	-kernel $TARGET_DIR/$VMLINUXZ \
	-initrd $TARGET_DIR/$INITRD_IMG \
	-drive if=none,file=$TARGET_DIR/${SYSTEM_FILE},format=$SYSTEM_FORMAT,id=hd0 \
	-device virtio-blk-pci,drive=hd0 \
	-net user,hostfwd=tcp::$HOST_PORT-:$TARGET_PORT \
	-nographic --no-reboot
