/*      getptr.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

LINE *
 getptr(num)
int num;
{
  LINE *ptr;
  int j;

  if (2 * num > lastln && num <= lastln) {      /* high line numbers */
        ptr = line0.l_prev;
        for (j = lastln; j > num; j--) ptr = ptr->l_prev;
  } else {                      /* low line numbers */
        ptr = &line0;
        for (j = 0; j < num; j++) ptr = ptr->l_next;
  }
  return(ptr);
}

