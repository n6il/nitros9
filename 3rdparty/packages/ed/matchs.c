/*      matchs.c        */
#include <stdio.h>
#include "tools.h"

/* Compares line and pattern.  Line is a character string while pat
 * is a pattern template made by getpat().
 * Returns:
 *      1. A zero if no match was found.
 *
 *      2. A pointer to the last character satisfing the match
 *         if ret_endp is non-zero.
 *
 *      3. A pointer to the beginning of the matched string if
 *         ret_endp is zero.
 *
 * e.g.:
 *
 *      matchs ("1234567890", getpat("4[0-9]*7), 0);
 * will return a pointer to the '4', while:
 *
 *      matchs ("1234567890", getpat("4[0-9]*7), 1);
 * will return a pointer to the '7'.
 */
char *
 matchs(line, pat, ret_endp)
char *line;
TOKEN *pat;
int ret_endp;
{

  char *rval, *bptr;
  char *line2;
  TOKEN *pat2;
  char c;
  short ok;

  bptr = line;

  while (*line) {

        if (pat && pat->tok == LITCHAR) {
                while (*line) {
                        pat2 = pat;
                        line2 = line;
                        if (*line2 != pat2->lchar) {
                                c = pat2->lchar;
                                while (*line2 && *line2 != c) ++line2;
                                line = line2;
                                if (*line2 == '\0') break;
                        }
                        ok = 1;
                        ++line2;
                        pat2 = pat2->next;
                        while (pat2 && pat2->tok == LITCHAR) {
                                if (*line2 != pat2->lchar) {
                                        ok = 0;
                                        break;
                                }
                                ++line2;
                                pat2 = pat2->next;
                        }
                        if (!pat2) {
                                if (ret_endp)
                                        return(--line2);
                                else
                                        return(line);
                        } else if (ok)
                                break;
                        ++line;
                }
                if (*line == '\0') return(0);
        } else {
                line2 = line;
                pat2 = pat;
        }
        if ((rval = amatch(line2, pat2, bptr)) == 0) {
                if (pat && pat->tok == BOL) break;
                line++;
        } else {
                if (rval > bptr && rval > line)
                        rval--; /* point to last char matched */
                rval = ret_endp ? rval : line;
                break;
        }
  }
  return(rval);
}

