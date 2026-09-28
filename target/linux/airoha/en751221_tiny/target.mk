# SPDX-License-Identifier: GPL-2.0-only

ARCH:=mips
SUBTARGET:=en751221_tiny
BOARDNAME:=EN751221 boards with small SPI-NOR flash
CPU_TYPE:=24kc
KERNELNAME:=vmlinux
FEATURES := $(filter-out nand,$(FEATURES)) small_flash

define Target/Description
	Build firmware images for EcoNet EN751221 family boards with 4 MiB of
	SPI-NOR flash. The kernel is trimmed to fit and is booted by U-Boot
	from an LZMA FIT image, without zboot.
endef
