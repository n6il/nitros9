/*  osk.c   Various function OSK requires.
    Copyright (C) 1994  Boisy G. Pitre

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

#ifdef _OSK
/********************************************************************\
* Functions which are in the CoCo C libraries but not OSK's or are   *
* unique to OSK.  Written by Boisy Pitre.                            *
\********************************************************************/

#include "uucp.h"
#include "password.h"

char *strend();

#ifndef _UCC
/* MWC 3.2 doesn't have strtok() or strpbrk(), so we provide it */
char *strtok();
char *strpbrk();

unsigned char chartable[16];
unsigned char cval;

static char *p_last1 = "";

char *strtok(s1,s2)
char *s1;
char *s2;
{
        register unsigned char *p;
        register unsigned char c;
        register int i;

        if (s1 == NULL)
                s1 = p_last1;

        if (++cval == 0) {
                memset(chartable, sizeof(chartable), 0);
                cval++;
        }
        c = cval;
        for (p = (unsigned char *)s2; *p;)
                chartable[*p++] = c;

        for (p = (unsigned char *)s1; *p; p++)
                if (chartable[*p] != c)
                        break;
        if (*p == '\0')
                return((char *)NULL);
        s1 = (char *)p;

        for (; *p; p++)
                if (chartable[*p] == c)
                        break;

        p_last1 = (char *)p; 

        if (*p != '\0') {
                *p_last1++ = '\0';
        }
        return(s1);
}


char *strpbrk(line, delims)
char *line, *delims;
{
 char *p = line, *q;

 while (*p != '\0') {
  for (q = delims; q != '\0'; q++) {
   if (*p == *q) return(p);
  }
 }
 return(NULL);
}
#endif  /* !_UCC */



char *strend (s)
char *s;
{
     while (*s)
          ++s;

    return (s);
}



int min (v1, v2)
int v1, v2;
{
     return ((v1 < v2) ? v1 : v2);
}



int max (v1, v2)
int v1, v2;
{
     return ((v1 > v2) ? v1 : v2);
}



asetuid (uid)
int uid;
{
    setuid (uid);
}



/* strnucmp - string compare w/ case masking on a set number of characters.
   compares two strings regardless of their case up to 'n' characters
   and returns:
     -1  str1 < str2
      0  str1 = str2
      1  str1 > str2

NOTE: strnucmp() will replace an occurence of \n (carriage return) with a
      NULL!  This allows you to pass in strings that are carriage
      return-terminated without worry, but be cautious if that's NOT what you
      want to do.
*/

int strnucmp (str1, str2, length)
register char *str1, *str2;
register int length;
{
     int pl1, pl2;
     register char *p;

     if ((p = strchr (str1,'\n')) != NULL)   *p ='\0';
     if ((p = strchr (str2,'\n')) != NULL)   *p ='\0';
     pl1 = pl2 = length;

     while ((pl1 > 1) && (toupper (*str1) == toupper (*str2))) {
          --pl1;
          ++str1;
          ++str2;
     }

     if (*str1 == *str2) return(0);
     if (*str1 > *str2) return(1);
     return(-1);
}



int strucmp (str1, str2)
register char *str1, *str2;
{
     register char *p;

     if ((p = strchr (str1,'\n')) != NULL)   *p ='\0';
     if ((p = strchr (str2,'\n')) != NULL)   *p ='\0';

     while (toupper (*str1) == toupper (*str2) && *str1 && *str2) {
          ++str1;
          ++str2;
     }

     if (*str1 == *str2)  return(0);
     if (*str1 > *str2)   return(1);
     return(-1);
}



#ifdef _OSK
/* Function to return an integer value of a GID/UID string (i.e. "30.122")
   For OSK only
 */
int uIDtoInt (uidstr)
char *uidstr;
{
     char *p, tmpstr[32];

     strcpy(tmpstr, uidstr);

     if ((p = strchr(tmpstr, '.')) != 0) {
          *p = '\0';
          return (atoi(tmpstr) * 65536 + atoi (++p));
     }
     return(-1);
}



/* Function to return an a GID/UID string (i.e. "30.122") from an int
   For OSK only
   It is the caller's responsibility to free the allocated memory.
 */
char *InttouID (uid)
int uid;
{
     char *p, tmpstr[32];
     int group, user;

     p = (char *)malloc(sizeof(char) * 12);
     group = uid / 65536;
     user = uid % 65536;
     sprintf(p, "%d.%d", group, user);
     return(p);
}
#endif



/*#define MAIN   /* Only use when testing routines */

#ifdef MAIN
#define DEBUG
#endif

/*
 * Popen, and Pclose, for OS-9.
 *
 * Simmule Turner - simmy@nu.cs.fsu.edu - 70651,67
 *
 * V 1.3  10/22/88 - Forgot to close pipe on an error.
 * V 1.2  06/28/88 - Removed shell as parent process.
 *                 - It forks command directly now.
 * V 1.1  06/28/88 - Uses a shell to run child process SrT
 *                 - Fixed bug found by PWL, SrT
 *                 - Improved error checking, cleaned up code.
 * V 1.0  06/25/88 - Initial coding SrT
 *
 */

#define ERR      (-1)
#define PIPEMAX  _NFILE

#define RESTORE  close(path);dup(save);close(save);

static int   _pid[PIPEMAX];

FILE *popen(command, type)
char *command, *type;
{
     char *argv[32], cmd[256];
     FILE *_pfp;
     int l, path, pipe, pcnt, save;

     path = (*type == 'w') ? STDIN : STDOUT;

     if ((pipe = open ("/pipe",READ+WRITE)) == ERR)
          return (NULL);
     pcnt = pipe;

     if ((save = dup (path)) == ERR) {
          close (pipe);
          return (NULL);
     }
     close (path);

     if (dup (pipe) == ERR) {
          dup (save);
          close (save);
          close (pipe);   /* BUG fix  10/22/88 SrT */ 
          return (NULL);
     }

     strcpy(cmd, command);
     parse_cmd (argv, cmd);
# ifdef _UCC
     if ((_pid[pcnt] = os9exec (os9fork, argv[0], argv, _environ, 0, 0, 32)) == ERR) {
# else /* C 3.2 */
     if ((_pid[pcnt] = os9exec (os9fork, argv[0], argv, environ, 0, 0, 32)) == ERR) {
# endif
          { RESTORE }
          close (pipe);
          _pid[pcnt] = 0;
          return (NULL);
     }

     { RESTORE }

     if ((_pfp = fdopen (pipe,type)) == NULL) {
          close (pipe);
          while (((l=wait(0)) != _pid[pcnt]) && l != ERR)
               ;
          _pid[pcnt] = 0;
          return (NULL);
     }

    return (_pfp);
}



int pclose (stream)
FILE *stream;
{
     register int i;
     int f,status;

     f = fileno (stream);
     fclose (stream);
#ifdef DEBUG
     fprintf (stderr,"Pclose:  Fileno=%d  PID=%d\n",f,_pid[f]);
#endif
     while (((i=wait (&status)) != _pid[f]) && i != ERR)
          ;
     _pid[f]= 0;
     return ((i == ERR) ? ERR : status);
}



#ifdef MAIN

#define LINSIZ 200
main() {
     char line[LINSIZ];
     FILE *popen(), *fp;
     int status;

     /* Test the read side of popen
      * SrT 06/25/88 */

     if (( fp = popen ("procs e","r")) != NULL) {
          while (fgets (line,LINSIZ,fp) != NULL)
               printf ("%s",line);
          if ((status = pclose (fp)) == ERR) {
               fprintf (stderr,"***ERR: closing read pipe ERR #%03d\n",
                               status&0xff);
               exit(1);
          }
          printf ("Read status =%d\n",status&0xff);
     }
     else {
          fprintf(stderr,"***ERR: opening read pipe\n");
          exit(1);
     }

     /* Test the write side of popen
      * SrT 06/25/88 */
     if (( fp = popen ("woof one two three four","w")) != NULL) {
          while (fgets (line,LINSIZ,stdin) != NULL)
               fprintf (fp,"%s",line);
          if ((status = pclose(fp)) == ERR) {
               fprintf (stderr,"***ERR: closing write pipe ERR #%03d\n",
                               status&0xff);
               exit(1);
          }
          printf ("Write status =%d\n",status&0xff);
     }
     else {
          fprintf(stderr,"***ERR: opening write pipe\n");
          exit(1);
     }
}
#endif
#endif
