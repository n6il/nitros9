/*      join.c  */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

extern int fchanged;

int join(first, last)
int first, last;
{
  char buf[MAXLINE];
  char *cp = buf, *str;
  int num;

  if (first <= 0 || first > last || last > lastln) return(ERR);
  if (first == last) {
        curln = first;
        return 0;
  }
  for (num = first; num <= last; num++) {
        str = gettxt(num);

        while (*str != NL && cp < buf + MAXLINE - 1) *cp++ = *str++;

        if (cp == buf + MAXLINE - 1) {
                printf("line too long\n");
                return(ERR);
        }
  }
  *cp++ = NL;
  *cp = EOS;
  del(first, last);
  curln = first - 1;
  ins(buf);
  fchanged = TRUE;
  return 0;
}

