################################################################################
#
# uboot files for POWKIDDY A12/A13
#
################################################################################

UBOOT_RK3128ATV_LEGACY_VERSION = 2687dce2617032930f2c43fef349bdea694c6f68
UBOOT_RK3128ATV_LEGACY_SITE = $(call github,rockchip-linux,u-boot,$(UBOOT_RK3128ATV_LEGACY_VERSION))
UBOOT_RK3128ATV_LEGACY_LICENSE = GPLv2

define UBOOT_RK3128ATV_LEGACY_BUILD_CMDS
    # FIXME: there should be a better way to build
    cd $(@D) && ARCH=arm CHIP=rk3128 CROSS_COMPILE=$(HOST_DIR)/bin/arm-buildroot-linux-gnueabihf- make rk3128_atv_defconfig
    cd $(@D) && ARCH=arm CHIP=rk3128 CROSS_COMPILE=$(HOST_DIR)/bin/arm-buildroot-linux-gnueabihf- make V=1 -j2

    # Generate idbloader.img    
    $(@D)/tools/mkimage -n rk3128 -T rksd -d "$(BINARIES_DIR)/boot-blobs/rk3128_ddr_300MHz_v2.12.bin":"$(BINARIES_DIR)/boot-blobs/rk312x_miniloader_v2.63.bin" $(@D)/idbloader-sd.img

    # Generate uboot.img
    $(@D)/tools/loaderimage --pack --uboot $(@D)/u-boot-dtb.bin $(@D)/uboot.img 0x60000000

    # Generate trust.img
    $(@D)/tools/loaderimage --pack --trustos $(BINARIES_DIR)/boot-blobs/rk3126_tee_ta_v2.03.bin $(@D)/trust.img 0x68400000
endef

define UBOOT_RK3128ATV_LEGACY_INSTALL_TARGET_CMDS
	cp $(@D)/idbloader-sd.img $(BINARIES_DIR)/idbloader-sd.img
	cp $(@D)/uboot.img	  $(BINARIES_DIR)/uboot.img
	cp $(@D)/trust.img        $(BINARIES_DIR)/trust.img
endef

$(eval $(generic-package))
