/* convert a string to upper case.  Returns a pointer to the start of the
** string.
*/

char *strupr (string)
char *string;
{
     register char *p;

     p = string;

     while (*p)
          *p++ = toupper (*p);

     return (string);
}



/* convert a string to lower case.  Returns aa pointer to the start of the
** string.
*/

char *strlwr (string)
char *string;
{
     register char *p;

     p = string;

     while (*p)
          *p++ = tolower (*p);

     return (string);
}
