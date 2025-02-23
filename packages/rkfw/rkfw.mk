################################################################################
#
# firmware-rockchip
#
################################################################################

RKFW_VERSION = 5c186571d6ba6f492e3a04947e3958976e9d13b4
RKFW_SITE = $(call github,ilmich,rkbin,$(RKFW_VERSION))

RKFW_TARGET_DIR=$(TARGET_DIR)/lib/firmware/

define RKFW_INSTALL_TARGET_CMDS
	# install driver firmware blob
	mkdir -p $(RKFW_TARGET_DIR)/rtl_bt
	cp -v $(@D)/firmware/wifi/ssv6051-sw.bin $(RKFW_TARGET_DIR)
	cp -v $(@D)/firmware/wifi/ssv6051-wifi.cfg $(RKFW_TARGET_DIR)
	cp -v $(@D)/firmware/bluetooth/rtl8723cs_xx_config.bin $(RKFW_TARGET_DIR)/rtl_bt
	cp -v $(@D)/firmware/bluetooth/rtl8723cs_xx_fw.bin $(RKFW_TARGET_DIR)/rtl_bt

	# copy some boot files
	mkdir -p $(BINARIES_DIR)/boot-blobs/
	cp -v $(@D)/rk32/rk322x_ddr_330MHz_v1.10.bin $(BINARIES_DIR)/boot-blobs/
	cp -v $(@D)/rk32/rk322x_miniloader_v2.56.bin $(BINARIES_DIR)/boot-blobs/
	cp -v $(@D)/rk32/rk3228_tee_ta-51.1.0-333-gc9d95d1.bin $(BINARIES_DIR)/boot-blobs/
	
	cp -v $(@D)/rk31/rk3128_ddr_300MHz_v2.12.bin $(BINARIES_DIR)/boot-blobs/
	cp -v $(@D)/rk31/rk312x_miniloader_v2.63.bin $(BINARIES_DIR)/boot-blobs/
	cp -v $(@D)/rk31/rk3126_tee_ta_v2.03.bin $(BINARIES_DIR)/boot-blobs/	
endef

$(eval $(generic-package))
