/*      egets.c */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

int eightbit = 1;               /* save eight bit */
int nonascii, nullchar, truncated;
int egets(str, size, stream)
char *str;
int size;
FILE *stream;
{
  int c, count;
  char *cp;

  for (count = 0, cp = str; size > count;) {
        c = getc(stream);
        if (c == EOF) {
                *cp++ = '\n';
                *cp = EOS;
                if (count) {
                        printf("[Incomplete last line]\n");
                }
                return(count);
        }
        if (c == NL) {
                *cp++ = c;
                *cp = EOS;
                return(++count);
        }
        if (c > 127) {
                if (!eightbit)  /* if not saving eighth bit */
                        c = c & 127;    /* strip eigth bit */
                nonascii++;     /* count it */
        }
        if (c) {
                *cp++ = c;      /* not null, keep it */
                count++;
        } else
                nullchar++;     /* count nulls */
  }
  str[count - 1] = EOS;
  if (c != NL) {
        printf("truncating line\n");
        truncated++;
        while ((c = getc(stream)) != EOF)
                if (c == NL) break;
  }
  return(count);
}

