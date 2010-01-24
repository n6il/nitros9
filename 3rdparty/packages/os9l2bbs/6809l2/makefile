include $(NITROS9DIR)/rules.mak

vpath %.asm ../cmds

PROBCMDS = AnsiEd AnsiFilt BBS.chat New_user Quikterm pause suser
CMDS	= Ansicode Answer At \
	BBS.archive BBS.build BBS.conf BBS.conf.who BBS.convert \
	BBS.create BBS.delete BBS.download BBS.form BBS.forward BBS.list \
	BBS.mail.check BBS.mail.delete BBS.mail.post BBS.mail.read \
	BBS.mail.readD BBS.new BBS.pack BBS.page BBS.post BBS.read BBS.reply \
	BBS.scan BBS.search BBS.stat BBS.upload BBS.validate BBS.who \
	Conf.dat \
	DLD.add DLD.list DLD.read DLD.search DLD.unvalidate DLD.validate \
	Dloada Dloadx Dloadxc Dloady \
	Login Makdir Menu Monitor Prompt T1mon Tsmon \
	Uloada Uloadx Uloadxc Uloady ViewBBS

all: $(CMDS)

clean:
	-$(RM) $(CMDS)
