include ../../../rules.mak

DISK68	= uucpbb21_6809.dsk
DISK63	= uucpbb21_6309.dsk
CMDS68TCAP	= $(shell $(CD) cmds_6809; make showtcapobjs)
CMDS68WIN	= $(shell $(CD) cmds_6809; make showwinobjs)
CMDS63TCAP	= $(shell $(CD) cmds_6309; make showtcapobjs)
CMDS63WIN	= $(shell $(CD) cmds_6309; make showwinobjs)
CONFIG	= Devices FileServ.help Systems bin.list Dialers Parameters active distributions
DOCS	= adduser.man aliases.doc chown.man cnvrtmail.man fileserv.man fixtext.man login.man mailrc.doc mailx.man parameters.doc postnews.man profile.doc readnews.man rmail.man rnews.man signature.doc subscribe.man uucico.man uuclean.man uucp.man uucpbb.doc uulog.man uuxqt.man whoami.man

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                   UUCPbb v2.1                  *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(CD) cmds_6809; make
	$(CD) cmds_6309; make

# Clean all components
clean:	dskclean
	-$(CD) cmds_6809; make clean
	-$(CD) cmds_6309; make clean

dsk:	all
	$(RM) $(DISK68)
	$(OS9FORMAT) -l10000 $(DISK68) -q -n"UUCPbb v2.1 6809"
	$(MAKDIR) $(DISK68),CMDS_WIN
	$(MAKDIR) $(DISK68),CMDS_TCAP
	$(MAKDIR) $(DISK68),UUCP
	$(MAKDIR) $(DISK68),UUCP/DOC
	$(MAKDIR) $(DISK68),USR
	$(MAKDIR) $(DISK68),USR/SPOOL
	$(MAKDIR) $(DISK68),USR/SPOOL/MAIL
	$(MAKDIR) $(DISK68),USR/SPOOL/NEWS
	$(MAKDIR) $(DISK68),USR/SPOOL/UUCP
	$(MAKDIR) $(DISK68),USR/SPOOL/UUCPPUBLIC
	$(MAKDIR) $(DISK68),USR/SPOOL/REDHAT
	$(MAKDIR) $(DISK68),SYS
	$(MAKDIR) $(DISK68),SYS/UUCP
	$(CD) sample_config; $(CPL) $(CONFIG) ../$(DISK68),SYS/UUCP

	$(CD) cmds_6809; $(CP) $(CMDS68TCAP) ../$(DISK68),CMDS_TCAP
	$(foreach file, $(CMDS68TCAP), $(OS9ATTR_EXEC) $(DISK68),CMDS_TCAP/$(notdir $(file));)
	$(CD) cmds_6809; $(CP) $(CMDS68WIN) ../$(DISK68),CMDS_WIN
	$(foreach file, $(CMDS68WIN), $(OS9ATTR_EXEC) $(DISK68),CMDS_WIN/$(notdir $(file));)
	$(CD) doc; $(CPL) $(DOCS) ../$(DISK68),UUCP/DOC
	$(CPL) copying readme.first $(DISK68),

	$(RM) $(DISK63)
	$(OS9FORMAT) -l10000 $(DISK63) -q -n"UUCPbb v2.1 6309"
	$(MAKDIR) $(DISK63),CMDS_WIN
	$(MAKDIR) $(DISK63),CMDS_TCAP
	$(MAKDIR) $(DISK63),UUCP
	$(MAKDIR) $(DISK63),UUCP/DOC
	$(MAKDIR) $(DISK63),USR
	$(MAKDIR) $(DISK63),USR/SPOOL
	$(MAKDIR) $(DISK63),USR/SPOOL/MAIL
	$(MAKDIR) $(DISK63),USR/SPOOL/NEWS
	$(MAKDIR) $(DISK63),USR/SPOOL/UUCP
	$(MAKDIR) $(DISK63),USR/SPOOL/UUCPPUBLIC
	$(MAKDIR) $(DISK63),USR/SPOOL/REDHAT
	$(MAKDIR) $(DISK63),SYS
	$(MAKDIR) $(DISK63),SYS/UUCP
	$(CD) sample_config; $(CPL) $(CONFIG) ../$(DISK63),SYS/UUCP
	$(CD) cmds_6309; $(CP) $(CMDS63TCAP) ../$(DISK63),CMDS_TCAP
	$(foreach file, $(CMDS63TCAP), $(OS9ATTR_EXEC) $(DISK63),CMDS_TCAP/$(notdir $(file));)
	$(CD) cmds_6309; $(CP) $(CMDS63WIN) ../$(DISK63),CMDS_WIN
	$(foreach file, $(CMDS63WIN), $(OS9ATTR_EXEC) $(DISK63),CMDS_WIN/$(notdir $(file));)
	$(CD) doc; $(CPL) $(DOCS) ../$(DISK63),UUCP/DOC
	$(CPL) copying readme.first $(DISK63),

dskcopy: dsk
	$(CP) $(DISK68) $(DSKDIR)
	$(CP) $(DISK63) $(DSKDIR)

dskclean:
	$(RM) $(DISK68) $(DISK63)

