/*      omatch.c        */
#include <stdio.h>
#include "tools.h"

/* Match one pattern element, pointed at by pat, with the character at
 * **linp.  Return non-zero on match.  Otherwise, return 0.  *Linp is
 * advanced to skip over the matched character; it is not advanced on
 * failure.  The amount of advance is 0 for patterns that match null
 * strings, 1 otherwise.  "boln" should point at the position that will
 * match a BOL token.
 */
int omatch(linp, pat, boln)
char **linp;
TOKEN *pat;
char *boln;
{

  register int advance;

  advance = -1;

  if (**linp) {
        switch (pat->tok) {
            case LITCHAR:
                if (**linp == pat->lchar) advance = 1;
                break;

            case BOL:
                if (*linp == boln) advance = 0;
                break;

            case ANY:
                if (**linp != '\n') advance = 1;
                break;

            case EOL:
                if (**linp == '\n') advance = 0;
                break;

            case CCL:
                if (testbit(**linp, pat->bitmap)) advance = 1;
                break;

            case NCCL:
                if (!testbit(**linp, pat->bitmap)) advance = 1;
                break;
        }
  }
  if (advance >= 0) *linp += advance;

  return(++advance);
}

