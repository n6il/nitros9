/*      getone.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

#define FIRST 1
#define NOTFIRST 0

int getone()
{
  int c, i, num;

  if ((num = getnum(FIRST)) >= 0) {
        while (1) {
                while (*inptr == SP || *inptr == HT) inptr++;

                if (*inptr != '+' && *inptr != '-') break;
                c = *inptr++;

                if ((i = getnum(NOTFIRST)) < 0) return(i);

                if (c == '+') {
                        num += i;
                } else {
                        num -= i;
                }
        }
  }
  return(num > lastln ? ERR : num);
}

