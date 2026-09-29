define Image/Prepare
	# LuCI views, icons and menus that do not apply to a 4 MiB bridge
	rm -f $(TARGET_DIR)/www/luci-static/resources/view/network/wireless.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/network/dhcp.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/network/dns.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/network/switch* \
	      $(TARGET_DIR)/www/luci-static/resources/view/status/wireless.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/status/channel_analysis.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/status/nftables.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/status/iptables.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/status/connections.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/status/syslog.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/status/routes* \
	      $(TARGET_DIR)/www/luci-static/resources/view/status/include/40_dhcp.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/status/include/50_dsl.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/status/include/60_wifi.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/system/plugins.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/system/repokeys.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/system/mounts.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/system/crontab.js \
	      $(TARGET_DIR)/www/luci-static/resources/view/system/pwpolicy.js
	rm -f $(TARGET_DIR)/www/luci-static/resources/icons/wireguard* \
	      $(TARGET_DIR)/www/luci-static/resources/icons/wifi* \
	      $(TARGET_DIR)/www/luci-static/resources/icons/signal* \
	      $(TARGET_DIR)/www/luci-static/resources/icons/tunnel* \
	      $(TARGET_DIR)/www/luci-static/resources/icons/vrf* \
	      $(TARGET_DIR)/www/luci-static/resources/icons/port_pse*
	# Menus without the entries whose views are removed above
	if [ -d $(TARGET_DIR)/usr/share/luci/menu.d ]; then \
		$(CP) $(TOPDIR)/target/linux/airoha/en751221_tiny/menu.d/* $(TARGET_DIR)/usr/share/luci/menu.d/; \
	fi
endef

define Device/tplink_xz000-g3-v2
  DEVICE_VENDOR := TP-Link
  DEVICE_MODEL := XZ000-G3
  DEVICE_VARIANT := v2
  DEVICE_DTS := en751221_tplink_xz000-g3-v2
  BLOCKSIZE := 64k
  IMAGE_SIZE := 3776k
  KERNEL := kernel-bin | lzma | fit lzma $$(KDIR)/image-$$(DEVICE_DTS).dtb
  KERNEL_INITRAMFS := kernel-bin | lzma | \
    fit lzma $$(KDIR)/image-$$(DEVICE_DTS).dtb
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | pad-to $$(BLOCKSIZE) | \
    append-rootfs | pad-rootfs | check-size | append-metadata
  DEVICE_PACKAGES := -nand-utils -wpad-basic-mbedtls -ppp -ppp-mod-pppoe \
    -odhcpd-ipv6only -odhcp6c -dnsmasq -firewall4 -nftables \
    -kmod-nft-offload -uclient-fetch -urandom-seed -urngd -ca-bundle \
    -libustream-mbedtls -logd -rpcd-mod-iwinfo -libiwinfo-data -libiwinfo \
    -luci-lib-uqr
endef
TARGET_DEVICES += tplink_xz000-g3-v2

define Device/tplink_xz000-g3-v1
  $(Device/tplink_xz000-g3-v2)
  DEVICE_VARIANT := v1
  DEVICE_DTS := en751221_tplink_xz000-g3-v1
  # 16 MiB XM25QH128A, firmware at 0x70000 up to the end of the chip
  IMAGE_SIZE := 15936k
  # Room for SSH and HTTPS package downloads; still a bridge, no wifi/router
  DEVICE_PACKAGES := -nand-utils -wpad-basic-mbedtls -ppp -ppp-mod-pppoe \
    -odhcpd-ipv6only -odhcp6c -dnsmasq -firewall4 -nftables \
    -kmod-nft-offload -urandom-seed -urngd -logd \
    -rpcd-mod-iwinfo -libiwinfo-data -libiwinfo -luci-lib-uqr \
    dropbear
endef
TARGET_DEVICES += tplink_xz000-g3-v1
