include ../../../rules.mak

DISK68	= uucpbb21_6809.dsk
DISK63	= uucpbb21_6309.dsk
CMDS68		= $(shell $(MAKE) -C cmds_6809 --no-print-directory showobjs)
CMDS68TCAP	= $(shell $(MAKE) -C cmds_6809 --no-print-directory showtcapobjs) $(CMDS68)
CMDS68WIN	= $(shell $(MAKE) -C cmds_6809 --no-print-directory showwinobjs) $(CMDS68)
CMDS63		= $(shell $(MAKE) -C cmds_6309 --no-print-directory showobjs)
CMDS63TCAP	= $(shell $(MAKE) -C cmds_6309 --no-print-directory showtcapobjs) $(CMDS63)
CMDS63WIN	= $(shell $(MAKE) -C cmds_6309 --no-print-directory showwinobjs) $(CMDS63)
CONFIG	= Devices FileServ.help Systems bin.list Dialers Parameters active distributions
DOCS	= adduser.man aliases.doc chown.man cnvrtmail.man fileserv.man fixtext.man login.man mailrc.doc mailx.man parameters.doc postnews.man profile.doc readnews.man rmail.man rnews.man signature.doc subscribe.man uucico.man uuclean.man uucp.man uucpbb.doc uulog.man uuxqt.man whoami.man

DSKS	= $(DISK68) $(DISK63)

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                   UUCPbb v2.1                  *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(MAKE) -C cmds_6809
	$(MAKE) -C cmds_6309

# Clean all components
clean:	dskclean
	$(MAKE) -C cmds_6809 clean
	$(MAKE) -C cmds_6309 clean

dsk: $(DSKS)

$(DISK68): all
	$(RM) $@
	$(OS9FORMAT) -l10000 $@ -q -n"UUCPbb v2.1 6809"
	$(MAKDIR) $@,LOG
	$(MAKDIR) $@,UUCP
	$(MAKDIR) $@,UUCP/CMDS_WIN
	$(MAKDIR) $@,UUCP/CMDS_TCAP
	$(MAKDIR) $@,UUCP/DOC
	$(MAKDIR) $@,UUCP/SPOOL
	$(MAKDIR) $@,UUCP/SPOOL/MAIL
	$(MAKDIR) $@,UUCP/SPOOL/NEWS
	$(MAKDIR) $@,UUCP/SPOOL/UUCP
	$(MAKDIR) $@,UUCP/SPOOL/UUCP/REDHAT
	$(MAKDIR) $@,UUCP/SPOOL/UUCPPUBLIC
	$(MAKDIR) $@,UUCP/SPOOL/REDHAT
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,SYS/UUCP
	$(CD) sample_config; $(CPL) $(CONFIG) ../$@,SYS/UUCP
	$(CPL) profile $@,SYS
	$(CD) cmds_6809; $(OS9COPY) $(CMDS68TCAP) ../$@,UUCP/CMDS_TCAP
	$(OS9ATTR_EXEC) $(foreach file,$(notdir $(CMDS68TCAP)),$@,UUCP/CMDS_TCAP/$(file))
	$(CD) cmds_6809; $(OS9COPY) $(CMDS68WIN) ../$@,UUCP/CMDS_WIN
	$(OS9ATTR_EXEC) $(foreach file,$(notdir $(CMDS68WIN)),$@,UUCP/CMDS_WIN/$(file))
	$(CD) doc; $(CPL) $(DOCS) ../$@,UUCP/DOC
	$(CPL) copying readme.first $@,UUCP

$(DISK63): all
	$(RM) $@
	$(OS9FORMAT) -l10000 $@ -q -n"UUCPbb v2.1 6309"
	$(MAKDIR) $@,LOG
	$(MAKDIR) $@,UUCP
	$(MAKDIR) $@,UUCP/DOC
	$(MAKDIR) $@,UUCP/CMDS_WIN
	$(MAKDIR) $@,UUCP/CMDS_TCAP
	$(MAKDIR) $@,UUCP/SPOOL
	$(MAKDIR) $@,UUCP/SPOOL/MAIL
	$(MAKDIR) $@,UUCP/SPOOL/NEWS
	$(MAKDIR) $@,UUCP/SPOOL/UUCP
	$(MAKDIR) $@,UUCP/SPOOL/UUCP/REDHAT
	$(MAKDIR) $@,UUCP/SPOOL/UUCPPUBLIC
	$(MAKDIR) $@,UUCP/SPOOL/REDHAT
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,SYS/UUCP
	$(CD) sample_config; $(CPL) $(CONFIG) ../$@,SYS/UUCP
	$(CPL) profile $@,SYS
	$(CD) cmds_6309; $(OS9COPY) $(CMDS63TCAP) ../$@,UUCP/CMDS_TCAP
	$(OS9ATTR_EXEC) $(foreach file,$(notdir $(CMDS63TCAP)),$@,UUCP/CMDS_TCAP/$(file))
	$(CD) cmds_6309; $(OS9COPY) $(CMDS63WIN) ../$@,UUCP/CMDS_WIN
	$(OS9ATTR_EXEC) $(foreach file,$(notdir $(CMDS63WIN)),$@,UUCP/CMDS_WIN/$(file))
	$(CD) doc; $(CPL) $(DOCS) ../$@,UUCP/DOC
	$(CPL) copying readme.first $@,UUCP

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** UUCPbb 2.1 ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)

