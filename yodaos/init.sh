#/bin/bash

. config

if [ ! -f "$SYSTEM_FILE" ];then
    echo "Unzip image from yodaos project"
    if [ -n "$YODAOS_ROOT" ];then
    	if [ ! -f "${YODAOS_ROOT}/openwrt/bin/brcm2708-glibc/${SYSTEM_FILE}.gz" ];then
		echo "Can not find raspbeery image! please set YODAOS_ROOT and build yodaos first!"
		exit -1;
     	fi
     	gunzip -c ${YODAOS_ROOT}/openwrt/bin/brcm2708-glibc/${SYSTEM_FILE}.gz > ${SYSTEM_FILE}
    elif [ -n "$YODAOS_FTP_CURL" ];then
	#ftp get
	echo "Download yodaos image file..."
    else
	echo "Please set yodaos image source!"
    fi
fi

#sudo mount -v -o offset=29360128 -t ext4 openwrt-brcm2708-bcm2710-rpi-3-ext4-factory.img  mnt
