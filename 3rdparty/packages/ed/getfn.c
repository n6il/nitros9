/*      getfn.c */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

extern char fname[MAXFNAME];
int nofname;

char *getfn()
{
  static char file[256];
  char *cp;

  if (*inptr == NL) {
        nofname = TRUE;
        strcpy(file, fname);
  } else {
        nofname = FALSE;
        while (*inptr == SP || *inptr == HT) inptr++;

        cp = file;
        while (*inptr && *inptr != NL && *inptr != SP && *inptr != HT) {
                *cp++ = *inptr++;
        }
        *cp = '\0';

        if (strlen(file) == 0) {
                printf("bad file name\n");
                return(NULL);
        }
  }

  if (strlen(file) == 0) {
        printf("no file name\n");
        return(NULL);
  }
  return(file);
}

