/*      docmd.c */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

char fname[MAXFNAME];
int fchanged;
extern int nofname;

extern int mark[];

int docmd(glob)
int glob;
{
  static char rhs[MAXPAT];
  TOKEN *subpat;
  int c, err, line3;
  int apflg, pflag, gflag;
  int nchng;
  char *fptr;

  pflag = FALSE;
  while (*inptr == SP && *inptr == HT) inptr++;

  c = *inptr++;

  switch (c) {
      case NL:
        if (nlines == 0) {
                if ((line2 = nextln(curln)) == 0) return(ERR);
        }
        curln = line2;
        return(1);
        break;

      case '=': printf("%d\n", line2);  break;

      case 'a':
        if (*inptr != NL || nlines > 1) return(ERR);

        if (append(line1, glob) < 0) return(ERR);;
        fchanged = TRUE;
        break;

      case 'c':
        if (*inptr != NL) return(ERR);

        if (deflt(curln, curln) < 0) return(ERR);

        if (del(line1, line2) < 0) return(ERR);
        if (append(curln, glob) < 0) return (ERR);
        fchanged = TRUE;
        break;

      case 'd':
        if (*inptr != NL) return(ERR);

        if (deflt(curln, curln) < 0) return(ERR);

        if (del(line1, line2) < 0) return(ERR);
        if (nextln(curln) != 0) curln = nextln(curln);
        fchanged = TRUE;
        break;

      case 'e':
        if (nlines > 0) return(ERR);
        if (fchanged) {
                fchanged = FALSE;
                return(ERR);
        }

        /* FALL THROUGH */
      case 'E':
        if (nlines > 0) return(ERR);

        if (*inptr != ' ' && *inptr != HT && *inptr != NL) return(ERR);

        if ((fptr = getfn()) == NULL) return(ERR);

        clrbuf();
        if ((err = doread(0, fptr)) < 0) return(err);

        strcpy(fname, fptr);
        fchanged = FALSE;
        break;

      case 'f':
        if (nlines > 0) return(ERR);

        if (*inptr != ' ' && *inptr != HT && *inptr != NL) return(ERR);

        if ((fptr = getfn()) == NULL) return(ERR);

        if (nofname)
                printf("%s\n", fname);
        else
                strcpy(fname, fptr);
        break;

      case 'i':
        if (*inptr != NL || nlines > 1) return(ERR);

        if (append(prevln(line1), glob) < 0) return(ERR);
        fchanged = TRUE;
        break;

      case 'j':
        if (*inptr != NL || deflt(curln, curln + 1) < 0) return(ERR);

        if (join(line1, line2) < 0) return(ERR);
        break;

      case 'k':
        while (*inptr == ' ' || *inptr == HT) inptr++;

        if (*inptr < 'a' || *inptr > 'z') return ERR;
        c = *inptr++;

        if (*inptr != ' ' && *inptr != HT && *inptr != NL) return(ERR);

        mark[c - 'a'] = line1;
        break;

      case 'l':
        if (*inptr != NL) return(ERR);
        if (deflt(curln, curln) < 0) return (ERR);
        if (dolst(line1, line2) < 0) return (ERR);
        break;

      case 'm':
        if ((line3 = getone()) < 0) return(ERR);
        if (deflt(curln, curln) < 0) return (ERR);
        if (move(line3) < 0) return (ERR);
        fchanged = TRUE;
        break;

      case 'P':
      case 'p':
        if (*inptr != NL) return(ERR);
        if (deflt(curln, curln) < 0) return (ERR);
        if (doprnt(line1, line2) < 0) return (ERR);
        break;

      case 'q':
        if (fchanged) {
                fchanged = FALSE;
                return(ERR);
        }

        /* FALL THROUGH */
      case 'Q':
        if (*inptr == NL && nlines == 0 && !glob)
                return(EOF);
        else
                return(ERR);

      case 'r':
        if (nlines > 1) return(ERR);

        if (nlines == 0) line2 = lastln;

        if (*inptr != ' ' && *inptr != HT && *inptr != NL) return(ERR);

        if ((fptr = getfn()) == NULL) return(ERR);

        if ((err = doread(line2, fptr)) < 0) return(err);
        fchanged = TRUE;
        break;

      case 's':
        if (*inptr == 'e') return(set());
        while (*inptr == SP || *inptr == HT) inptr++;
        if ((subpat = optpat()) == NULL) return (ERR);
        if ((gflag = getrhs(rhs)) < 0) return (ERR);
        if (*inptr == 'p') pflag++;
        if (deflt(curln, curln) < 0) return (ERR);
        if ((nchng = subst(subpat, rhs, gflag, pflag)) < 0) return (ERR);
        if (nchng) fchanged = TRUE;
        break;

      case 't':
        if ((line3 = getone()) < 0) return(ERR);
        if (deflt(curln, curln) < 0) return (ERR);
        if (transfer(line3) < 0) return (ERR);
        fchanged = TRUE;
        break;

      case 'W':
      case 'w':
        apflg = (c == 'W');

        if (*inptr != ' ' && *inptr != HT && *inptr != NL) return(ERR);

        if ((fptr = getfn()) == NULL) return(ERR);

        if (deflt(1, lastln) < 0) return(ERR);
        if (dowrite(line1, line2, fptr, apflg) < 0) return (ERR);
        fchanged = FALSE;
        break;

      case 'x':
        if (*inptr == NL && nlines == 0 && !glob) {
                if ((fptr = getfn()) == NULL) return(ERR);
                if (dowrite(1, lastln, fptr, 0) >= 0) return (EOF);
        }
        return(ERR);

      case 'z':
        if (deflt(curln, curln) < 0) return(ERR);

        switch (*inptr) {
            case '-':
                if (doprnt(line1 - 21, line1) < 0) return(ERR);
                break;

            case '.':
                if (doprnt(line1 - 11, line1 + 10) < 0) return(ERR);
                break;

            case '+':
            case '\n':
                if (doprnt(line1, line1 + 21) < 0) return(ERR);
                break;
        }
        break;

      default:  return(ERR);
}
  return(0);
}

int dolst(line1, line2)
int line1, line2;
{
  int oldlflg = lflg, p;

  lflg = 1;
  p = doprnt(line1, line2);
  lflg = oldlflg;

  return p;
}

