/*      tools.h */
/*
 *      #defines for non-printing ASCII characters
 */

#define NUL     0x00            /* ^@ */
#define EOS     0x00            /* end of string */
#define SOH     0x01            /* ^A */
#define STX     0x02            /* ^B */
#define ETX     0x03            /* ^C */
#define EOT     0x04            /* ^D */
#define ENQ     0x05            /* ^E */
#define ACK     0x06            /* ^F */
#define BEL     0x07            /* ^G */
#define BS      0x08            /* ^H */
#define HT      0x09            /* ^I */
#define LF      0x0a            /* ^J */
#define NL      '\n'
#define VT      0x0b            /* ^K */
#define FF      0x0c            /* ^L */
#define CR      0x0d            /* ^M */
#define SO      0x0e            /* ^N */
#define SI      0x0f            /* ^O */
#define DLE     0x10            /* ^P */
#define DC1     0x11            /* ^Q */
#define DC2     0x12            /* ^R */
#define DC3     0x13            /* ^S */
#define DC4     0x14            /* ^T */
#define NAK     0x15            /* ^U */
#define SYN     0x16            /* ^V */
#define ETB     0x17            /* ^W */
#define CAN     0x18            /* ^X */
#define EM      0x19            /* ^Y */
#define SUB     0x1a            /* ^Z */
#define ESC     0x1b            /* ^[ */
#define FS      0x1c            /* ^\ */
#define GS      0x1d            /* ^] */
#define RS      0x1e            /* ^^ */
#define US      0x1f            /* ^_ */
#define SP      0x20            /* space */
#define DEL     0x7f            /* DEL */

#define TRUE    1
#define FALSE   0
#define ERR     -2

/*      Definitions of meta-characters used in pattern matching
 *      routines.  LITCHAR & NCCL are only used as token identifiers;
 *      all the others are also both token identifier and actual symbol
 *      used in the regular expression.
 */

#define BOL     '^'
#undef EOL
#define EOL     '$'
#define ANY     '.'
#define LITCHAR 'L'
#define ESCAPE  '\\'
#define CCL     '['             /* Character class: [...] */
#define CCLEND  ']'
#define NEGATE  '~'
#define NCCL    '!'             /* Negative character class [^...] */
#define CLOSURE '*'
#define OR_SYM  '|'
#define DITTO   '&'
#define OPEN    '('
#define CLOSE   ')'

/* Largest permitted size for an expanded character class.  (i.e. the class
 * [a-z] will expand into 26 symbols; [a-z0-9] will expand into 36.)
 */
#define CLS_SIZE        128

/*
 *      Tokens are used to hold pattern templates. (see makepat())
 */
typedef char BITMAP;

typedef struct token {
  char tok;
  char lchar;
  BITMAP *bitmap;
  struct token *next;
} TOKEN;

#define TOKSIZE sizeof (TOKEN)

/*
 *      An absolute maximun for strings.
 */

#define MAXSTR  132             /* Maximum numbers of characters in a line */

/* Macros */
#define max(a,b)        ((a>b)?a:b)
#define min(a,b)        ((a<b)?a:b)
#define toupper(c)      (c>='a'&&c<='z'?c-32:c)

