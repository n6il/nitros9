/*      unmkpat.c       */
#include <stdio.h>
#include "tools.h"

/* Free up the memory usde for token string */
unmakepat(head)
TOKEN *head;
{

  register TOKEN *old_head;

  while (head) {
        switch (head->tok) {
            case CCL:
            case NCCL:
                free(head->bitmap);
                /* Fall through to default */

            default:
                old_head = head;
                head = head->next;
                free((char *) old_head);
                break;
        }
  }
}
