/* #define WFDEBUG 0                       /* Window flag debug. */

typedef struct  VIDEO {
        short   v_flag;                 /* Flags */
        char    v_text[1];              /* Screen data. */
}       VIDEO;

#define VFCHG   0x0001                  /* Changed. */

#ifdef DISPLAY1
int     sgarbf  = TRUE;                 /* TRUE if screen is garbage */
int     mpresf  = FALSE;                /* TRUE if message in last line */
int     vtrow   = 0;                    /* Row location of SW cursor */
int     vtcol   = 0;                    /* Column location of SW cursor */
int     ttrow   = HUGE;                 /* Row location of HW cursor */
int     ttcol   = HUGE;                 /* Column location of HW cursor */
#else
extern int     sgarbf;                 /* TRUE if screen is garbage */
extern int     mpresf;                /* TRUE if message in last line */
extern int     vtrow;                    /* Row location of SW cursor */
extern int     vtcol;                    /* Column location of SW cursor */
extern int     ttrow;                 /* Row location of HW cursor */
extern int     ttcol;                 /* Column location of HW cursor */
#endif

