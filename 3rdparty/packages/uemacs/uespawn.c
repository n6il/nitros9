/*
 * The routines in this file are called to create a subjob running a command
 * interpreter. This code is a big fat nothing on CP/M-86. You lose.
 */
#include        <stdio.h>
#include        "ueed.h"

#ifdef AMIGA
#define  NEW   1006
#endif

#ifdef VMS
#define EFN     0                               /* Event flag.          */

#include        <ssdef.h>                       /* Random headers.      */
#include        <stsdef.h>
#include        <descrip.h>
#include        <iodef.h>

extern  int     oldmode[];                      /* In "termio.c"        */
extern  int     newmode[];                      /* In "termio.c"        */
extern  short   iochan;                         /* In "termio.c"        */
#endif

#ifdef MSDOS
#include        <dos.h>
#endif

#ifdef V7
#include        <signal.h>
#endif

#ifdef OSK
#include        <sgstat.h>             
extern struct  sgbuf  ostate;                   /* In "termio.c" */
extern struct  sgbuf  nstate;                   /* In "termio.c" */
#endif

/*
 * Create a subjob with a copy of the command intrepreter in it. When the
 * command interpreter exits, mark the screen as garbage so that you do a full
 * repaint. Bound to "C-C". The message at the start in VMS puts out a newline.
 * Under some (unknown) condition, you don't get one free when DCL starts up.
 */
spawncli(f, n)
{
#ifdef AMIGA
        long newcli;

        newcli = Open("CON:1/1/639/199/MicroEmacs Subprocess", NEW);
        mlwrite("[Starting new CLI]");
        sgarbf = TRUE;
        Execute("", newcli, 0);
        Close(newcli);
        return(TRUE);
#endif
#ifdef VMS
        movecursor(term.t_nrow, 0);             /* In last line.        */
        mlputs("[Starting DCL]\r\n");
        (*term.t_flush)();                      /* Ignore "ttcol".      */
        sgarbf = TRUE;
        return (sys(NULL));                     /* NULL => DCL.         */
#endif
#ifdef CPM
        mlwrite("Not in CP/M-86");
#endif
#ifdef MSDOS
        movecursor(term.t_nrow, 0);             /* Seek to last line.   */
        (*term.t_flush)();
        sys("\\command.com", "");               /* Run CLI.             */
        sgarbf = TRUE;
        return(TRUE);
#endif
#ifdef V7
        register char *cp;
        char    *getenv();
        movecursor(term.t_nrow, 0);             /* Seek to last line.   */
        (*term.t_flush)();
        ttclose();                              /* stty to old settings */
        if ((cp = getenv("SHELL")) != NULL && *cp != '\0')
                system(cp);
        else
                system("exec /bin/sh");
        sgarbf = TRUE;
        sleep(2);
        ttopen();
        return(TRUE);
#endif
#ifdef OSK
        register char *cp;
        char    *getenv();
        movecursor(term.t_nrow, 0);             /* Seek to last line.   */
        (*term.t_flush)();
        setstat(0, 0, &ostate);                 /* stty to old settings */
        if ((cp = getenv("SHELL")) != NULL && *cp != '\0')
                system(cp);
        else
                system("shell");
        sgarbf = TRUE;
        setstat(0, 0, &nstate);
        return(TRUE);
#endif
}

/*
 * Run a one-liner in a subjob. When the command returns, wait for a single
 * character to be typed, then mark the screen as garbage so a full repaint is
 * done. Bound to "C-X !".
 */
spawn(f, n)
{
        register int    s;
        char            line[NLINE];
#ifdef AMIGA
        long newcli;

        newcli = Open("CON:1/1/639/199/MicroEmacs Subprocess", NEW);
        if ((s=mlreply("CLI command: ", line, NLINE)) != TRUE)
                return (s);
        Execute(line,0,newcli);
        Close(newcli);
        while ((*term.t_getchar)() != '\r')     /* Pause.               */
                ;
        sgarbf = TRUE;
        return(TRUE);
#endif
#ifdef VMS
        if ((s=mlreply("DCL command: ", line, NLINE)) != TRUE)
                return (s);
        (*term.t_putchar)('\n');                /* Already have '\r'    */
        (*term.t_flush)();
        s = sys(line);                          /* Run the command.     */
        mlputs("\r\n\n[End]");                  /* Pause.               */
        (*term.t_flush)();
        while ((*term.t_getchar)() != '\r')
                ;
        sgarbf = TRUE;
        return (s);
#endif
#ifdef CPM
        mlwrite("Not in CP/M-86");
        return (FALSE);
#endif
#ifdef MSDOS
        if ((s=mlreply("MS-DOS command: ", line, NLINE)) != TRUE)
                return (s);
        system(line);
        while ((*term.t_getchar)() != '\r')     /* Pause.               */
                ;
        sgarbf = TRUE;
        return (TRUE);
#endif
#ifdef V7
        if ((s=mlreply("! ", line, NLINE)) != TRUE)
                return (s);
        (*term.t_putchar)('\n');                /* Already have '\r'    */
        (*term.t_flush)();
        ttclose();                              /* stty to old modes    */
        system(line);
        sleep(2);
        ttopen();
        mlputs("[End]");                        /* Pause.               */
        (*term.t_flush)();
        while ((s = (*term.t_getchar)()) != '\r' && s != ' ')
                ;
        sgarbf = TRUE;
        return (TRUE);
#endif
#ifdef OSK
        if ((s=mlreply("! ", line, NLINE)) != TRUE)
                return (s);
        (*term.t_putchar)('\l');                /* Already have '\r'    */
        (*term.t_flush)();
        setstat(0, 0, &ostate);                 /* stty to old modes    */
        s=system(line);
        setstat(0, 0, &nstate);
        mlputs("[End]");                        /* Pause.               */
        (*term.t_flush)();
        while ((s = (*term.t_getchar)()) != '\r' && s != ' ')
                ;
        sgarbf = TRUE;
        return (TRUE);
#endif
}

#ifdef VMS
/*
 * Run a command. The "cmd" is a pointer to a command string, or NULL if you
 * want to run a copy of DCL in the subjob (this is how the standard routine
 * LIB$SPAWN works. You have to do wierd stuff with the terminal on the way in
 * and the way out, because DCL does not want the channel to be in raw mode.
 */
sys(cmd)
register char   *cmd;
{
        struct  dsc$descriptor  cdsc;
        struct  dsc$descriptor  *cdscp;
        long    status;
        long    substatus;
        long    iosb[2];

        status = SYS$QIOW(EFN, iochan, IO$_SETMODE, iosb, 0, 0,
                          oldmode, sizeof(oldmode), 0, 0, 0, 0);
        if (status!=SS$_NORMAL || (iosb[0]&0xFFFF)!=SS$_NORMAL)
                return (FALSE);
        cdscp = NULL;                           /* Assume DCL.          */
        if (cmd != NULL) {                      /* Build descriptor.    */
                cdsc.dsc$a_pointer = cmd;
                cdsc.dsc$w_length  = strlen(cmd);
                cdsc.dsc$b_dtype   = DSC$K_DTYPE_T;
                cdsc.dsc$b_class   = DSC$K_CLASS_S;
                cdscp = &cdsc;
        }
        status = LIB$SPAWN(cdscp, 0, 0, 0, 0, 0, &substatus, 0, 0, 0);
        if (status != SS$_NORMAL)
                substatus = status;
        status = SYS$QIOW(EFN, iochan, IO$_SETMODE, iosb, 0, 0,
                          newmode, sizeof(newmode), 0, 0, 0, 0);
        if (status!=SS$_NORMAL || (iosb[0]&0xFFFF)!=SS$_NORMAL)
                return (FALSE);
        if ((substatus&STS$M_SUCCESS) == 0)     /* Command failed.      */
                return (FALSE);
        return (TRUE);
}
#endif

#ifdef MSDOS
/*
 * This routine, once again by Bob McNamara, is a C translation of the "system"
 * routine in the MWC-86 run time library. It differs from the "system" routine
 * in that it does not unconditionally append the string ".exe" to the end of
 * the command name. We needed to do this because we want to be able to spawn
 * off "command.com". We really do not understand what it does, but if you don't
 * do it exactly "malloc" starts doing very very strange things.
 */
sys(cmd, tail)
char    *cmd;
char    *tail;
{
#ifdef MWC_86
        register unsigned n;
        extern   char     *__end;

        n = __end + 15;
        n >>= 4;
        n = ((n + dsreg() + 16) & 0xFFF0) + 16;
        return(execall(cmd, tail, n));
#endif

#ifdef LATTICE
        return forklp(cmd, tail, NULL);
#endif
}
#endif


