/*      dowrite.c       */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

extern int diag;

int dowrite(from, to, fname, apflg)
int from, to;
char *fname;
int apflg;
{
  FILE *fp;
  int lin, err;
  int lines;
  long bytes;
  char *str;
  LINE *lptr;

  err = 0;

  lines = bytes = 0;
  if (diag) printf("\"%s\" ", fname);
  if ((fp = fopen(fname, (apflg ? "a" : "w"))) == NULL) {
        printf("file open error\n");
        return(ERR);
  }
  lptr = getptr(from);
  for (lin = from; lin <= to; lin++) {
        str = lptr->l_buff;
        lines++;
        bytes += strlen(str) + 1;
        if (fputs(str, fp) == EOF) {
                printf("file write error\n");
                err++;
                break;
        }
        putc('\n', fp);
        lptr = lptr->l_next;
  }
  if (diag) printf("%d lines %ld bytes\n", lines, bytes);
  fclose(fp);
  return(err);
}

