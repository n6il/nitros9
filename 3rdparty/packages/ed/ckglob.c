/*      ckglob.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

int ckglob()
{
  TOKEN *glbpat;
  char c, delim;
  char lin[MAXLINE];
  int num;
  LINE *ptr;

  c = *inptr;

  if (c != 'g' && c != 'v') return(0);

  if (deflt(1, lastln) < 0) return(ERR);

  delim = *++inptr;
  if (delim <= ' ') return(ERR);

  glbpat = optpat();

  if (*inptr == delim) inptr++;

  ptr = getptr(1);
  for (num = 1; num <= lastln; num++) {
        ptr->l_stat &= ~LGLOB;
        if (line1 <= num && num <= line2) {
                strcpy(lin, ptr->l_buff);
                strcat(lin, "\n");
                if (matchs(lin, glbpat, 0)) {
                        if (c == 'g') ptr->l_stat |= LGLOB;
                } else {
                        if (c == 'v') ptr->l_stat |= LGLOB;
                }
        }
        ptr = ptr->l_next;
  }
  return(1);
}

