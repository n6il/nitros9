/* mail.h -- global header for OS-9 UUCPbb mailer, Mailx
    Copyright (C) 1990, 1993  Rick Adams and Bob Billson

    This file is part of the OS-9 UUCP package, UUCPbb.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

    The author of UUCPbb, Bob Billson, can be contacted at:
    bob@kc2wz.bubble.org  or  uunet!kc2wz!bob  or  by snail mail:
    21 Bates Way, Westfield, NJ 07090
*/

 /**************************************************************************\
 * The original file was all contained in mail.c.  I broke it up to make it *
 * easier to edit and maintain. -- Bob Billson (REB) <bob@kc2wz.bubble.org> *
 \**************************************************************************/

#define NOSIG      0
#define USESIG     1
#define ALTSIG     2
#define MLINE     100                        /* max size of mail..list line */
#define ENDMAIL  (MAILPTR) NULL
#define ON         1
#define OFF        0
#define FRMSIZE    19
#define SUBJSIZE   27
#define SEND       0
#define FORWARD    1
#define REVERSE    2
#define NEXT       3
#define PREVIOUS   4
#define AGAIN      5
#define DELETE     6
#define BADLETTER  7
#define QUIT       8
#define UNDELETE   9
#define KILLMAIL   10
#define ALLREAD    11

#define SETPAGER  FALSE         /* TRUE  = file viewer defaults to ON */
                                /* FALSE = file viewer defaults to OFF */

EXTERN char line[512], address[1024], subject[100], sender[100],
            message[100], cmd[100], fromname[100], fromdate[40],
            frommsgid[100], tempfile[100];

/* made globals direct page */
EXTERN QQ char *pname;                               /* pointer to our name */
EXTERN QQ flag t2flag, reply, redirect;
EXTERN QQ flag usesig, forward, usedotilde, rmailin, quiet;
EXTERN QQ int debug;
EXTERN QQ FILE *ltrfile;            /* moved from compmail() so interrupt() */
                                    /* can clean up properly */
#ifndef TERMCAP
EXTERN QQ flag winopen;
#endif

#ifdef MAIN
QQ flag usepager = SETPAGER;
QQ char *mail_list = "mail..list",
        *dotilde   = "dotilde",
        *rmail     = "rmail",
        *Hreplyto  = "Reply-To: ",
        *Hsender   = "Sender: ",
        *Hdate     = "Date: ",
        *Hcc       = "Cc: ",
        *Hsubject  = "Subject: ",
        *Hsubj     = "Subj: ",
        *Hfrom     = "From: ",
        *Hx        = "X-",
        *Hto       = "To: ";
#else
extern QQ flag usepager;
extern QQ char *mail_list, *dotilde, *rmail, *Hreplyto, *Hsender, *Hdate;
extern QQ char *Hcc, *Hsubject, *Hsubj, *Hfrom, *Hx, *Hto;
#endif

extern QQ char *name, *sitename, *pager;
extern char tz[], user[], temp[], fname[];
extern QQ flag cc_prompt, fullheader;
extern QQ unsigned myuid;

char *getinput();

/* points to mail to be read by Mailx (current version) */
struct mailbag {
     struct mailbag *prev, *next;
     char *mline,
          status,
          *letter;
   };

#ifdef NEWVERSION
/* We don't use this structure yet.  This is for future development.  The
   above structure is used for Mailx right now. --REB  */

/* points to mail to be read by Mailx (future version) --REB */
struct mailbag {
     struct mailbag *prev, *next;
     char *mline,
          status,
          *letter,
          *from,
          *date,
          *lncount,
          *fsize,
          *subj;
      };
#endif

typedef struct mailbag MAILBAG, *MAILPTR;
