/*      ed.c    */
/* Copyright 1987 Brian Beattie Rights Reserved.
 *
 * Permission to copy and/or distribute granted under the
 * following conditions:
 *
 * 1). No charge may be made other than resonable charges
 *      for reproduction.
 *
 * 2). This notice must remain intact.
 *
 * 3). No further restrictions may be added.
 *
 */
#include <stdio.h>
#include <signal.h>
#include "tools.h"
#include "ed.h"
#include <setjmp.h>
jmp_buf env;

#define isatty(fd) 1

LINE line0;
int curln = 0;
int lastln = 0;
char *inptr;
static char inlin[MAXLINE];
int nflg, lflg;
int line1, line2, nlines;
extern char fname[];
int version = 1;
int diag = 1;

intr(sig)
int sig;
{
  printf("?\n");
  longjmp(env, 1);
}

int main(argc, argv)
int argc;
char **argv;
{
  int stat, i, doflush;

  pflinit();
  set_buf();
  doflush = isatty(1);

  if (argc > 1 && argv[1][0] == '-' && argv[1][1] == 0) {
        diag = 0;
        argc--;
        argv++;
  }
  if (argc > 1) {
        for (i = 1; i < argc; i++) {
                if (doread(0, argv[i]) == 0) {
                        curln = 1;
                        strcpy(fname, argv[i]);
                        break;
                }
        }
  }
  while (1) {
        setjmp(env);
        if (signal(SIGINT, SIG_IGN) != SIG_IGN) signal(SIGINT, intr);

        if (doflush) fflush(stdout);

        if (fgets(inlin, sizeof(inlin), stdin) == NULL) {
                break;
        }
        inptr = inlin;
        if (getlst() >= 0)
                if ((stat = ckglob()) != 0) {
                        if (stat >= 0 && (stat = doglob()) >= 0) {
                                curln = stat;
                                continue;
                        }
                } else {
                        if ((stat = docmd(0)) >= 0) {
                                if (stat == 1) doprnt(curln, curln);
                                continue;
                        }
                }
        if (stat == EOF) {
                exit(0);
        }
        if (stat == FATAL) {
                fputs("FATAL ERROR\n", stderr);
                exit(1);
        }
        printf("?\n");
  }
  return(0);
}

