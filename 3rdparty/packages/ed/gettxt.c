/*      gettxt.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

char *
 gettxt(num)
int num;
{
  LINE *lin;
  static char txtbuf[MAXLINE];

  lin = getptr(num);
  strcpy(txtbuf, lin->l_buff);
  strcat(txtbuf, "\n");
  return(txtbuf);
}

