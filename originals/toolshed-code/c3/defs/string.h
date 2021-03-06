/*
 * string.h
 *
 * $Id: string.h,v 1.4 2005/08/14 03:01:21 boisy Exp $
 *
 * (C) 2005 The C^3 Compiler Project
 * http://www.nitros9.org/c3/
 *
 * Notes:
 *
 * Edt/Rev  YYYY/MM/DD  Modified by
 * Comment
 * ------------------------------------------------------------------
 *          2005/08/12  Boisy G. Pitre
 * Brought in from Carl Kreider's CLIB package.
 */

#ifndef _STRING_H
#define	_STRING_H

char           *strcat();
char           *strncat();
char           *strhcpy();
char           *strcpy();
char           *strncpy();
char           *strclr();
char           *strucat();
char           *strucpy();
char           *index();
char           *rindex();
char           *reverse();
char           *strend();
int             strcmp();
int             strncmp();
int             strlen();
int             strucmp();
int             strnucmp();
int             patmatch();

char           *strchr();
char           *strrchr();

char           *strspn();
char           *strcspn();
char           *strtok();
char           *strpbrk();

char           *memccpy();
char           *memchr();
int             memcmp();
char           *memcpy();
char           *memset();

#endif				/* _STRING_H */
