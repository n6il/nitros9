include ../rules.mak

all: bootman_coco_6551 bootman_coco3_6551 #bootman_loader

bootman_loader: bootman_loader.a
	mamou $^ -o$@ -mb

bootman_coco_6551: bootman.r boot_config.r mach_coco.r llio_6551.r llbt_1773.r
	$(LINKER) $^ -o=$@

bootman_coco3_6551: bootman.r boot_config.r mach_coco3.r llio_6551.r llbt_1773.r
	$(LINKER) $^ -o=$@

dsk: bootman
	decb dskini bootman.dsk
	decb copy -b -2 bootman_coco_6551 bootman.dsk,BM6551.BIN
	decb copy -b -2 bootman_coco3_6551 bootman.dsk,BM36551.BIN

clean:
	$(RM) *.r bootman_coco_6551 bootman_coco3_6551 bootman.dsk
