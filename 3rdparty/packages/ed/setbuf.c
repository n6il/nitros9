/*      setbuf.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

relink(a, x, y, b)
LINE *a, *x, *y, *b;
{
  x->l_prev = a;
  y->l_next = b;
}

clrbuf()
{
  del(1, lastln);
}

set_buf()
{
  relink(&line0, &line0, &line0, &line0);
  curln = lastln = 0;
}

