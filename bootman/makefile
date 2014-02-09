include ../rules.mak

BOOTMAN = bootman_coco_6551 bootman_coco3_6551

all: $(BOOTMAN)

bootman_coco_6551: bootman.o boot_config.o mach_coco.o llio_6551.o llbt_1773.o
	$(LINKER) $^ -o$@

bootman_coco3_6551: bootman.o boot_config.o mach_coco3.o llio_6551.o llbt_1773.o
	$(LINKER) $^ -o$@

dsk: $(BOOTMAN)
	decb dskini bootman.dsk
	decb copy -b -2 bootman_coco_6551 bootman.dsk,BM6551.BIN
	decb copy -b -2 bootman_coco3_6551 bootman.dsk,BM36551.BIN

dskclean:
	$(RM) bootman.dsk

clean: dskclean
	$(RM) *.o bootman_coco_6551 bootman_coco3_6551 bootman.dsk
