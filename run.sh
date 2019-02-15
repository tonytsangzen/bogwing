#!/bin/bash

ROOT_DIR=$PWD/${0%/*}
CFG_FILE=config

#if run in docker, pull latest version
if [ -f "/.dockerenv" ];then
	cd $ROOT_DIR
	git pull origin master 
	cd -
fi

#check parameter
if [ -n $1 ] && [ -d $ROOT_DIR/$1 ] && [ -f $ROOT_DIR/$1/$CFG_FILE ]; then
    TARGET_DIR=$ROOT_DIR/$1
else
    echo select valid machine:
    for dir in `ls -d */$CFG_FILE`
    do
      echo "[${dir%/*}]"
    done
    exit -1
fi

#determination host os
HOST="$(uname)"
if [ "$HOST" = "Linux" ];then
    EXEC=$ROOT_DIR/bin/qemu-system
elif [ "$HOST" = "Darwin" ];then
    EXEC=qemu-system
else
    echo Unsupport Host: $HOST
    exit -1
fi

#include machine config 
. $TARGET_DIR/config

COMMAND="$EXEC-$ARCH -M $MACHINE -m $MEMORY -cpu $CPU -kernel $TARGET_DIR/$VMLINUXZ"

if [ -n "$INITRD_IMG" ];then
  COMMAND+=" -initrd $TARGET_DIR/$INITRD_IMG"
fi

#smp core config
if [ -n "$SMP" ];then
  COMMAND+=" -smp $SMP"
fi

if [ -n "$SYSTEM_FILE" ];then
  COMMAND+=" -drive if=none,file=$TARGET_DIR/${SYSTEM_FILE},format=$SYSTEM_FORMAT,id=hd0 -device virtio-blk-pci,drive=hd0"
fi

if [ -n "$PORT_FOWARD" ];then
  COMMAND+=" -net user,hostfwd=tcp::$PORT_FOWARD"
fi

if [ -n "$VNC_PORT" ];then
  echo "Run in VNC mode. VNC PORT is: `expr 5900 + $VNC_PORT`"
  COMMAND+=" -vnc :$VNC_PORT"
else
  COMMAND+=" -nographic"
fi

if [ -n "$EXT_PARAM" ];then
  COMMAND+=" $EXT_PARAM"
fi

if [ -n "$BOOT_ARGS" ];then
  COMMAND+=" -append \"${BOOT_ARGS}\""
fi

if [ -n "$GDB_PORT" ];then
  COMMAND+=" -gdb tcp::$GDB_PORT"
fi

echo $COMMAND
eval $COMMAND
