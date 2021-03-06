/*
 * module.h - OS-9 module header definitions
 *
 * $Id: module.h,v 1.3 2005/08/13 15:07:11 boisy Exp $
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

#ifndef _MODULE_H
#define _MODULE_H

/* Executable memory module */
typedef struct
{
	unsigned        m_sync,	/* sync bytes ($87cd) */
	                m_size,	/* module size */
	                m_name;	/* offset to module name */
	char            m_tylan,/* type & language */
	                m_attrev,	/* attributes & revision */
	                m_parity;	/* header parity */

	unsigned        m_exec,	/* offset to execution start */
	                m_store;/* initial storage size */
}               mod_exec;


/* Device descriptor module */
typedef struct
{
	unsigned        m_sync,	/* sync bytes ($87cd) */
	                m_size,	/* module size */
	                m_name;	/* offset to module name */
	char            m_tylan,/* type & language */
	                m_attrev,	/* attributes & revision */
	                m_parity;	/* header parity */

	unsigned        m_fmname,	/* offset to file manager name */
	                m_ddname;	/* offset to device driver name */
	char            m_mode;	/* mode byte */
	char            m_control[3];	/* device controller address (24 bit) */
	char            m_tabsize;	/* option table size */
}               mod_dev;


/* Configuration module */
typedef struct
{
	unsigned        m_sync,	/* sync bytes ($87cd) */
	                m_size,	/* module size */
	                m_name;	/* offset to module name */
	char            m_tylan,/* type & language */
	                m_attrev,	/* attributes & revision */
	                m_parity;	/* header parity */

	char            m_ramtop[3];	/* top limit of free ram */
	char            m_irqno,/* IRQ polling entries */
	                m_devno;/* device entries */
	unsigned        m_startup,	/* offset to startup mod. name */
	                m_sysdrive,	/* offset to default drive name */
	                m_boot;	/* offset to bootstrap module name */
}               mod_config;


/* C data module */
typedef struct
{
	unsigned        m_sync,	/* sync bytes ($87cd) */
	                m_size,	/* module size */
	                m_name;	/* offset to module name */
	char            m_tylan,/* type & language */
	                m_attrev,	/* attributes & revision */
	                m_parity;	/* header parity */

	unsigned        m_data,	/* offset to data */
	                m_dsize;/* size of data */
}               mod_data;

#endif				/* _MODULE_H */
