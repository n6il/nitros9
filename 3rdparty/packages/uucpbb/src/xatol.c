/* Copyright 1994 Brad Spencer */

/* Provided at no cost to Bob Billson to do with what he will */

/* A bit different atol, ya it only deals with positive numbers */

#include <stdio.h>

long xatol (s)
char *s;
{
    long v = 0;

    if (s == NULL  ||  *s == '\0')
         return (0);

    while (*s  &&  (*s >= '0') && (*s <= '9'))
      {
         v *= 10;
         v += ((*s) - '0');
         s++;
      }
    return (v);
}

