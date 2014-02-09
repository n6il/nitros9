# gdb scripts for NitrOS-9 (or OS-9)
# Copyright 2014  Tormod Volden

# os9_mdir prints out registered modules, like os9 mdir command

# pretty-print of registers on every halt,
# and update external source code window
define hook-stop
	printf "S=%04x X=%04x Y=%04x U=%04x A=%02x B=%02x CC=%02x PC=%04x ", $s, $x, $y, $u, $a, $b, $cc , $pc
	os9_mwhere
end

# print name of module at given address
define os9_mname
	set $mname = (char*)$arg0 + *((int*)$arg0 + 2)
	while 1
		if (*$mname < 0x80)
			printf "%c", *$mname
		else
			printf "%c", *$mname-0x80
			loop_break
		end
		set $mname += 1
	end
end

# print details of module at given address
define os9_mident
	set $m = (int*)$arg0
	set $msize = *($m + 1)
	set $mtype = *((char*) $m + 6)
	set $mexec = *(int*)((char*) $m + 9)
	printf "%04x %4x %2X ", $m, $msize, $mtype
	os9_mname $m
	if ($mtype & 0xf)
		printf "\t[exec %04x] ", (char*)$m + $mexec
	end
	printf "\n"
end

# list all registered modules
define os9_mdir
	printf "addr size ty name\n"
	set $mt = 0x300
	while ($mt < 0x400)
		if ((int*)*$mt)
			os9_mident (int*)*$mt
		end
		set $mt += 4
	end
end

# finds module at given address, sets $mstart
define os9_mwhich
	set $pc_reg = $arg0
	set $mt = 0x300
	while ($mt < 0x400)
		if ((int*)*$mt)
			set $mstart = (int*)*$mt
			set $mend = (char*)$mstart + *($mstart + 1)
			if ($pc_reg >= $mstart && $pc_reg < $mend)
				loop_break
			end
		end
		set $mt += 4
	end
	if ($mt == 0x400)
		set $mstart = 0
	end
end


# Look up source code line for given address.
# Requires assembly list files named by CRC in current directory
# and "gvim" to display listing and highlight line.
define os9_mwhere
	if ($argc == 1)
		set $pc_reg = $arg0
	else
		set $pc_reg = $pc
	end
	os9_mwhich $pc_reg
	if ($mstart)
		printf "inside "
		os9_mname $mstart
		printf "\n"
		eval "!gvim --remote %02X%02X%02X.crc && gvim --remote-send \":set cursorline<CR>\" && gvim --remote-send \"/^%04X<CR>\"", *((char*)$mend-3), *((char*)$mend-2), *((char*)$mend-1), (char*)$pc_reg - (char*)$mstart
	else
		printf "no module\n"
	end
end

# Set breakpoint in current module, at given offset
define b9
	os9_mwhich $pc
	eval "hbreak *0x%x", (int)$mstart + $arg0
end
