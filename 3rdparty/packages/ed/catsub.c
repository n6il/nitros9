/*      catsub.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

extern char *paropen[9], *parclose[9];

char *catsub(from, to, sub, new, newend)
char *from, *to, *sub, *new, *newend;
{
  char *cp, *cp2;

  for (cp = new; *sub != EOS && cp < newend;) {
        if (*sub == DITTO) for (cp2 = from; cp2 < to;) {
                        *cp++ = *cp2++;
                        if (cp >= newend) break;
                }
        else if (*sub == ESCAPE) {
                sub++;
                if ('1' <= *sub && *sub <= '9') {
                        char *parcl = parclose[*sub - '1'];

                        for (cp2 = paropen[*sub - '1']; cp2 < parcl;) {
                                *cp++ = *cp2++;
                                if (cp >= newend) break;
                        }
                } else
                        *cp++ = *sub;
        } else
                *cp++ = *sub;

        sub++;
  }

  return(cp);
}

