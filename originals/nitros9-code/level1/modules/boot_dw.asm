********************************************************************
* Boot - DriveWire 3 Boot Module
* Provides HWInit, HWTerm, HWRead which are called by code in
* "use"d boot_common.asm
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2008/02/09  Boisy G. Pitre
* Created.

               NAM       Boot
               TTL       DriveWire Boot Module

             IFP1
               USE       defsfile
               USE       drivewire.d
             ENDC

tylg           SET       Systm+Objct
atrv           SET       ReEnt+rev
rev            SET       0
edition        SET       1

               MOD       eom,name,tylg,atrv,start,size

* on-stack buffer to use
               ORG       0
seglist        RMB       2                   pointer to segment list
blockloc       RMB       2                   pointer to memory requested
blockimg       RMB       2                   duplicate of the above
bootloc        RMB       3                   sector pointer; not byte pointer
bootsize       RMB       2                   size in bytes
LSN0Ptr        RMB       2                   LSN0 pointer
size           EQU       .

name           EQU       *
               FCS       /Boot/
               FCB       edition


* Common booter-required defines
LSN24BIT       EQU       1
FLOPPY         EQU       0


               USE       boot_common.asm


************************************************************
************************************************************
*              Hardware-Specific Booter Area               *
************************************************************
************************************************************

* HWInit - Initialize the device
*   Entry: Y = hardware address
*   Exit:  Carry Clear = OK, Set = Error
*          B = error (Carry Set)
HWInit
               use       dwinit.asm

HWTerm         clrb
               rts


* HWRead - Read a 256 byte sector from the device
*   Entry: Y = hardware address
*          B = bits 23-16 of LSN
*          X = bits 15-0  of LSN
*                  blockloc,u = ptr to 256 byte sector
*   Exit:  X = ptr to data (i.e. ptr in blockloc,u)
*          Carry Clear = OK, Set = Error
HWRead
               pshs      cc,d,x
* Send out op code and 3 byte LSN
               lda       #OP_READEX           load A with READ opcode
Read2          ldb       WhichDrv,pcr
               std       ,s
               leax      ,s
               ldy       #5
               lbsr      DWWrite              send it to server
* Get 256 bytes of sector data
               ldx       blockloc,u
               ldy       #256
               bsr       DWRead               read bytes from server
               bcs       ReadEr               branch if framing error
               bne       ReadEr2

* Send two byte checksum
               pshs      y
               leax      ,s
               ldy       #2
               lbsr      DWWrite
               ldy       #1
               bsr       DWRead
               leas      2,s
               bcs       ReadEx
               bne      ReadEr2
               ldb       ,s
               beq       ReadEx
               cmpb      #E_CRC
               bne       ReadEr
               lda       #OP_REREADEX
               bra       Read2
ReadEx         EQU       *
               leas      5,s                 eat stack
               ldx       blockloc,u
               clrb
               rts
ReadEr2        ldb       #E$Read
ReadEr
               leas      5,s                 eat stack
               orcc      #Carry
               rts

               USE       dwread.asm
               USE       dwwrite.asm

             IFGT      Level-1
* L2 kernel file is composed of rel, boot, krn. The size of each of these
* is controlled with filler, so that (after relocation):
* rel  starts at $ED00 and is $130 bytes in size
* boot starts at $EE30 and is $1D0 bytes in size
* krn  starts at $F000 and ends at $FEFF (there is no 'emod' at the end
*      of krn and so there are no module-end boilerplate bytes)
*
* Filler to get to a total size of $1D0. 3, 2, 1 represent bytes after
* the filler: the end boilerplate for the module, fdb and fcb respectively.
Filler         FILL      $39,$1D0-3-2-1-*
             ENDC

Address        FDB       $0000
WhichDrv       FCB       $00

               EMOD
eom            EQU       *
               END
