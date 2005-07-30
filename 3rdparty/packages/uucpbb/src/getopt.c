/******************************************************************************     From: The C Users Journal - June 1991 p.75-87   New GETOPT(3)

   getopt()

   Function GETOPT gets the next option letter from the command line.
   GETOPT is an enhanced version of the C library function, GETOPT(3).


   Innvocation:

       option = getopt (argc, argv, optstring);

   where
       <argc>
           is the number of arguments in the argument value array.

       <argv>
           is the argument value array, i.e., an array of pointers to
           the "words" extracted from the command line.

       <optstring>
           is the set of recognized options.  Each character in the
           string is a legal option; any other characters encountered
           as an option in the command line is an illegal option and
           an error message is displayed.  If a character is followed
           by a colon in OPTSTRING, the option expects an argument.

       <option>
           returns the next option letter from the command line.  If
           the option expects an argument, OPTARG is set to point to
           the argument.  '?' is returned in the cases of an illegal
           option letter or a missing option argument.  Constant NONOPT
           is returned if a non-option argument is encountered or the
           command line scan is complete (also see OPTARG below for
           both cases.)


   Public Variables:

       OPTARG - returns the text of an option's argument or of a 
            non-option argument.  NULL is returned if an option
            has no argument or if the command line scan is complete.
            For illegal options or missing option arguments, OPTARG
            returns a pointer to the trailing portion of the defective
            ARGV.

       OPTERR - controls whether or not GETOPT prints out an 
            error message upon detecting an illegal option or
            a missing option argument.  A non-zero value enables
            error messages; zero disables them.

       OPTIND - is the index in ARGV of the command line argument
            that GETOPT will examine next.  GETOPT recognizes changes
            to this variable.  Arguments can be skipped by incrementing
            OPTIND outside of GETOPT and the command line scan can be
            restarted by resetting OPTIND to either 0 or 1.

**************************************************************************/

#include <stdio.h>                       /* standard I/O definitions */
#ifdef _UCC
#undef USE_INDEX                         /* Set to 1 if your C library uses */
#else                                    /* "index" instead of "strchr" */
#define USE_INDEX 1
#endif

#ifdef _UCC
#include <string.h>
#endif

#ifdef USE_INDEX
#include <string.h>                     /* C library string functions */
#define strchr index
#else
#include <string.h>                      /* C library string functions */
#endif
#include "getopt.h"                      /* GETOPT(3) definitions */

                                         /* Public variables */
char *optarg = NULL;
int  opterr  = -1,
     optind  = 0;

                                         /* Private variables */
static int  end_optind = 0,
            last_optind = 0,
            offset_in_group = 1;


int  getopt (argc, argv, optstring)

     int  argc;
     char **argv;
     char *optstring;

{    /* Local variables */
     char  *group, option, *s;

/* Did the caller restart or advance the scan by modifying OPTIND? */

     if (optind <= 0)  {
         end_optind = 0;
         last_optind = 0;
         optind = 1;
     }

     if (optind != last_optind)
         offset_in_group = 1;

/*************************************************************************

     Scan the command line and return the next option or, if none, the
     next non-option argument.  At the start of each loop iteration,
     OPTIND is the index of the command line argument currently under
     examination and OFFSET_IN_GROUP is the offset within the current
     ARGV string of the next option (i.e. to be examined in this 
     iteration.)

************************************************************************/

     for (option = ' ', optarg = NULL;
           optind < argc;
           optind++, offset_in_group = 1, option = ' ')  {

         group = argv[optind];

/*  Is this a non-option argument?  If it is and it's the same one
    GETOPT returned on the last call, then loop and try the next
    command line argument.  If it's a new, non-option argument,
    then return the argument to the calling routine.  */

         if ( (group[0] != '-')  ||
              ((end_optind > 0)  &&  (optind > end_optind)))  {
              if (optind == last_optind)
                  continue;
              optarg = group;               /* Return NONOPT and argument */
              break;
         }

/*  Are we at the end of the current options group?  If so, loop and
    try the next command line argument. */

         if (offset_in_group >= strlen (group))
             continue;

/*  If the current option is the end-of-option indicator, remember
    its position and move on to the next command line argument. */

         option = group[offset_in_group++];
         if (option == '-')  {
             end_optind = optind;            /* Mark end-of-options positon */
             continue;
         }

/*  If the current option is an illegal option, print an error message
    and return '?' to the calling routine. */

         s = strchr (optstring, option);
         if (s == NULL)  {
             if (opterr)
                 fprintf (stderr, "%s: illegal option -- %c\n",
                             argv[0], option);
             option = '?';
             optarg = &group[offset_in_group-1];
             break;
         }

/*  Does the option  expect an argument?  If yes, return the option and
    its argument to the calling routine.  The option's argument may be
    flush up against the option (i.e., the argument is the remainder of
    the current ARGV) or it may be separated from the option by white
    space (i.e., the argument is the whole of the next ARGV). */

         if (*++s == ':')  {
             if (offset_in_group < strlen (group))  {
                 optarg = &group[offset_in_group];
                 offset_in_group = strlen (group);
             }
             else  {
                 if ((++optind < argc)  &&  (*argv[optind] != '-'))  {
                     optarg = argv[optind];
                 } else {
                      if (opterr)
                          fprintf (stderr,
                          "%s: option requires an argument -- %c\n",
                                     argv[0], option);
                      option = '?';
                      optarg = &group[offset_in_group-1];
                      offset_in_group = 1;
                 }
             } 
             break;
         }

/*  It must be a single-letter option without an argument */

         break;
     }


/*  Return the option and (optionally) its argument */

     last_optind = optind;
     return ((option == ' ')  ?  NONOPT : (int) option);
}
/* End of file */

