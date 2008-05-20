include ../rules.mak

bootman: bootman.r boot_config.r mach_coco3.r llio_6551.r llbt_1773.r
	$(LINKER) $^ -o=$@ -B

dsk: bootman
	decb dskini bootman.dsk
	decb copy -b -2 bootman bootman.dsk,BOOTMAN.BIN

clean:
	-$(RM) *.r bootman
