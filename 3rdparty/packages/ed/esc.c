/*      esc.c   */
#include <stdio.h>
#include "tools.h"

/* Map escape sequences into their equivalent symbols.  Returns the
 * correct ASCII character.  If no escape prefix is present then s
 * is untouched and *s is returned, otherwise **s is advanced to point
 * at the escaped character and the translated character is returned.
 */
int esc(s)
char **s;
{
  register int rval;

  if (**s != ESCAPE) {
        rval = **s;
  } else {
        (*s)++;

        switch (toupper(**s)) {
            case '\000':        rval = ESCAPE;  break;
            case 'S':   rval = ' ';     break;
            case 'N':   rval = '\n';    break;
            case 'T':   rval = '\t';    break;
            case 'B':   rval = '\b';    break;
            case 'R':   rval = '\r';    break;
            default:    rval = **s;     break;
        }
  }

  return(rval);
}

