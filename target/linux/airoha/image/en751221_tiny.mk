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
