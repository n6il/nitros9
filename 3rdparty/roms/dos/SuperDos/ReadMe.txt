This archive contains the disassembled source for SuperDos version E6, 
I have tidyed it up and partially commented it (it is a work in progress as
respects to thie comments :) ). 

I have also (hopefully) successfully ported it to the Dragon Alpha hardware, 
so that it may be used with Mess' Alpha emulation, or with a real Alpha.

As of January 2006, this code has also been ported to run on the Tandy RS-DOS
and compatible controlers when attached to a Dragon, thested so far are FD-500 
(P.Harvey-Smith) and FD-502, Disto Super Controller I (Boisy Pitre).

The tools required to build this are :-

1) A version of Make, I used the gnu one, but any reasonable make should work.
2) The mamou assembler from NitrOS9's toolshed, available from www.nitros9.org,
I will hopefully soon have permission to upload a binary version of this.
3) Aditionally to build the zips you will need pkzip (or zip under Unix/Linux). 

The directories are structured as follows :-

SuperDos

Makefile			Project makefile
superdos-e6-03.asm	Source to SuperDos.
dgndefs.asm			Defines for inclusion in superdos-e6-03.asm
dosdefs.asm			Defines for dos variables
romdefs.asm			Defines of Basic rom vars and calls
Readme.txt			This file !

Subdirectories
Dragon32			Dragon 32 build, dragondos cart		
Dragon64			Dragon 64 build, dragondos cart
DgnAlpha			Dragon Alpha build, internal disk hardware
TanoD64			Tano Dragon 64, RS-DOS compatible cartrage
disks				Contains a zipped image of the AlphaDos boot disk, this may be used
				with mess or written to disk and used with a real Alpha.

If you want to build dos for use with Mess, extract the relevent romset into
the above directory.

Make targets.

The makefile contains the following targets, to build them type make followed 
by one of :-

all		Builds everything.
alpha		Builds SuperDos for the Alpha, in file dragondos-alpha.bin
ddos		Builds SuperDos, for the vanilla DragonDos cartragein file dragondos-ddos.bin.
ddd32		Builds SuperDos, for the Dragon32 for Mess in : dragon32\dragon32.zip
ddd64		Builds SuperDos, for the Dragon64 for Mess in : dragon64\dragon64.zip
dddalpha	Builds SuperDos, for the Dragon Alpha for Mess in : dgnalpha\dgnalpha.zip
sdtano	Builds SuperDos, for the Tano Dragon/RS-DOS for Mess in : tanodr64\tanodr64.zip

The raw rom images will also be built in the above directories.

The files superdos-ddos.bin and superdos-alpha.bin are raw binary images and are suitable
for blowing into an eprom for use on a real machine.

All source is (C) 1983 DragonData Ltd, (C) 1986 ?? Grosvenor Software, except the Alpha port which 
is (C) 2004, P.Harvey-Smith, and the RS-DOS port which is (C) 2006, P.Harvey-Smith.
