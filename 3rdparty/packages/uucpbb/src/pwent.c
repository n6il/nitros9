/* Carl Kreider's UNIX-style password functions.

   UNIX-style comment support added for use with UUCPbb package.  Lines
   starting with a '*' in the password file are ignored.  --REB
*/


#include "uucp.h"
#include <password.h>


static int     pwpn = 0;
#ifdef _OSK
char           _pwdelim = 'a';
#else
char           _pwdelim = OS9DLM;
#endif

static char    tmpbuf[PWSIZ+1];
static PWENT   pwent, *parse();


/*
** get the next password entry.  ignore lines beginning with a '*'.
*/

PWENT *getpwent()
{
     register char  *p;

     if (pwpn == 0)
          if ((pwpn = open(PASSWORD, 1)) <= 0)
               return ((PWENT *) 0);

     for (;;) {
          if (readln(pwpn, tmpbuf, PWSIZ) > 0) {
               if (*tmpbuf == '*')
                    continue;

               for (p = tmpbuf;
                    (*p != '\n') && (_pwdelim != ',' && _pwdelim != ':'); )
               {
                    _pwdelim = *p++;
               }

               if (*p != '\n')
                    return (parse(tmpbuf, &pwent));
          }
          return ((PWENT *) 0);
     }
}



/*
** rewind the password file
*/

void setpwent()
{
   if (pwpn != 0)
        lseek(pwpn, 0L, 0);
}



/*
** terminate password file access
*/

void endpwent()
{
     if (pwpn != 0)
       {
          close(pwpn);
          pwpn = 0;
       }
}



/*
** return the password delimiter
*/

int getpwdlm()
{
     return ((int) _pwdelim);
}
/*page*/
/*
** routine to parse a password file entry
*/

static PWENT *parse(p, pwp)
register char  *p;
PWENT *pwp;
{
     pwp->ugcos = (char *) 0;                         /* just in case */
     pwp->unam = p;
     *(p = strchr (p, _pwdelim)) = '\0';
     pwp->upw = ++p;
     *(p = strchr (p, _pwdelim)) = '\0';
     pwp->uid = ++p;
     *(p = strchr (p, _pwdelim)) = '\0';
     pwp->upri = ++p;
     *(p = strchr (p, _pwdelim)) = '\0';

     if (_pwdelim == UNXDLM)
       {
          pwp->ugcos = ++p;
          *(p = strchr (p, _pwdelim)) = '\0';
       }

     pwp->ucmd = ++p;
     *(p = strchr (p, _pwdelim)) = '\0';
     pwp->udat = ++p;
     *(p = strchr (p, _pwdelim)) = '\0';
     pwp->ujob = ++p;
     *(strchr (p, '\n')) = '\0';
     return (pwp);
}



/*
** find a user by ID
*/

PWENT *getpwuid(uid)
int   uid;
{
     register PWENT *pwp;

     while (pwp = getpwent())
#ifdef _OSK
          if (uid == uIDtoInt(pwp->uid))
#else
          if (uid == atoi(pwp->uid))
#endif
              return (pwp);

     return ((PWENT *) 0);
}



/*
** find a user by name
*/

PWENT *getpwnam(name)
char  *name;
{
     register PWENT *pwp;

     while (pwp = getpwent())
          if (strucmp (name, pwp->unam) == 0)
               return (pwp);
     return ((PWENT *) 0);
}
