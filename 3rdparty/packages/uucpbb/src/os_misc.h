/*  os_misc.h   Miscellaneous and system dependent defs and macros.
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

/* Miscellaneous and system dependent defs for UUCPbb package to keep uucp.h
   from becoming huge.  Also includes non-standard Cish stuff unique to
   OS-9/6809, OS-9/68K and OS-9000. */

#include "proto.h"
#include <errno.h>

 /***************************\
 * CoCo specific defs/macros *
 \***************************/

#ifndef _OSK
#define PORTSLEEP 15                   /* 1/4 second worth of ticks */
#define PORTMODE  S_IREAD+S_IWRITE
#endif


 /**************************\
 * OSK specific defs/macros *
 \**************************/

#ifdef _OSK
#define PORTSLEEP 0x80000040           /* 1/4 second worth of ticks */
#define PORTMODE  S_ISHARE+S_IREAD+S_IWRITE
#endif


 /******************************\
 * OS-9000 specific defs/macros *
 \******************************/

#ifdef _OS9K
#define PORTSLEEP   0x80000040           /* 1/4 second worth of ticks */
#define fileno(x)   _fileno(x)
#define PORTMODE  S_ISHARE+S_IREAD+S_IWRITE
#endif


 /*=========== miscellaneous defines/macros applies to everyone ===========*/

/* Define a common name for the non sharable error which is different
 * between OS-9/6809 and OSK systems
 */
#ifndef _OSK
#define NONSHARE E_DEVBSY        /* OS-9/6809 */
#else
#define NONSHARE E_SHARE
#endif

/* Define the maximum priority of the system */
#ifdef _OSK
#define MAXPRIORITY 65535
#else
#define MAXPRIORITY 255
#endif

/* Adds NUL to end of s1 if n < strlen (s2) */
#define strncpy0(s1,s2,n)  {strncpy (s1,s2,n); s1[n-1] = '\0';}

#ifdef  SS_SIZE                    /* this is what Level 1 called it */
#define SS_SIZE   SS_SIZ           /* this is what Level 2 calls it */
#endif

#ifndef SS_SCSIZ                   /* just in case */
#define SS_SCSIZ  0x26
#endif

#ifndef SS_SIZ                     /* ...ditto... */
#define SS_SIZ    0x02
#endif

#ifndef SS_HNGUP
#define SS_HNGUP  0x02             /* drop DTR to hang up modem */
#endif

#ifndef ERROR                      /* ...ditto... */
#define ERROR    (-1)
#endif

#ifndef TRUE                       /* ...ditto.. */
#define TRUE      1
#endif

#ifndef FALSE                      /* ...one more time */
#define FALSE     0
#endif


#ifndef STDIN                      /* Added -- BGP */
#define STDIN     0
#endif

#ifndef STDOUT
#define STDOUT    1
#endif

#ifndef STDERR
#define STDERR    2
#endif

#ifndef READ
#define READ      1
#endif

#ifndef WRITE
#define WRITE     2
#endif

#ifndef FRONT
#define FRONT     0
#endif
