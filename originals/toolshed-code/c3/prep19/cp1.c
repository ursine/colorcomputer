#include "cp.h"


/* open include files and place in file path stack */
void doinclude(char *ln)
{
	int             c;

	incln[fptr] = _line_;
	if (fptr == MAX_INCLUDE - 1)	/* Too many inc files -- FATAL ERROR */
	{
		doerr(7, ln - line);
		return;
	}
	if (*ln == '"')		/* File is in current working dir */
	{
		if ((c = findstr(2, ln, "\"") - 2) > 0)	/* Get last char in file
							 * name + 1 */
		{
			strncpy(ifnbuf[++fptr], ln + 1, &ln[c] - ln);	/* Put filename in buf */
			ifnbuf[fptr][&ln[c] - ln] = 0;
			if ((fpath[fptr] = open(ifnbuf[fptr], 1)) == ERROR)
				doerr(6, ln - line);	/* Bad file */
		}
		else
			doerr(19, ln - line);	/* No end " */
	}
	else if (*ln == '<')	/* File is in DEFS dir */
	{
#if 0
		strcpy(ifnbuf[++fptr], "/DD/DEFS/");	/* add LIB prefix to
							 * filename */
		if ((c = findstr(2, ln, ">") - 2) > 0)
		{
			strncpy(&ifnbuf[fptr][9], &ln[1], &ln[c] - ln);
			ifnbuf[fptr][&ln[c] - ln + 9] = 0;
			/* fprintf(stderr,"ERR:buf=%s\n",ifnbuf[fptr]);  */
			if ((fpath[fptr] = open(ifnbuf[fptr], 1)) == ERROR)
				doerr(6, ln - line);	/* Bad file */
		}
		else
			doerr(9, ln - line);	/* No end > */
#else
		fptr++;
		
		if ((c = findstr(2, ln, ">")) > 0)
		{
			int xx;
			char incfile[255];
			
			strncpy(incfile, &ln[1], &ln[c] - ln);
			incfile[&ln[c] - ln] = '\0';
			
			for (xx = 0; xx < incdircount; xx++)
			{
				sprintf(ifnbuf[fptr], "%s/%s", incdirs[xx], incfile);

				if ((fpath[fptr] = open(ifnbuf[fptr], 1)) != ERROR)
				{
					break;
				}
					
			}

			if (xx == incdircount)
			{
				doerr(6, ln - line);	/* Bad file */
				fptr--;
			}
		}
#endif
	}
	else
	{
		/* Check for token-sequence */
		splittok(ln, 0);/* split end of line into tokens */
		expln(ln, NULL, NULL);
		/* fprintf(stderr,"ERR:ln=%s\n",ln);   */
		if (*ln == '\"' || *ln == '<')	/* If now in proper format... */
			doinclude(ln);	/* open include file */
		else
			doerr(6, ln - line);	/* Bad file name */
	}
	lnprint(1, 0, NULL);	/* print #line for new file */
	return;
}



void tstdupdef(void)
{
	register int    i;

	for (i = 0; i < defcntr - 1; ++i)
	{
		if (!strcmp(defnam[i], defnam[defcntr - 1]))	/* if name matches */
		{
			if (!strcmp(deftok[i], deftok[defcntr - 1]))	/* if tok matches */
			{
				if (!strcmp(defarg[i], defarg[defcntr - 1]))	/* if arg matches */
				{
					--defcntr;	/* decrement def array
							 * ptr */
					dptr = defnam[defcntr];	/* reset $trng ptr to
								 * prev. def. */
					return;
				}
			}
			--defcntr;	/* decrement def array ptr */
			dptr = defnam[defcntr];	/* reset $trng ptr to prev.
						 * def. */
			doerr(11, 8);
			return;
		}
	}

	return;
}				/* No match found */



void doundef(ln)
	char           *ln;
{
	int             d,
	                i,
	                j;
	char           *sptr,
	               *eptr;

	/*
	 * Unforch, Jims code didn't work because the 'ln' passed didn't have
	 * any spaces attached until the splittok(ln,0) had been done, at
	 * which point it had spaces on BOTH ends. The defnam array holds
	 * each name with an ending space only, therefore none of the strcmp
	 * tilitys ever found a match. The undef was never done as no match
	 * was ever found. However, PLEASE give Jim credit for the well
	 * organized code thats easy to fix. Gene Heskett, CE@WDTV
	 */
	splittok(ln, 0);	/* tokenize identifier */
	while (*ln == ' ')
		ln++;		/* this is the fix */
	if (strlen(ln) > 33)	/* Adjust ident. length if exceeds 31 + 2
				 * spaces */
	{
		ln[32] = ' ';
		ln[33] = '\0';
	}
	for (i = 5; i < defcntr; ++i)
	{
		if (!strcmp(defnam[i], ln))	/* Undef name found */
		{

			/*
			 * fprintf(stderr,"%s, defnmbr %d is being undefined
			 * as %s\n",ln,i,defnam[i]);
			 */
			if (i == defcntr - 1)	/* last name in table */
			{
				dptr = defnam[i];
				--defcntr;
			}
			else
			{
				sptr = defnam[i];	/* where to start
							 * removal */
				eptr = defnam[i + 1];	/* where to get next
							 * define name */
				d = eptr - sptr;	/* num of chars to
							 * remove */
				do	/* Adjust $tring table */
				{
					*sptr++ = *eptr++;	/* copy remainder of
								 * table over it */
				} while (eptr != dptr);	/* till end of table +
							 * next char */
				dptr -= d;	/* and fix dptr back that far
						 * too */
				for (j = i + 1; j < defcntr; ++j)	/* Adjust def arrays */
				{
					defnam[j - 1] = defnam[j] - d;	/* fix each pointer to
									 * equal */
					deftok[j - 1] = deftok[j] - d;	/* next pointer -d */
					if (defarg[j])	/* if it had a defined
							 * value, move it */
						defarg[j - 1] = defarg[j] - d;	/* down the list too */
					else
						defarg[j - 1] = NULL;
				}
				--defcntr;	/* and remove it from the
						 * count */
/*				return (killine()); */
				killine();
			}
		}
	}

	return;
}



void splittok(ln, b)			/* Check ln for tokens and inserts 1 space
				 * after each */
	char           *ln;
	int             b;	/* b's value appears to be the where to start
				 * value */
{
	int             c,
	                d;
	char            tmp[LINEMAX + 3],
	               *tptr,
	               *lnptr;

	/* fprintf(stderr,"SPLITTOK entry:b=%d line=|%s|\n",b,ln);  */

	/*
	 * while(*ln==' ' && b > 1 ) { ln++; b--; }
	 *//* skip any leading spaces passed! */
	d = b;
	lnptr = ln + b;
	strcpy(tmp, ln);
	if (b == 0 && *tmp != ' ')
		*(lnptr++) = ' ';
	/* fprintf(stderr,"splittok's copy=|%s|\n",ln+b); */
	for (;;)
	{
		tptr = tmp + b;
		while (*tptr == ' ')
		{
			*(lnptr++) = ' ';
			++tptr;
		}
		if (!(*tptr))
		{
			*lnptr = 0;
			/* fprintf(stderr,"SPLITTOK exit ln=|%s|\n",ln); */
			return;
		}
		if (*tptr == 'L' && (*(tptr + 1) == '"' || *(tptr + 1) == '\''))
			b = qa2(tmp, *(tptr + 1), tptr - tmp + 1) + 1;	/* point to char after
									 * str */
		else if (IDNT_INIT(*tptr))	/* if identifier */
			b = getident(tmp, tptr - tmp) + 1;	/* point to char after
								 * ident. */
		else if (*tptr == '"' || *tptr == '\'')	/* chars or strings */
			b = qa2(tmp, *tptr, tptr - tmp) + 1;	/* point to char after
								 * string */
		else if (isdigit(*tptr) || *tptr == '.')	/* test for number */
			b = toknum(tmp, tptr);	/* point to char after number */
		else if ((c = tokopr(tmp, tptr - tmp)) != ERROR)	/* Check for legal
									 * operators */
			b = c + 1;	/* point to char after operator */
		else
			b = tptr - tmp + 1;	/* Misc. token */
		strncpy(lnptr, tptr, &tmp[b] - tptr);
		lnptr += (&tmp[b] - tptr);
		*lnptr = '\0';
		if (tmp[b] != ' ')
			*(lnptr++) = ' ';
		/* fprintf(stderr,"SPLITTOK end of for b=%d ln=|%s|\n",b,ln);  */
	}
}

#ifdef M6809
#asm
findchar:
pshs u
ldu 4, s(*s)
ldx
#0     (b=0)
ldb 7, s(c)
FCWHL
tst, u(while (*s))
	lbeq            FCEND
	                leax 1,
	                x(++b)
                cmpb, u + (if (c == *s++))
	lbne            FCWHL
	                tfr x,
	                d
	                puls u,
	                pc
	                FCEND
	                clra(return NULL)
                clrb
                puls u, pc
#endasm
#endif

int                tokopr(ln, b)	/* tests for operator or separator, returns 0
				 * if invalid */
	char           *ln;	/* else position of last char. of operator */
	int             b;
{
	int             c,
	                d,
	                e;

	c = ln[b];
	d = ln[b + 1];
	e = ln[b + 2];
	/* fprintf(stderr,"TOKOPR: b=%d c=%c d=%c e=%c\n",b,c,d,e);    */
	if (((c == '<' && d == '<') || (c == '>' && d == '>')) && e == '=')
		b += 2;
	else if (c == '.' && d == '.' && e == '.')
		b += 2;
	else if (d == '=' && findchar("-+<>=!*/%&^|", c))	/* All ops ending = */
		++b;
	else if (c == '-' && (d == '>' || d == '-'))
		++b;
	else if ((c == '+' && d == '+') || (c == '<' && d == '<') || (c == '>' && d == '>'))
		++b;
	else if ((c == '&' && d == '&') || (c == '|' && d == '|') || (c == '#' && d == '#'))
		++b;
	else if (!findchar("()[].!~+-*&/%<>^|?:=,{};#", c))
		return ERROR;
	/* fprintf(stderr,"TOKOPR: (final) b=%d\n",b); */

	return b;
}



int toknum(ln, lnptr)
	char           *ln,
	               *lnptr;
{
	if (*lnptr == '.')	/* screen out . as a struct operator */
		if (lnptr > ln && (IDNT_TYPE((*(lnptr - 1)))))
			return (++lnptr - ln);

	for (;;)
	{
		do
		{
			++lnptr;
		} while (isalnum(*lnptr) || *lnptr == '.');
		if ((*lnptr != '+' && *lnptr != '-') || (*(lnptr - 1) != 'E' && *(lnptr - 1) != 'e'))
			return (lnptr - ln);
	}
}



void initstdefs(void)
{
	defnam[0] = "__LINE__ ";
	defnam[1] = "__FILE__ ";
	defnam[2] = "__DATE__ ";
	defnam[3] = "__TIME__ ";
	defnam[4] = "__LINE__ ";/* blank out STDC slot unless ANSI selected */
	defarg[0] = NULL;
	defarg[1] = NULL;
	defarg[2] = NULL;
	defarg[3] = NULL;
	defarg[4] = NULL;
	deftok[0] = NULL;
	deftok[1] = NULL;
	deftok[2] = _date_;
	deftok[3] = _time_;
	deftok[4] = "1";	/* Indicates ANSI compatible */

	return;
}



void cncatstr(ln)
	char           *ln;
{
	int             b;

	while ((b = findstr(1, ln, "\" \"")) != 0)
		strcpy(&ln[b - 1], &ln[b + 2]);

	return;
}
