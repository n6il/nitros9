/*      ins.c   */
#include <stdio.h>
#include "tools.h"
#include "ed.h"

int ins(str)
char *str;
{
  char buf[MAXLINE], *cp;
  LINE *new, *cur, *nxt;

  cp = buf;
  while (1) {
        if ((*cp = *str++) == NL) *cp = EOS;
        if (*cp) {
                cp++;
                continue;
        }
        if ((new = (LINE *) malloc(sizeof(LINE) + strlen(buf))) == NULL)
                return(ERR);    /* no memory */

        new->l_stat = 0;
        strcpy(new->l_buff, buf);       /* build new line */
        cur = getptr(curln);    /* get current line */
        nxt = cur->l_next;      /* get next line */
        relink(cur, new, new, nxt);     /* add to linked list */
        relink(new, nxt, cur, new);
        lastln++;
        curln++;

        if (*str == EOS)        /* end of line ? */
                return(1);

        cp = buf;
  }
}

