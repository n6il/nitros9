/*      doglob.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

int doglob()
{
  int lin, stat;
  char *cmd;
  LINE *ptr;

  cmd = inptr;

  while (1) {
        ptr = getptr(1);
        for (lin = 1; lin <= lastln; lin++) {
                if (ptr->l_stat & LGLOB) break;
                ptr = ptr->l_next;
        }
        if (lin > lastln) break;

        ptr->l_stat &= ~LGLOB;
        curln = lin;
        inptr = cmd;
        if ((stat = getlst()) < 0) return(stat);
        if ((stat = docmd(1)) < 0) return (stat);
  }
  return(curln);
}

