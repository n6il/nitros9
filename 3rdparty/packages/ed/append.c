/*      append.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

int append(line, glob)
int line, glob;
{
  int stat;
  char lin[MAXLINE];

  if (glob) return(ERR);
  curln = line;
  while (1) {
        if (nflg) printf("%6d. ", curln + 1);

        if (fgets(lin, MAXLINE, stdin) == NULL) return(EOF);
        if (lin[0] == '.' && lin[1] == '\n') return (0);
        stat = ins(lin);
        if (stat < 0) return(ERR);

  }
}

