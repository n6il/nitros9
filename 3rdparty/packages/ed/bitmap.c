/*      bitmap.c        */
/*
 *      BITMAP.C -      makebitmap, setbit, testbit
 *                      bit-map manipulation routines.
 *
 *      Copyright (c) Allen I. Holub, all rights reserved.  This program may
 *              for copied for personal, non-profit use only.
 *
 */

#ifdef DEBUG
#include <stdio.h>
#endif

#include "tools.h"

BITMAP *makebitmap(size)
unsigned size;
{
  /* Make a bit map with "size" bits.  The first entry in the map is an
   * "unsigned int" representing the maximum bit.  The map itself is
   * concatenated to this integer. Return a pointer to a map on
   * success, 0 if there's not enough memory. */

  unsigned *map, numbytes;

  numbytes = (size >> 3) + ((size & 0x07) ? 1 : 0);

#ifdef DEBUG
  printf("Making a %d bit map (%d bytes required)\n", size, numbytes);
#endif

  if (map = (unsigned *) malloc(numbytes + sizeof(unsigned))) *map = size;

  return((BITMAP *) map);
}

int setbit(c, map, val)
unsigned c, val;
char *map;
{
  /* Set bit c in the map to val. If c > map-size, 0 is returned, else
   * 1 is returned. */

  if (c >= *(unsigned *) map)   /* if c >= map size */
        return 0;

  map += sizeof(unsigned);      /* skip past size */

  if (val)
        map[c >> 3] |= 1 << (c & 0x07);
  else
        map[c >> 3] &= ~(1 << (c & 0x07));

  return 1;
}

int testbit(c, map)
unsigned c;
char *map;
{
  /* Return 1 if the bit corresponding to c in map is set. 0 if it is not. */

  if (c >= *(unsigned *) map) return 0;

  map += sizeof(unsigned);

  return(map[c >> 3] & (1 << (c & 0x07)));
}

