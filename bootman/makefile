include ../rules.mak

all: bootman_coco bootman_coco3 #bootman_loader

bootman_loader: bootman_loader.a
	mamou $^ -o$@ -mb

bootman_coco: bootman.r boot_config.r mach_coco.r llio_6551.r llbt_1773.r
	$(LINKER) $^ -o=$@

bootman_coco3: bootman.r boot_config.r mach_coco3.r llio_6551.r llbt_1773.r
	$(LINKER) $^ -o=$@

dsk: bootman
	decb dskini bootman.dsk
	decb copy -b -2 bootman bootman.dsk,BOOTMAN.BIN
	decb copy -b -2 bootman_coco3 bootman.dsk,BOOTMAN3.BIN

clean:
	-$(RM) *.r bootman_coco bootman_coco3 bootman.dsk
