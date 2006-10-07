
struct direct {
   long  d_addr;        /* file desc addr */
   char  d_name[30];    /* directory entry name */
   } ;

/* there is #define DIR in stdio.h.  This causes a problem with using DIR
** for this typedef.  Changing it to _DIR will eliminate this problem.
** -- Bob Billson
*/

typedef struct {
   int   dd_fd;         /* fd for open directory */
   char  dd_buf[32];    /* a one entry buffer */
   } DIR;

#define DIRECT       struct direct
#define rewinddir(a) seekdir(a, 0L)

extern DIR           *opendir();
extern DIRECT        *readdir();
extern long          telldir();
extern int /* void */    seekdir(), closedir();
