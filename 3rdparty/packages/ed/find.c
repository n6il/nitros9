/*      find.c  */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

int find(pat, dir)
TOKEN *pat;
int dir;
{
  int i, num;
  char lin[MAXLINE];
  LINE *ptr;

  num = curln;
  ptr = getptr(curln);
  num = (dir ? nextln(num) : prevln(num));
  ptr = (dir ? ptr->l_next : ptr->l_prev);
  for (i = 0; i < lastln; i++) {
        if (num == 0) {
                num = (dir ? nextln(num) : prevln(num));
                ptr = (dir ? ptr->l_next : ptr->l_prev);
        }
        strcpy(lin, ptr->l_buff);
        strcat(lin, "\n");
        if (matchs(lin, pat, 0)) {
                return(num);
        }
        num = (dir ? nextln(num) : prevln(num));
        ptr = (dir ? ptr->l_next : ptr->l_prev);
  }
  return(ERR);
}

