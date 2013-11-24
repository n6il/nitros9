include $(NITROS9DIR)/rules.mak

# makefile for OS-9 UUCP package, UUCPbb v2.1 (OS-9/6809)
#
# This script requires Shell+ v2.1 (or later) and CC v2.5.0
#
# NOTE: This package must be compiled by the SUPERUSER (user 0) in order
#       for it to work properly.

CC      = c3

# Temporary directory.  This device must have at least 120K of free space
TMP     =

# Default device
DD     = /DD

# Uncomment the termlib.l below to add termcap support.
# NOTE: termlib.l is necessary if using termcap, while sys.l is not currently
#       necessary for compiling

LIB     = #-l=/dd/lib/termlib.l \
          #-l=/dd/lib/cmath63.l -l=/dd/lib/string63.l \
          #-l=$(DD)/lib/sys.l 

# REPLACE m6809 below with m6309 if you are using the 6309 microprocessor

CPU     = m6809

# COMMENT OUT SHELLPLUS if you do NOT use Shell+ v2.1 or later

USHELL  = SHELLPLUS

# UNCOMMENT -dTERMCAP to add termcap support.
# UNCOMMENT -dBSDISH also to add termcap support based on Brad Spencer's
#              port of BSD termcap (available on chestnut.cs.wisc.edu)
# UNCOMMENT -dDASHOK if kernel is patched to allow the '-' as part of file
#              and directory names.
# REMOVE    -dNEWCLIB if you are NOT using Carl Kreider clib.l replacement
#              1990 or later.
#
# ==IMPORTANT== do NOT remove the '\' at the end of the CFLAGS line.

CFLAGS  = -q -o -s -d$(CPU) -dOS9 -d$(USHELL) -dNEWCLIB  \
          #-dTERMCAP  #-dBSDISH  #-dDASHOK
OBJS	= uucico mailx dotilde rmail rnews uuxqt readnews postnews expire \
     subscribe unsubscribe uulog uuclean uuencode uudecode uucp chown \
     whoami fixtext adduser fileserv uuname login cnvrtmail #uusetup

# These modules will not be compiled now by this makefile: 
#         uusetup

all: $(OBJS)
#	attr uucico e w r pe -pw pr
#	attr mailx  e w r pe -pw pr
#	attr dotilde e w r pe -pw pr
#	attr rmail e w r -pe -pw -pr
#	attr rnews e w r -pe -pw -pr
#	attr uuxqt e w r -pe -pw -pr
#	attr readnews e w r pe -pw pr
#	attr postnews e w r pe -pw pr
#	attr expire e w r -pe -pw -pr
#	attr subscribe e w r pe -pw pr
#	attr unsubscribe e w r pe -pw pr
#	attr uulog e w r pe -pw pr
#	attr uuclean e w r -pe -pw -pr
#	attr uuencode e w r pe -pw pr
#	attr uudecode e w r pe -pw pr
#	attr uucp e w r pe -pw pr
#	attr chown e w r pe -pw pr
#	attr whoami e w r pe -pw pr
#	attr fixtext e w r pe -pw pr
#	attr adduser e w r -pe -pw -pr
#	attr fileserv e w r pe -pw pr
#	attr uuname e w r pe -pw pr
#	attr login e w r pe -pw pr
#	attr cnvrtmail e w r -pe -pw -pr
#	attr uusetup e w r -pe -pw -pr

_UUCICO = uucico.r getopt.r getparam.r findmach.r chksched.r findline.r \
        findent.r finddev.r connect.r openport.r openuucp.r findwork.r \
        filexfer.r gproto.r dumpcode.r filemove.r fixperms.r closeuucp.r \
        parse.r docmd.r gtime.r mfgets.r strdetab.r getenv.r strdup.r \
        getdirs.r strstr.r pwent.r

uucico: $(_UUCICO)
	$(CC) -f=uucico $(CFLAGS) $(_UUCICO) $(LIB) -m=4k

_MAILX = mail.r recvmail.r sendmail.r getuser.r docmd.r parse.r fixline.r \
        filemove.r maketemp.r getseq.r getval.r fixperms.r getparam.r \
        userparam.r t2test.r date822.r gtime.r doalias.r forkshell.r \
        strdup.r mfgets.r strdetab.r getenv.r termio.r nmload.r getdirs.r \
        pwent.r

mailx: $(_MAILX)
	$(CC) -f=mailx $(CFLAGS) $(_MAILX) $(LIB) -m=3k

_DOTILDE = dotilde.r docmd.r fixline.r parse.r forkshell.r getenv.r \
        mfgets.r strdetab.r strdup.r gtime.r filemove.r termio.r pwent.r

dotilde: $(_DOTILDE)
	$(CC) -f=dotilde $(CFLAGS) $(_DOTILDE) $(LIB) -m=2k

_RMAIL = rmail.r getline.r getuser.r validuser.r setuser.r parse.r genseq.r \
        findent.r getparam.r getval.r maketemp.r gtime.r fixperms.r \
        date822.r filemove.r doalias.r mfgets.r getenv.r strdup.r getdirs.r \
        termio.r docmd.r pwent.r

rmail: $(_RMAIL)
	$(CC) -f=rmail $(CFLAGS) $(_RMAIL) $(LIB) -m=4k

_RNEWS = rnews.r getline.r groups.r procbatch.r mbuf.r xatol.r getdirs.r \
         getparam.r parse.r strdup.r mfgets.r openarts.r makepath.r strupr.r \
         procart.r getopt.r fixref.r gtime.r log.r getenv.r

rnews: $(_RNEWS)
	$(CC) -f=rnews $(CFLAGS) $(_RNEWS) $(LIB) -m=5k -e=21

_UUXQT = uuxqt.r findxwork.r getline.r parse.r docmd.r gtime.r filemove.r \
        mfgets.r getopt.r strdetab.r strdup.r getdirs.r strupr.r nmload.r \
        getenv.r

uuxqt: $(_UUXQT)
	$(CC) -f=uuxqt $(CFLAGS) $(_UUXQT) $(LIB) -m=3k

_READNEWS = readnews.r getuser.r makepath.r parse.r filemove.r fixline.r \
        docmd.r newsutils.r getval.r getparam.r userparam.r gtime.r \
        t2test.r forkshell.r mfgets.r strupr.r strdetab.r getenv.r strdup.r \
        getdirs.r termio.r pwent.r

readnews: $(_READNEWS)
	$(CC) -f=readnews $(CFLAGS) $(_READNEWS) $(LIB) -m=4k

_POSTNEWS = postnews.r getuser.r maketemp.r getseq.r findent.r \
        getsys.r docmd.r fixline.r filemove.r genseq.r getparam.r \
        userparam.r parse.r t2test.r fixperms.r gtime.r date822.r mfgets.r \
        strdetab.r getenv.r strdup.r getdirs.r getopt.r termio.r nmload.r \
        pwent.r

postnews: $(_POSTNEWS)
	$(CC) -f=postnews $(CFLAGS) $(_POSTNEWS) $(LIB) -m=4k

_EXPIRE = expire.r expgroup.r makepath.r parse.r newsutils.r gtime.r \
        filemove.r strupr.r mfgets.r strdetab.r strdup.r getdirs.r getopt.r \
        getenv.r

expire: $(_EXPIRE)
	$(CC) -f=expire $(CFLAGS) $(_EXPIRE) $(LIB) -m=2k

_SUBSCRIBE = subscribe.r filemove.r mfgets.r getenv.r pwent.r strdup.r

subscribe: $(_SUBSCRIBE)
	$(CC) -f=subscribe $(CFLAGS) $(_SUBSCRIBE) $(LIB) -m=1k

_UNSUBSCRIBE = unsubscribe.r filemove.r mfgets.r getenv.r pwent.r strdup.r

unsubscribe: $(_UNSUBSCRIBE)
	$(CC) -f=unsubscribe $(CFLAGS) $(_UNSUBSCRIBE) $(LIB) -m=1k

_UULOG = uulog.r getopt.r getenv.r strdup.r mfgets.r

uulog: $(_UULOG)
	$(CC) -f=uulog $(CFLAGS) $(_UULOG) $(LIB) -m=1k

_UUCLEAN = uuclean.r getparam.r parse.r docmd.r maketemp.r mfgets.r \
           gtime.r filemove.r date822.r setuser.r getval.r getenv.r \
           strdup.r getdirs.r getopt.r pwent.r

uuclean: $(_UUCLEAN)
	$(CC) -f=uuclean $(CFLAGS) $(_UUCLEAN) $(LIB) -m=4k

_UUSTAT = uustat.r

uustat: $(_UUSTAT)
	$(CC) -f=uustat $(CFLAGS) $(_UUSTAT) $(LIB) -m=1k

_UUCP = uucp.r getuser.r getparam.r parse.r genseq.r fixperms.r maketemp.r \
        docmd.r mfgets.r gtime.r getenv.r strdup.r getdirs.r pwent.r

uucp: $(_UUCP)
	$(CC) -f=uucp $(CFLAGS) $(_UUCP) $(LIB) -m=2k

_UUDECODE = uudecode.r

uudecode: $(_UUDECODE)
	$(CC) -f=uudecode $(CFLAGS) $(_UUDECODE) $(LIB) -m=1k

_UUENCODE = uuencode.r

uuencode: $(_UUENCODE)
	$(CC) -f=uuencode $(CFLAGS) $(_UUENCODE) $(LIB) -m=1k

_CHOWN = chown.r pwent.r

chown: $(_CHOWN)
	$(CC) -f=chown $(CFLAGS) $(_CHOWN) $(LIB)

_WHOAMI = whoami.r pwent.r

whoami: $(_WHOAMI)
	$(CC) -f=whoami $(CFLAGS) $(_WHOAMI) $(LIB) -m=1k

_FIXTEXT = fixtext.r fixline.r strdetab.r mfgets.r

fixtext: $(_FIXTEXT)
	$(CC) -f=fixtext $(CFLAGS) $(_FIXTEXT) $(LIB)

_CNVRTMAIL = cnvrtmail.r docmd.r fixperms.r gtime.r strupr.r getval.r \
             mfgets.r filemove.r getenv.r parse.r pwent.r strdup.r

cnvrtmail: $(_CNVRTMAIL)
	$(CC) -f=cnvrtmail $(CFLAGS) $(_CNVRTMAIL) $(LIB) -m=4k

_LOGIN = login.r parse.r fixperms.r pwent.r getenv.r strdup.r

login: $(_LOGIN)
	$(CC) -f=login $(CFLAGS) $(_LOGIN) $(LIB) -m=1k

_ADDUSER = adduser.r strdetab.r getenv.r strdup.r termio.r mfgets.r pwent.r

adduser: $(_ADDUSER)
	$(CC) -f=adduser $(CFLAGS) $(_ADDUSER) $(LIB) -m=1k

_UUSETUP = uusetup.r getdevices.r parse.r strupr.r mfgets.r termio.r

uusetup: $(_UUSETUP)
	$(CC) -f=uusetup $(CFLAGS) $(_UUSETUP) $(LIB) -m=1k

_FILESERV = fileserv.r getparam.r getdirs.r strdup.r mfgets.r getval.r \
    maketemp.r filemove.r docmd.r gtime.r date822.r getseq.r fixperms.r \
    parse.r getenv.r

fileserv: $(_FILESERV)
	$(CC) -f=fileserv $(CFLAGS) $(_FILESERV) $(LIB) -m=3k

_UUNAME = uuname.r parse.r mfgets.r

uuname: $(_UUNAME)
	$(CC) -f=uuname $(CFLAGS) $(_UUNAME) $(LIB)

clean:
	$(RM) *.r $(OBJS)
	
#
# Dependencies between .c and .h files
#
uucico.r: uucico.c uucp.h proto.h os_misc.h uucico.h
findmach.r: findmach.c uucp.h proto.h os_misc.h uucico.h
findline.r: findline.c uucp.h proto.h os_misc.h
findent.r: findent.c uucp.h proto.h os_misc.h
chksched.r: chksched.c uucp.h proto.h os_misc.h uucico.h
finddev.r: finddev.c uucp.h proto.h os_misc.h
openport.r: openport.c uucp.h proto.h os_misc.h uucico.h
openuucp.r: openuucp.c uucp.h proto.h os_misc.h uucico.h
gproto.r: gproto.c uucp.h proto.h os_misc.h uucico.h
dumpcode.r: dumpcode.c uucp.h proto.h os_misc.h
closeuucp.r: closeuucp.c uucp.h proto.h os_misc.h uucico.h
connect.r: connect.c uucp.h proto.h os_misc.h uucico.h
findwork.r: findwork.c uucp.h proto.h os_misc.h uucico.h
filexfer.r: filexfer.c uucp.h proto.h os_misc.h uucico.h
docmd.r: docmd.c uucp.h proto.h os_misc.h
getsys.r: getsys.c uucp.h proto.h os_misc.h
getparam.r: getparam.c uucp.h proto.h os_misc.h uucico.h
getopt.r: getopt.c getopt.h
dotilde.r: dotilde.c uucp.h proto.h os_misc.h
userparam.r: userparam.c uucp.h proto.h os_misc.h
doalias.r: doalias.c uucp.h proto.h os_misc.h
mail.r: mail.c uucp.h proto.h os_misc.h mail.h
recvmail.r: recvmail.c uucp.h proto.h os_misc.h mail.h
sendmail.r: sendmail.c uucp.h proto.h os_misc.h mail.h
mailx.r: mail.c uucp.h proto.h os_misc.h mail.h
recvmail.r: recvmail.c uucp.h proto.h os_misc.h mail.h
rmail.r: rmail.c uucp.h proto.h os_misc.h
genseq.r: genseq.c uucp.h proto.h os_misc.h
rnews.r: rnews.c uucp.h proto.h os_misc.h rnews.h mbuf.h getopt.h
groups.r: groups.c uucp.h proto.h os_misc.h rnews.h mbuf.h
procbatch.r: procbatch.c uucp.h proto.h os_misc.h rnews.h mbuf.h
xatol.r: xatol.c
mbuf.r: mbuf.c mbuf.h
openarts.r: openarts.c uucp.h proto.h os_misc.h rnews.h mbuf.h
procart.r: procart.c uucp.h proto.h os_misc.h rnews.h mbuf.h
fixref.r: fixref.c
log.r: log.c uucp.h proto.h os_misc.h
validuser.r: validuser.c uucp.h proto.h os_misc.h
uuxqt.r: uuxqt.c uucp.h proto.h os_misc.h
findxwork.r: findxwork.c uucp.h proto.h os_misc.h
readnews.r: readnews.c uucp.h proto.h os_misc.h
newsutils.r: newsutils.c uucp.h proto.h os_misc.h
postnews.r: postnews.c uucp.h proto.h os_misc.h
expire.r: expire.c uucp.h proto.h os_misc.h
expgroup.r: expgroup.c uucp.h proto.h os_misc.h
subscribe.r: subscribe.c uucp.h proto.h os_misc.h
unsubscribe.r: unsubscribe.c uucp.h proto.h os_misc.h
uulog.r: uulog.c uucp.h proto.h os_misc.h
uuclean.r: uuclean.c uucp.h proto.h os_misc.h
uustat.r: uustat.c uucp.h proto.h os_misc.h
uucp.r: uucp.c uucp.h proto.h os_misc.h
cnvrtmail.r: cnvrtmail.c uucp.h proto.h os_misc.h
login.r: login.c uucp.h proto.h os_misc.h
chown.r: chown.c uucp.h proto.h os_misc.h
adduser.r: adduser.c uucp.h proto.h os_misc.h
uusetup.r: uusetup.c uucp.h proto.h os_misc.h uusetup.h
getdevices.r: getdevices.c uucp.h proto.h os_misc.h uusetup.h
getenv.r: getenv.c uucp.h proto.h os_misc.h
getseq.r: getseq.c uucp.h proto.h os_misc.h
maketemp.r: maketemp.c uucp.h proto.h os_misc.h
forkhsell.r: forkshell.c uucp.h proto.h os_misc.h
setuser.r: setuser.c uucp.h proto.h os_misc.h
filemove.r: filemove.c uucp.h proto.h os_misc.h
fixpath.r: fixpath.c uucp.h proto.h os_misc.h
makepath.r: makepath.c uucp.h proto.h os_misc.h
getdirs.r: getdirs.c uucp.h proto.h os_misc.h
fixline.r: fixline.c uucp.h proto.h os_misc.h
getenv.r: getenv.c uucp.h proto.h os_misc.h
fileserv.r: fileserv.c uucp.h proto.h os_misc.h
osk.r: osk.c uucp.h proto.h os_misc.h
pwent.r: pwent.c uucp.h proto.h os_misc.h
uuname.r: uuname.c uucp.h proto.h os_misc.h
parse.r: parse.c uucp.h proto.h os_misc.h
