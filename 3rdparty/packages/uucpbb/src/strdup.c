/* Returns a pointer to the string copy if successful.  Returns a NULL if
   malloc() can't get enough memory.   --REB */

#include "uucp.h"


char *strdup (string)
register char *string;
{
     char *dup;

     /* grab some memory for the string, don't forget the ending NULL */
     dup = (char *)malloc ((strlen (string) + 1) * sizeof (char));

     /* copy the string and return a pointer to it if malloc() succeeded */
     if (dup != NULL)
          strcpy (dup, string);

     return (dup);
}
