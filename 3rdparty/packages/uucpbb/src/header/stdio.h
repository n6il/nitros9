#define BUFSIZ  256
#define _NFILE  16
typedef struct _iobuf {
       char *_ptr,     /* buffer pointer */
            *_base,    /* buffer base address */
            *_end;     /* buffer end address */
       int _flag;      /* file status */
       int _fd;        /* file path number */
       char _save;     /* for 'ungetc' when unbuffered */
       int _bufsiz;    /* size of data buffer */
} FILE;

extern FILE _iob[_NFILE];

#define _READ       1
#define _WRITE      2
#define _UNBUF      4
#define _BIGBUF     8
#define _EOF        0x10
#define _ERR        0x20
#define _SCF        0x40
#define _RBF        0x80
#define _DEVMASK    0xc0
#define _WRITTEN    0x0100    /* buffer written in update mode */
#define _INIT       0x8000    /* _iob initialized */

#ifndef EOF
#define EOF (-1)
#endif

#ifndef ERROR
#define ERROR (-1)
#endif

#ifndef EOL
#define EOL 13
#endif

#ifndef NULL
#define NULL 0
#endif

#ifndef NULLCHAR
#define NULLCHAR (char *)0    /* Null character pointer */
#endif

#ifndef NULLFP
#define NULLFP (int (*)())0   /* Null pointer to function return int */
#endif

#ifndef NULLFILE
#define NULLFILE (FILE *)0    /* Null file pointer */
#endif

#define stdin _iob
#define stdout (&_iob[1])
#define stderr (&_iob[2])

#define PMODE  0xb   /* r/w for owner, r for others */

#define fgetc      getc
#define fputc      putc
#define putchar(c) putc(c,stdout)
#define getchar()  getc(stdin)
#define ferror(p)  ((p)->_flag&_ERR)
#define feof(p)    ((p)->_flag&_EOF)
#define clearerr(p) ((p)->_flag&=~_ERR)
#define cleareof(p) ((p)->_flag&=~_EOF)
#define fileno(p)   ((p)->_fd)

long ftell();

/* path constants */
#define  STDIN       0
#define  STDOUT      1
#define  STDERR      2

/* file access constants */
#define  READ        1
#define  WRITE       2
#define  UPDATE      3
#define  _DIR       0x80
#define  LOCK        -1l
#define  UNLOCK      0l

#define  TRUE        1
#define  FALSE       0
#define  YES         1
#define  NO          0

/* seek constants */
#define  FRONT       0
#define  HERE        1
#define  END         2

/* Default window colors */
#define WHITE   0
#define BLUE    1
#define BLACK   2
#define GREEN   3
#define RED     4
#define YELLOW  5
#define MAGENTA 6
#define CYAN    7

/* define many standard library functions */
extern int errno;

#ifndef _BOOLEAN_
typedef  int boolean;
#define _BOOLEAN_
#endif

#ifndef _ENUM_
typedef  int enum;
#define _ENUM_
#endif

#ifndef _VOID_
typedef int void;
#define _VOID_
#endif

float    atof();
int      atoi();
long     atol();
char     *itoa();
char     *ltoa();
char     *utoa();
int      htoi();
long     htol();
int      max();
int      min();
unsigned umin();
unsigned umax();
char     *calloc();
char     *malloc();
char     *realloc();
int      free();
