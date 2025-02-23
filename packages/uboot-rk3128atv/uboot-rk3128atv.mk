################################################################################
#
# uboot files for POWKIDDY A12/A13
#
################################################################################

UBOOT_RK3128ATV_VERSION = b97b8e4f637f5166907d01371e57e8f7edcd54f9
UBOOT_RK3128ATV_SITE = $(call github,knaerzche,u-boot,$(UBOOT_RK3128ATV_VERSION))
UBOOT_RK3128ATV_LICENSE = GPLv2

define UBOOT_RK3128ATV_BUILD_CMDS
    # FIXME: there should be a better way to build
    cd $(@D) && ARCH=arm CHIP=rk3128 CROSS_COMPILE=$(HOST_DIR)/bin/arm-buildroot-linux-gnueabihf- make box-rk3128_defconfig
    cd $(@D) && ARCH=arm CHIP=rk3128 CROSS_COMPILE=$(HOST_DIR)/bin/arm-buildroot-linux-gnueabihf- make -j4

    # Generate idbloader.img    
    #$(@D)/tools/mkimage -n rk3128 -T rksd -d "$(@D)/tpl/u-boot-tpl.bin":"$(@D)/spl/u-boot-spl-dtb.bin" $(@D)/idbloader-sd.img

    # Generate uboot.img
    #$(@D)/tools/loaderimage --pack --uboot $(@D)/u-boot-dtb.bin $(@D)/uboot.img 0x60000000

    # Generate trust.img
    #$(@D)/tools/loaderimage --pack --trustos $(BINARIES_DIR)/boot-blobs/rk3126_tee_ta_v2.03.bin $(@D)/trust.img 0x68400000
endef

define UBOOT_RK3128ATV_INSTALL_TARGET_CMDS
	#cp $(@D)/idbloader-sd.img $(BINARIES_DIR)/idbloader-sd.img
	#cp $(@D)/uboot.img	  $(BINARIES_DIR)/uboot.img
	#cp $(@D)/trust.img        $(BINARIES_DIR)/trust.img
	cp $(@D)/u-boot-rockchip.bin        $(BINARIES_DIR)/u-boot-rockchip.bin
endef

$(eval $(generic-package))
