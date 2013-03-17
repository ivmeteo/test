/*

  Calculate or Check MD5 Signature of File or Command Line Argument

			    by John Walker
		       http://www.fourmilab.ch/

		This program is in the public domain.

*/

#define VERSION     "2.0 (2003-04-15)"

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#ifdef _WIN32
#include <fcntl.h>
#include <io.h>
#endif

#include "md5.h"

#define FALSE	0
#define TRUE	1

#define EOS     '\0'

/*  Main program  */

int main(argc, argv)
  int argc; char *argv[];
{
    int i, j, opt, cdata = FALSE, docheck = FALSE, showfile = TRUE, f = 0;
    unsigned int bp;
    char *cp, *clabel, *ifname, *hexfmt = "%02X";
    FILE *in = stdin, *out = stdout;
    unsigned char buffer[16384], signature[16], csig[16];
    struct MD5Context md5c;

    for (i = 1; i < argc; i++) {
	cp = argv[i];
        if (*cp == '-') {
	    if (strlen(cp) == 1) {
	    	i++;
	    	break;	    	      /* -  --  Mark end of options; balance are files */
	    }
	    opt = *(++cp);
	    if (islower(opt)) {
		opt = toupper(opt);
	    }

	    switch (opt) {

                case 'C':             /* -Csignature  --  Check signature, set return code */
		    docheck = TRUE;
		    if (strlen(cp + 1) != 32) {
			docheck = FALSE;
		    }
		    memset(csig, 0, 16);
		    clabel = cp + 1;
		    for (j = 0; j < 16; j++) {
			if (isxdigit((int) clabel[0]) && isxdigit((int) clabel[1]) &&
                            sscanf((cp + 1 + (j * 2)), hexfmt, &bp) == 1) {
			    csig[j] = (unsigned char) bp;
			} else {
			    docheck = FALSE;
			    break;
			}
			clabel += 2;
		    }
		    if (!docheck) {
                        fprintf(stderr, "Error in signature specification.  Must be 32 hex digits.\n");
			return 2;
		    }
		    break;

                case 'D':             /* -Dtext  --  Compute signature of given text */
		    MD5Init(&md5c);
		    MD5Update(&md5c, (unsigned char *) (cp + 1), strlen(cp + 1));
		    cdata = TRUE;
		    f++;	      /* Mark no infile argument needed */
		    break;
		    
		case 'L':   	      /* -L  --  Use lower case letters as hex digits */
		    hexfmt = "%02x";
		    break;
		    
		case 'N':   	      /* -N  --  Don't show file name after sum */
		    showfile = FALSE;
		    break;
		    
		case 'O':   	      /* -Ofname  --  Write output to fname (- = stdout) */
		    cp++;
                    if (strcmp(cp, "-") != 0) {
		    	if (out != stdout) {
			    fprintf(stderr, "Redundant output file specification.\n");
			    return 2;
    	    	    	}
                        if ((out = fopen(cp, "w")) == NULL) {
                            fprintf(stderr, "Cannot open output file %s\n", cp);
			    return 2;
			}
		    }
		    break;

                case '?':             /* -U, -? -H  --  Print how to call information. */
                case 'H':
                case 'U':
    printf("\nMD5  --  Calculate MD5 signature of file.  Call");
    printf(
       "\n             with md5 [ options ] [file ...]");
    printf("\n");
    printf("\n         Options:");
    printf("\n              -csig   Check against sig, set exit status 0 = OK");
    printf("\n              -dtext  Compute signature of text argument");
    printf("\n              -l      Use lower case letters for hexadecimal digits");
    printf("\n              -n      Do not show file name after sum");
    printf("\n              -ofname Write output to fname (- = stdout)");
    printf("\n              -u      Print this message");
    printf("\n              -v      Print version information");
    printf("\n");
    printf("\nby John Walker  --  http://www.fourmilab.ch/");
    printf("\nVersion %s\n", VERSION);
    printf("\nThis program is in the public domain.\n");
    printf("\n");
		    return 0;
		    
		case 'V':   	      /* -V  --  Print version number */
		    printf("%s\n", VERSION);
		    return 0;
	    }
	} else {
	    break;
	}
    }
    
    if (cdata && (i < argc)) {
    	fprintf(stderr, "Cannot specify both -d option and input file.\n");
	return 2;
    }
    
    if ((i >= argc) && (f == 0)) {
    	f++;
    }
    
    for (; (f > 0) || (i < argc); i++) {
    	if ((!cdata) && (f > 0)) {
	    ifname = "-";
	} else {
    	    ifname = argv[i];
	}
	f = 0;

	if (!cdata) {
	
	    /* If the data weren't supplied on the command line with
	       the "-d" option, read it now from the input file. */
	
	    if (strcmp(ifname, "-") != 0) {
		if ((in = fopen(ifname, "rb")) == NULL) {
	    	    fprintf(stderr, "Cannot open input file %s\n", ifname);
		    return 2;
		}
	    } else {
		in = stdin;
	    }
#ifdef _WIN32

	    /** Warning!  On systems which distinguish text mode and
		binary I/O (MS-DOS, Macintosh, etc.) the modes in the open
        	statement for "in" should have forced the input file into
        	binary mode.  But what if we're reading from standard
		input?  Well, then we need to do a system-specific tweak
        	to make sure it's in binary mode.  While we're at it,
        	let's set the mode to binary regardless of however fopen
		set it.

		The following code, conditional on _WIN32, sets binary
		mode using the method prescribed by Microsoft Visual C 7.0
        	("Monkey C"); this may require modification if you're
		using a different compiler or release of Monkey C.	If
        	you're porting this code to a different system which
        	distinguishes text and binary files, you'll need to add
		the equivalent call for that system. */

	    _setmode(_fileno(in), _O_BINARY);
#endif
    
    	    MD5Init(&md5c);
	    while ((j = (int) fread(buffer, 1, sizeof buffer, in)) > 0) {
		MD5Update(&md5c, buffer, (unsigned) j);
	    }
	}
	MD5Final(signature, &md5c);

	if (docheck) {
	    docheck = 0;
	    for (j = 0; j < sizeof signature; j++) {
		if (signature[j] != csig[j]) {
		    docheck = 1;
		    break;
		}
	    }
	    if (i < (argc - 1)) {
	    	fprintf(stderr, "Only one file may be tested with the -c option.\n");
		return 2;
	    }
	} else {
	    for (j = 0; j < sizeof signature; j++) {
        	fprintf(out, hexfmt, signature[j]);
	    }
	    if ((!cdata) && showfile) {
		fprintf(out, "  %s", (in == stdin) ? "-" : ifname);
	    }
            fprintf(out, "\n");
	}
    }

    return docheck;
}
