/*      deflt.c */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

int deflt(def1, def2)
int def1, def2;
{
  if (nlines == 0) {
        line1 = def1;
        line2 = def2;
  }
  if (line1 > line2 || line1 <= 0) return(ERR);
  return(0);
}

