/*      doprnt.c        */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

int doprnt(from, to)
int from, to;
{
  int i;
  LINE *lptr;

  from = from < 1 ? 1 : from;
  to = to > lastln ? lastln : to;

  if (to != 0) {
        lptr = getptr(from);
        for (i = from; i <= to; i++) {
                prntln(lptr->l_buff, lflg, (nflg ? i : 0));
                lptr = lptr->l_next;
        }
        curln = to;
  }
  return(0);
}

prntln(str, vflg, lin)
char *str;
int vflg, lin;
{
  if (lin) printf("%7d ", lin);
  while (*str && *str != NL) {
        if (*str < ' ' || *str >= 0x7f) {
                switch (*str) {
                    case '\t':
                        if (vflg)
                                putcntl(*str, stdout);
                        else
                                putc(*str, stdout);
                        break;

                    case DEL:
                        putc('^', stdout);
                        putc('?', stdout);
                        break;

                    default:
                        putcntl(*str, stdout);
                        break;
                }
        } else
                putc(*str, stdout);
        str++;
  }
  if (vflg) putc('$', stdout);
  putc('\n', stdout);
}

putcntl(c, stream)
char c;
FILE *stream;
{
  putc('^', stream);
  putc((c & 31) | '@', stream);
}

