include ../rules.mak

all: bootman_loader bootman

bootman_loader: bootman_loader.a
	mamou $^ -o$@ -mb

bootman: bootman.r boot_config.r mach_coco3.r llio_6551.r llbt_1773.r
	$(LINKER) $^ -o=$@

dsk: bootman
	decb dskini bootman.dsk
	decb copy -b -2 bootman bootman.dsk,BOOTMAN.BIN

clean:
	-$(RM) *.r bootman
