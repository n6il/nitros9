/*      dodash.c        */
#include <stdio.h>
#include "tools.h"

/*      Expand the set pointed to by *src into dest.
 *      Stop at delim.  Return 0 on error or size of
 *      character class on success.  Update *src to
 *      point at delim.  A set can have one element
 *      {x} or several elements ( {abcdefghijklmnopqrstuvwxyz}
 *      and {a-z} are equivalent ).  Note that the dash
 *      notation is expanded as sequential numbers.
 *      This means (since we are using the ASCII character
 *      set) that a-Z will contain the entire alphabet
 *      plus the symbols: [\]^_`.  The maximum number of
 *      characters in a character class is defined by maxccl.
 */
char *dodash(delim, src, map)
int delim;
char *src, *map;
{

  register int first, last;
  char *start;

  start = src;

  while (*src && *src != delim) {
        if (*src != '-') setbit(esc(&src), map, 1);

        else if (src == start || *(src + 1) == delim)
                setbit('-', map, 1);
        else {
                src++;

                if (*src < *(src - 2)) {
                        first = *src;
                        last = *(src - 2);
                } else {
                        first = *(src - 2);
                        last = *src;
                }

                while (++first <= last) setbit(first, map, 1);

        }
        src++;
  }
  return(src);
}

