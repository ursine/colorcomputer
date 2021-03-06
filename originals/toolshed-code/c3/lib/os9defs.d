********************************************************************
* OS9Defs - NitrOS-9 System Definitions
*
* $Id  os9defs.a,v 1.1 2005/07/27 01 15 41 boisy Exp $
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          1985/08/29  KMZ
* Fixed DT.SBF/NFM values to 3/4
*
*          1985/09/01  KMZ
* Added SS.FDInf, SS.Attr to accept 68K request thru NET.
*
*          1985/09/03  KMZ/Robert F. Doggett
* Eliminated E$BPrcID, made Error #238 become E$DNE for
* 68000 compatability.
*
*          1986/04/15  Mark G. Hawkins
* F$AlHRAM System call added for COCO.
*
*          1986/09/08  Mark G. Hawkins
* F$Alarm for COCO Clock Module.
*
*          1986/09/17  Mark G. Hawkins
* SS.Tone For COCO.
*
*          1986/09/23  Mark G. Hawkins
* Added F$NMLink and F$NMLoad for COCO.
*
*          1986/09/30  Mark G. Hawkins
* Added Reserved User $70 to $7f in sytem calls.
*
*          1986/09/30  Mark G. Hawkins
* Created Color Computer 3 Version of OS9Defs.
*
*          1998/10/03  Boisy G. Pitre
* Consoldated Level 1/Level 2 os9defs.
*
*          2002/04/04  Boisy G. Pitre
* Consoldated Level 2/Level 2 V3 os9defs.
*
*          2002/04/30  Boisy G. Pitre
* Added NitrOS-9 definitions.
*
*          2003/05/30  Boisy G. Pitre
* Added WD1002 sys vars to Level One section.
*
*          2003/06/02  Boisy G. Pitre
* Fixed incorrectly ordered D.X*** system globals for OS-9 Level One and
* changed the sizes from 2 to 3 bytes.
* DT.NFM is now the same for both Level One and Level Two.
* Added DT.CDFM type for future CD-ROM file manager
*
*          2003/11/05  Robert Gault
* Fixed MouseInf. Made it rmb 2 as it should be. Also changes to init and cc3io.

          nam   OS9Defs
          IFEQ  Level-1
          ttl   NitrOS-9 Level 1 System Symbol Definitions
          ELSE
          IFEQ  Level-2
          ttl   NitrOS-9 Level 2 System Symbol Definitions
          ELSE
          ttl   NitrOS-9 Level 3 System Symbol Definitions
          ENDC
          ENDC

          psect os9defs_a,0,0,0,0,0

* Common definitions
true      equ   1          useful name
false     equ   0          useful name

          pag
*****************************************
* System Service Request Code Definitions
*
          csect 0
F$Link    rmb   1          Link to Module
F$Load    rmb   1          Load Module from File
F$UnLink  rmb   1          Unlink Module
F$Fork    rmb   1          Start New Process
F$Wait    rmb   1          Wait for Child Process to Die
F$Chain   rmb   1          Chain Process to New Module
F$Exit    rmb   1          Terminate Process
F$Mem     rmb   1          Set Memory Size
F$Send    rmb   1          Send Signal to Process
F$Icpt    rmb   1          Set Signal Intercept
F$Sleep   rmb   1          Suspend Process
F$SSpd    rmb   1          Suspend Process
F$ID      rmb   1          Return Process ID
F$SPrior  rmb   1          Set Process Priority
F$SSWI    rmb   1          Set Software Interrupt
F$PErr    rmb   1          Print Error
F$PrsNam  rmb   1          Parse Pathlist Name
F$CmpNam  rmb   1          Compare Two Names
F$SchBit  rmb   1          Search Bit Map
F$AllBit  rmb   1          Allocate in Bit Map
F$DelBit  rmb   1          Deallocate in Bit Map
F$Time    rmb   1          Get Current Time
F$STime   rmb   1          Set Current Time
F$CRC     rmb   1          Generate CRC

          IFGT  Level-1

* NitrOS-9 Level 2 system calls
F$GPrDsc  rmb   1          Get Process Descriptor copy
F$GBlkMp  rmb   1          Get System Block Map copy
F$GModDr  rmb   1          Get Module Directory copy
F$CpyMem  rmb   1          Copy External Memory
F$SUser   rmb   1          Set User ID number
F$UnLoad  rmb   1          Unlink Module by name
F$Alarm   rmb   1          Color Computer 3 Alarm Call
          rmb   2          Reserved - For overlap of other systems
F$NMLink  rmb   1          Color Computer 3 Non-Mapping Link
F$NMLoad  rmb   1          Color Computer 3 Non-Mapping Load

          ENDC

          endsect

          IFGT  Level-1

          csect $25
F$TPS     rmb   1          Return System's Ticks Per Second
F$TimAlm  rmb   1          CoCo individual process alarm call
          endsect

          ENDC

          csect $27        Beginning of System Reserved Calls
F$VIRQ    rmb   1          Install/Delete Virtual IRQ
F$SRqMem  rmb   1          System Memory Request
F$SRtMem  rmb   1          System Memory Return
F$IRQ     rmb   1          Enter IRQ Polling Table
F$IOQu    rmb   1          Enter I/O Queue
F$AProc   rmb   1          Enter Active Process Queue
F$NProc   rmb   1          Start Next Process
F$VModul  rmb   1          Validate Module
F$Find64  rmb   1          Find Process/Path Descriptor
F$All64   rmb   1          Allocate Process/Path Descriptor
F$Ret64   rmb   1          Return Process/Path Descriptor
F$SSvc    rmb   1          Service Request Table Initialization
F$IODel   rmb   1          Delete I/O Module

          IFGT  Level-1

F$SLink   rmb   1          System Link
F$Boot    rmb   1          Bootstrap System
F$BtMem   rmb   1          Bootstrap Memory Request
F$GProcP  rmb   1          Get Process ptr
F$Move    rmb   1          Move Data (low bound first)
F$AllRAM  rmb   1          Allocate RAM blocks
F$AllImg  rmb   1          Allocate Image RAM blocks
F$DelImg  rmb   1          Deallocate Image RAM blocks
F$SetImg  rmb   1          Set Process DAT Image
F$FreeLB  rmb   1          Get Free Low Block
F$FreeHB  rmb   1          Get Free High Block
F$AllTsk  rmb   1          Allocate Process Task number
F$DelTsk  rmb   1          Deallocate Process Task number
F$SetTsk  rmb   1          Set Process Task DAT registers
F$ResTsk  rmb   1          Reserve Task number
F$RelTsk  rmb   1          Release Task number
F$DATLog  rmb   1          Convert DAT Block/Offset to Logical
F$DATTmp  rmb   1          Make temporary DAT image (Obsolete)
F$LDAXY   rmb   1          Load A [X,[Y]]
F$LDAXYP  rmb   1          Load A [X+,[Y]]
F$LDDDXY  rmb   1          Load D [D+X,[Y]]
F$LDABX   rmb   1          Load A from 0,X in task B
F$STABX   rmb   1          Store A at 0,X in task B
F$AllPrc  rmb   1          Allocate Process Descriptor
F$DelPrc  rmb   1          Deallocate Process Descriptor
F$ELink   rmb   1          Link using Module Directory Entry
F$FModul  rmb   1          Find Module Directory Entry
F$MapBlk  rmb   1          Map Specific Block
F$ClrBlk  rmb   1          Clear Specific Block
F$DelRAM  rmb   1          Deallocate RAM blocks
F$GCMDir  rmb   1          Pack module directory
F$AlHRAM  rmb   1          Allocate HIGH RAM Blocks

* Alan DeKok additions
* F$ReBoot has been renamed to F$Debug
*F$ReBoot  rmb   1          Reboot machine (reload OS9Boot) or drop to RSDOS
F$Debug   rmb   1          Drop the system into the debugger
F$CRCMod  rmb   1          CRC mode, toggle or report current status
F$XTime   rmb   1          Get Extended time packet from RTC (fractions of second)
F$VBlock  rmb   1          Verify modules in a block of memory, add to module directory

          ENDC

          endsect

*
* Numbers $70 through $7F are reserved for user definitions
*
          csect $70

	  IFEQ  Level-1
	  rmb   16         Reserved for user definition
          ELSE

F$RegDmp  rmb   1          Ron Lammardo's debugging register dump
F$NVRAM   rmb   1          Non Volatile RAM (RTC battery backed static) read/write

          rmb   $80-*      Reserved for user definitions
          ENDC

          endsect

          pag
**************************************
* I/O Service Request Code Definitions
*
          csect $80
I$Attach  rmb   1          Attach I/O Device
I$Detach  rmb   1          Detach I/O Device
I$Dup     rmb   1          Duplicate Path
I$Create  rmb   1          Create New File
I$Open    rmb   1          Open Existing File
I$MakDir  rmb   1          Make Directory File
I$ChgDir  rmb   1          Change Default Directory
I$Delete  rmb   1          Delete File
I$Seek    rmb   1          Change Current Position
I$Read    rmb   1          Read Data
I$Write   rmb   1          Write Data
I$ReadLn  rmb   1          Read Line of ASCII Data
I$WritLn  rmb   1          Write Line of ASCII Data
I$GetStt  rmb   1          Get Path Status
I$SetStt  rmb   1          Set Path Status
I$Close   rmb   1          Close Path
I$DeletX  rmb   1          Delete from current exec dir
          endsect

*******************
* File Access Modes
*
READ.     equ   %00000001
WRITE.    equ   %00000010
UPDAT.    equ   READ.+WRITE.
EXEC.     equ   %00000100
PREAD.    equ   %00001000
PWRIT.    equ   %00010000
PEXEC.    equ   %00100000
SHARE.    equ   %01000000
DIR.      equ   %10000000
ISIZ.     equ   %00100000

**************
* Signal Codes
*
          csect 0
S$Kill    rmb   1          Non-Interceptable Abort
S$Wake    rmb   1          Wake-up Sleeping Process
S$Abort   rmb   1          Keyboard Abort
S$Intrpt  rmb   1          Keyboard Interrupt
S$Window  rmb   1          Window Change
S$Alarm   rmb   1          CoCo individual process' alarm signal
          endsect

          pag
**********************************
* Status Codes for GetStat/GetStat
*
          csect 0
SS.Opt    rmb   1          Read/Write PD Options
SS.Ready  rmb   1          Check for Device Ready
SS.Size   rmb   1          Read/Write File Size
SS.Reset  rmb   1          Device Restore
SS.WTrk   rmb   1          Device Write Track
SS.Pos    rmb   1          Get File Current Position
SS.EOF    rmb   1          Test for End of File
SS.Link   rmb   1          Link to Status routines
SS.ULink  rmb   1          Unlink Status routines
SS.Feed   rmb   1          issue form feed
SS.Frz    rmb   1          Freeze DD. information
SS.SPT    rmb   1          Set DD.TKS to given value
SS.SQD    rmb   1          Sequence down hard disk
SS.DCmd   rmb   1          Send direct command to disk
SS.DevNm  rmb   1          Return Device name (32-bytes at [X])
SS.FD     rmb   1          Return File Descriptor (Y-bytes at [X])
SS.Ticks  rmb   1          Set Lockout honor duration
SS.Lock   rmb   1          Lock/Release record
SS.DStat  rmb   1          Return Display Status (CoCo)
SS.Joy    rmb   1          Return Joystick Value (CoCo)
SS.BlkRd  rmb   1          Block Read
SS.BlkWr  rmb   1          Block Write
SS.Reten  rmb   1          Retension cycle
SS.WFM    rmb   1          Write File Mark
SS.RFM    rmb   1          Read past File Mark
SS.ELog   rmb   1          Read Error Log
SS.SSig   rmb   1          Send signal on data ready
SS.Relea  rmb   1          Release device
SS.AlfaS  rmb   1          Return Alfa Display Status (CoCo, SCF/GetStat)
SS.Attr   equ   SS.AlfaS   to serve 68K/RBF/SetStat only, thru NET
SS.Break  rmb   1          Send break signal out acia
SS.RsBit  rmb   1          Reserve bitmap sector (do not allocate in) LSB(X)=sct#
          rmb   1          reserved
SS.FDInf  equ   $20        to serve 68K/RBF/GetStat only, thru NET
          rmb   4          reserve $20-$23 for Japanese version (Hoshi)
SS.SetMF  rmb   1          reserve $24 for Gimix G68 (Flex compatability?)
SS.Cursr  rmb   1          Cursor information for COCO
SS.ScSiz  rmb   1          Return screen size for COCO
SS.KySns  rmb   1          Getstat/SetStat for COCO keyboard
SS.ComSt  rmb   1          Getstat/SetStat for Baud/Parity
SS.Open   rmb   1          SetStat to tell driver a path was opened
SS.Close  rmb   1          SetStat to tell driver a path was closed
SS.HngUp  rmb   1          SetStat to tell driver to hangup phone
SS.FSig   rmb   1          new signal for temp locked files
SS.DSize  equ   SS.ScSiz   Return disk size (RBF GetStat)
SS.VarSect  equ SS.DStat   Variable Sector Size (RBF GetStat)

          endsect

* System Specific and User defined codes above $80
          csect $80
SS.AAGBf  rmb   1          SetStat to Allocate Additional Graphic Buffer
SS.SLGBf  rmb   1          SetStat to Select a different Graphic Buffer
SS.Mount  rmb   1          Network 4 Mount Setstat
SS.RdNet  rmb   1          Read Raw Sector from Network 4 Omnidrive
SS.MpGPB  rmb   1          SetStat to request a Get/Put Buffer be mapped in workspace
SS.Slots  rmb   1          Network 4 slots? getstat

          IFGT  Level-1

* Level 2 Windowing
SS.WnSet  rmb   1          Set up High Level Windowing Information
SS.MnSel  rmb   1          Request High level Menu Handler take determine next event
SS.SBar   rmb   1          SetStat to set position block on Window scroll bars
SS.Mouse  rmb   1          Return Mouse information packet (COCO)
SS.MsSig  rmb   1          SetStat to tell driver to send signal on mouse event
SS.AScrn  rmb   1          Allocate a screen for application poking
SS.DScrn  rmb   1          Display a screen allocated by SS.AScrn
SS.FScrn  rmb   1          Free a screen allocated by SS.AScrn
SS.PScrn  rmb   1          Polymorph Screen into different screen type
SS.ScInf  rmb   1          Get Current screen info for direct writes
          rmb   1          Reserved
SS.Palet  rmb   1          Return palette information
SS.Montr  rmb   1          Get and Set Monitor Type
SS.ScTyp  rmb   1          Get screen type information
SS.GIP    rmb   1          Global Input Parameters (SetStat)
SS.UMBar  rmb   1          update menu bar (SetStat)
SS.FBRgs  rmb   1          return color registers (GetStat)
SS.DfPal  rmb   1          set/return default palette registers (Getstat/Setstat)
SS.Tone   rmb   1          Generate a tone using 6 bit sound
SS.GIP2   rmb   1          Global Input Params #2 (L2V3)
SS.AnPal  rmb   1          Animate palettes (L2V3)
SS.FndBf  rmb   1          Find named buffer (L2V3)

* sc6551 defined
SS.CDSta  equ   SS.GIP2
SS.CDSig  equ   SS.AnPal
SS.CDRel  equ   SS.FndBf
          ELSE
* These are wide open in Level 1
          rmb    19

* sc6551 defined
SS.CDSta  rmb   1
SS.CDSig  rmb   1
SS.CDRel  rmb   1
          ENDC

          endsect


          csect $A0
*
* New Default SCF input buffer Set status call
SS.Fill   rmb   1          Pre-load SCF device input buffer
SS.Hist   rmb   1          Enable command-line history easily

          endsect

          csect $B0
*
* New WDDisk get/set status calls
SS.ECC    rmb   1          ECC corrected data error enable/disable (GetStat/SetStat)

*
          IFGT  Level-1

* VRN get/set status calls.  Named by Alan DeKok.
SS.VCtr   equ  $80         Return FS2 total VIRQ counter
SS.VSig   equ  $81         Return FS2 number of signals sent

SS.FClr   equ  $81         Set/clear FS2 VIRQ
SS.FSet   equ  $C7         Set FS2+ VIRQ
SS.KSet   equ  $C8         Set KQ3 VIRQ
SS.KClr   equ  $C9         Clr KQ3 VIRQ
SS.ARAM   equ  $CA         Allocate RAM blocks
SS.DRAM   equ  $CB         De-allocate RAM blocks

* SDisk 3 Definition Equates
SS.DRead  equ SS.AAGBf     SDisk3 Direct Sector Read ($80)
SS.DWrit  equ SS.DRead     SDisk3 Direct sector Write ($80)
SS.UnFrz  equ SS.SLGBf     SDisk3 UNFreeze DD info ($81)
SS.MOFF   equ SS.Mount     SDisk3 fast motor off call ($82)
SS.MoTim  equ SS.RdNet     SDisk3 Set motor shut off time ($83)
SS.SDRD   equ SS.MpGPB     SDisk3 System direct read ($84)
SS.SDWRT  equ SS.SDRD      SDisk3 System direct writes ($84)
SS.Sleep  equ SS.Slots     SDisk3 (DMC ONLY) Enable/disable F$Sleep calls in read/write 1773 I/O ($85)
SS.DrvCh  equ SS.WnSet     SDisk3 (DMC ONLY) Set drive number to cache, or return drive number being cached ($86)

          ENDC

          endsect

          ttl   Direct Page Definitions
          pag

**********************************
* Direct Page Variable Definitions
*
          IFEQ  Level-1

* Level 1 DP vars
          csect $00
D.WDAddr  rmb   2          FHL/Isted WD1002-05 interface base address
D.WDBtDr  rmb   1          FHL/Isted WD1002-05 boot physical device drive num.
D.SWPage  rmb   1          SmartWatch page # (see clock2_smart)
          rmb   5
D.COCOXT  rmb   1          Busy flag for CoCo-XT driver (one drive at a time)
          endsect

          csect $20
D.FMBM    rmb   4          Free memory bit map pointers
D.MLIM    rmb   2          Memory limit $24
D.ModDir  rmb   4          Module directory $26
D.Init    rmb   2          Rom base address $2A
D.SWI3    rmb   2          Swi3 vector $2C
D.SWI2    rmb   2          Swi2 vector $2E
D.FIRQ    rmb   2          Firq vector $30
D.IRQ     rmb   2          Irq vector $32
D.SWI     rmb   2          Swi vector $34
D.NMI     rmb   2          Nmi vector $36
D.SvcIRQ  rmb   2          Interrupt service entry $38
D.Poll    rmb   2          Interrupt polling routine $3A
D.UsrIRQ  rmb   2          User irq routine $3C
D.SysIRQ  rmb   2          System irq routine $3E
D.UsrSvc  rmb   2          User service request routine $40
D.SysSvc  rmb   2          System service request routine $42
D.UsrDis  rmb   2          User service request dispatch table
D.SysDis  rmb   2          System service reuest dispatch table
D.Slice   rmb   1          Process time slice count $48
D.PrcDBT  rmb   2          Process descriptor block address  $49
D.Proc    rmb   2          Process descriptor address $4B
D.AProcQ  rmb   2          Active process queue $4D
D.WProcQ  rmb   2          Waiting process queue $4F
D.SProcQ  rmb   2          Sleeping process queue $51
D.Time    equ   *          Time
D.Year    rmb   1          $53
D.Month   rmb   1          $54
D.Day     rmb   1          $55
D.Hour    rmb   1          $56
D.Min     rmb   1          $57
D.Sec     rmb   1          $58
D.Tick    rmb   1          $59
D.TSec    rmb   1          Ticks / second $5A
D.TSlice  rmb   1          Ticks / time-slice $5B
D.IOML    rmb   2          I/O mgr free memory low bound $5C
D.IOMH    rmb   2          I/O mgr free memory hi  bound $5E
D.DevTbl  rmb   2          Device driver table addr $60
D.PolTbl  rmb   2          Irq polling table addr $62
D.PthDBT  rmb   2          Path descriptor block table addr $64
D.BTLO    rmb   2          Bootstrap low address $66
D.BTHI    rmb   2          Bootstrap hi address $68
D.DMAReq  rmb   1          DMA in use flag $6A
D.AltIRQ  rmb   2          Alternate IRQ vector (CC) $6B
D.KbdSta  rmb   2          Keyboard scanner static storage (CC) $6D
D.DskTmr  rmb   2          Disk Motor Timer (CC) $6F
D.CBStrt  rmb   16         reserved for CC warmstart ($71)
D.Clock   rmb   2          Address of Clock Tick Routine (CC) $81
D.Boot    rmb   1          Bootstrap attempted flag
D.URtoSs  rmb   2          address of user to system routine (VIRQ) $84
D.CLTb    rmb   2          Pointer to clock interrupt table (VIRQ) $86
D.MDREG   rmb   1          6309 MD (mode) shadow register $88 (added in V2.01.00)
D.CRC     rmb   1          CRC checking mode flag $89 (added in V2.01.00)
D.Clock2  rmb   2          CC Clock2 entry address
          endsect

          csect $100
D.XSWI3   rmb   3
D.XSWI2   rmb   3
D.XSWI    rmb   3
D.XNMI    rmb   3
D.XIRQ    rmb   3
D.XFIRQ   rmb   3

* Table Sizes
BMAPSZ    equ   32         Bitmap table size
SVCTNM    equ   2          Number of service request tables
SVCTSZ    equ   (256-BMAPSZ)/SVCTNM-2 Service request table size
          endsect

          ELSE

* Level 2 DP vars
          csect $00
D.WDAddr  rmb   2          FHL/Isted WD1002-05 interface base address
D.WDBtDr  rmb   1          FHL/Isted WD1002-05 boot physical device drive num.
D.SWPage  rmb   1          SmartWatch page # (see clock2_smart)
          rmb   5
D.COCOXT  rmb   1          Busy flag for CoCo-XT driver (one drive at a time)
          endsect

          csect $20
D.Tasks   rmb   2          Task User Table
D.TmpDAT  rmb   2          Temporary DAT Image stack
D.Init    rmb   2          Initialization Module ptr
D.Poll    rmb   2          Interrupt Polling Routine ptr
D.Time    equ   *          System Time
D.Year    rmb   1
D.Month   rmb   1
D.Day     rmb   1
D.Hour    rmb   1
D.Min     rmb   1
D.Sec     rmb   1
D.Tick    rmb   1
D.Slice   rmb   1          current slice remaining
D.TSlice  rmb   1          Ticks per Slice
D.Boot    rmb   1          Bootstrap attempted flag
D.MotOn   rmb   1          Floppy Disk Motor-On time out
D.ErrCod  rmb   1          Reset Error Code
D.Daywk   rmb   1          day of week, com-trol clock
D.TkCnt   rmb   1          Tick Counter
D.BtPtr   rmb   2          Address of Boot in System Address space
D.BtSz    rmb   2          Size of Boot

          IFNE  H6309
D.MDREG   rmb   1          6309 MD (mode) shadow register
          ELSE
          rmb   1          Currently unused in NitrOS-9/6809
          ENDC

D.CRC     rmb   1          CRC checking mode flag

D.Tenths  rmb   1          Tenths and hundredths of second for F$Xtime
D.Task1N  rmb   1          Map type 1 task number*2 - offset into [D.TskIPt]
D.Quick   rmb   1          Quick system call return flag - 0 =stack is at $FEE1
D.QIRQ    rmb   1          Quick IRQ flag - 0 =IRQ wasn't clock, so quick return
          endsect

          csect $40
D.BlkMap  rmb   4          Memory Block Map ptr
D.ModDir  rmb   4          Module Directory ptrs
D.PrcDBT  rmb   2          Process Descriptor Block Table ptr
D.SysPrc  rmb   2          System Process Descriptor ptr
D.SysDAT  rmb   2          System DAT Image ptr
D.SysMem  rmb   2          System Memory Map ptr
D.Proc    rmb   2          Current Process ptr
D.AProcQ  rmb   2          Active Process Queue
D.WProcQ  rmb   2          Waiting Process Queue
D.SProcQ  rmb   2          Sleeping Process Queue
D.ModEnd  rmb   2          Module Directory end ptr
D.ModDAT  rmb   2          Module Dir DAT image end ptr
D.CldRes  rmb   2          Cold Restart vector
D.BtBug   rmb   3          Boot debug information
D.Pipe    rmb   2
          endsect

          csect $6B
D.Crash   rmb   6          Pointer to CC Crash Routine
D.CBStrt  rmb   $B         Reserved for CC warmstart ($71)
D.QCnt    rmb   1          Count of number of quick system calls performed
          endsect

          csect $80
D.DevTbl  rmb   2          I/O Device Table
D.PolTbl  rmb   2          I/O Polling Table
          rmb   4          reserved
D.PthDBT  rmb   2          Path Descriptor Block Table ptr
D.DMAReq  rmb   1          DMA Request flag
          endsect

********
* CoCo 3 STUFF COMES NEXT
* This area is used for the CoCo Hardware Registers
*
          csect $90
D.HINIT   rmb   1          GIME INIT0 register (hardware setup $FF90)
D.TINIT   rmb   1          GIME INIT1 register (timer/task register $FF91)
D.IRQER   rmb   1          Interrupt enable regsiter ($FF92)
D.FRQER   rmb   1          Fast Interrupt enable register ($FF93)
D.TIMMS   rmb   1          Timer most significant nibble ($FF94)
D.TIMLS   rmb   1          Timer least significant byte ($FF95)
D.RESV1   rmb   1          reserved register ($FF96)
D.RESV2   rmb   1          reserved register ($FF97)
D.VIDMD   rmb   1          video mode register ($FF98)
D.VIDRS   rmb   1          video resolution register ($FF99)
D.BORDR   rmb   1          border register ($FF9A)
D.RESV3   rmb   1          reserved register ($FF9B)
D.VOFF2   rmb   1          vertical scroll/offset 2 register ($FF9C)
D.VOFF1   rmb   1          vertical offset 1 register ($FF9D)
D.VOFF0   rmb   1          vertical offset 0 register ($FF9E)
D.HOFF0   rmb   1          horizontal offset 0 register ($FF9F)
D.Speed   rmb   1          Speed of COCO CPU 0=slow,1=fast ($A0)
D.TskIPt  rmb   2          Task image Pointer table (CC) ($A1)
D.MemSz   rmb   1          128/512K memory flag (CC) ($A3)
D.SSTskN  rmb   1          System State Task Number (COCO) ($A4)
D.CCMem   rmb   2          Pointer to beginning of CC Memory ($A5)
D.CCStk   rmb   2          Pointer to top of CC Memory ($A7)
D.Flip0   rmb   2          Change to Task 0 ($A9)
D.Flip1   rmb   2          Change to reserved Task 1 ($AB)
D.VIRQ    rmb   2          VIRQ Polling routine ($AD)
D.IRQS    rmb   1          IRQ shadow register (CC Temporary) ($AF)
D.CLTb    rmb   2          VIRQ Table address ($B0)
D.AltIRQ  rmb   2          Alternate IRQ Vector (CC) ($B2)
D.GPoll   rmb   2          CC GIME IRQ enable/disable toggle
D.Clock2  rmb   2          CC Clock2 entry address
          endsect

          csect $C0
D.SysSvc  rmb   2          System Service Routine entry
D.SysDis  rmb   2          System Service Dispatch Table ptr
D.SysIRQ  rmb   2          System IRQ Routine entry
D.UsrSvc  rmb   2          User Service Routine entry
D.UsrDis  rmb   2          User Service Dispatch Table ptr
D.UsrIRQ  rmb   2          User IRQ Routine entry
D.SysStk  rmb   2          System stack
D.SvcIRQ  rmb   2          In-System IRQ service
D.SysTsk  rmb   1          System Task number
          endsect

          csect $E0
D.Clock   rmb   2
D.XSWI3   rmb   2
D.XSWI2   rmb   2
D.XFIRQ   rmb   2
D.XIRQ    rmb   2
D.XSWI    rmb   2
D.XNMI    rmb   2
D.ErrRst  rmb   2
D.SysVec  rmb   2          F$xxx system call vector for NitrOS-9 Level 3
D.SWI3    rmb   2
D.SWI2    rmb   2
D.FIRQ    rmb   2
D.IRQ     rmb   2
D.SWI     rmb   2
D.NMI     rmb   2
          endsect

*************************
* Level 2 Block Map flags
*
NotRAM    equ   %10000000  Block Not RAM flag
VidRAM    equ   %00000100  Block is being used as Video RAM
ModBlock  equ   %00000010  Module in Block
RAMinUse  equ   %00000001  RAM Block in use flag
*
* Service Dispatch Table special entries
*
IOEntry   equ   254

          ENDC

          ttl   Structure Formats
          pag
************************************
* Module Directory Entry Definitions
*
          csect 0
          IFGT  Level-1
MD$MPDAT  rmb   2          Module DAT Image ptr
MD$MBSiz  rmb   2          Memory Block size
          ENDC
MD$MPtr   rmb   2          Module ptr
MD$Link   rmb   2          Module Link count
MD$ESize  equ   *          Module Directory Entry size
          endsect

************************************
* Module Definitions
*
* Universal Module Offsets
*
          csect 0
M$ID      rmb   2          ID Code
M$Size    rmb   2          Module Size
M$Name    rmb   2          Module Name
M$Type    rmb   1          Type / Language
M$Revs    rmb   1          Attributes / Revision Level
M$Parity  rmb   1          Header Parity
M$IDSize  equ   *          Module ID Size
*
* Type-Dependent Module Offsets
*
* System, File Manager, Device Driver, Program Module
*
M$Exec    rmb   2          Execution Entry Offset
*
* Device Driver, Program Module
*
M$Mem     rmb   2          Stack Requirement
*
* Device Driver, Device Descriptor Module
*
M$Mode    rmb   1          Device Driver Mode Capabilities
         endsect
*
* Device Descriptor Module
*
          csect M$IDSize
M$FMgr    rmb   2          File Manager Name Offset
M$PDev    rmb   2          Device Driver Name Offset
          rmb   1          M$Mode (defined above)
M$Port    rmb   3          Port Address
M$Opt     rmb   1          Device Default Options
M$DTyp    rmb   1          Device Type
IT.DTP    equ   M$DTyp     Descriptor type offset
          endsect
*
* Configuration Module Entry Offsets
*
          csect M$IDSize
MaxMem    rmb   3          Maximum Free Memory
PollCnt   rmb   1          Entries in Interrupt Polling Table
DevCnt    rmb   1          Entries in Device Table
InitStr   rmb   2          Initial Module Name
SysStr    rmb   2          System Device Name
StdStr    rmb   2          Standard I/O Pathlist
BootStr   rmb   2          Bootstrap Module name
ProtFlag  rmb   1          Write protect enable flag

OSLevel   rmb   1          OS level
OSVer     rmb   1          OS version
OSMajor   rmb   1          OS major
OSMinor   rmb   1          OS minor
Feature1  rmb   1          feature byte 1
Feature2  rmb   1          feature byte 2
          rmb   8          reserved for future use

          IFGT  Level-1
* -- CC3IO area -- (NitrOS-9 Level 2 and above) *
MonType   rmb   1          Monitor type (0=CMP,1=RGB,2=MONO)
MouseInf  rmb   2          Mouse resolution/Mouse port; was 1, major error RG.
KeyRptS   rmb   1          Key repeat start constant
KeyRptD   rmb   1          Key repeat delay constant
          ENDC
          endsect

* Feature1 byte definitions
CRCOn     equ   %00000001  CRC checking on
CRCOff    equ   %00000000  CRC checking off

          pag
**************************
* Module Field Definitions
*
* ID Field - First two bytes of a NitrOS-9 module
*
M$ID1     equ   $87        Module ID code byte one
M$ID2     equ   $CD        Module ID code byte two
M$ID12    equ   M$ID1*256+M$ID2

*
* Module Type/Language Field Masks
*
TypeMask  equ   %11110000  Type Field
LangMask  equ   %00001111  Language Field

*
* Module Type Values
*
Devic     equ   $F0        Device Descriptor Module
Drivr     equ   $E0        Physical Device Driver
FlMgr     equ   $D0        File Manager
Systm     equ   $C0        System Module
ShellSub  equ   $50        Shell+ shell sub module
Data      equ   $40        Data Module
Multi     equ   $30        Multi-Module
Sbrtn     equ   $20        Subroutine Module
Prgrm     equ   $10        Program Module

*
* Module Language Values
*
Objct     equ   1          6809 Object Code Module
ICode     equ   2          Basic09 I-code
PCode     equ   3          Pascal P-code
CCode     equ   4          C I-code
CblCode   equ   5          Cobol I-code
FrtnCode  equ   6          Fortran I-code
Obj6309   equ   7          6309 object code
*
* Module Attributes / Revision byte
*
* Field Masks
*
AttrMask  equ   %11110000  Attributes Field
RevsMask  equ   %00001111  Revision Level Field
*
* Attribute Flags
*
ReEnt     equ   %10000000  Re-Entrant Module
ModProt   equ   %01000000  Gimix Module protect bit (0=protected, 1=write enable)
ModNat    equ   %00100000  6309 native mode attribute

********************
* Device Type Values
*
* These values define various classes of devices, which are
* managed by a file manager module.  The Device Type is embedded
* in a device's device descriptor.
*
DT.SCF    equ   0          Sequential Character File Manager
DT.RBF    equ   1          Random Block File Manager
DT.Pipe   equ   2          Pipe File Manager
DT.SBF    equ   3          Sequential Block File Manager
DT.NFM    equ   4          Network File Manager
DT.CDFM   equ   5          CD-ROM File Manager


*********************
* CRC Result Constant
*
CRCCon1   equ   $80
CRCCon23  equ   $0FE3

          ttl   Process Information
          pag
********************************
* Process Descriptor Definitions
*
          IFEQ  Level-1

* Level 1 process descriptor defs
DefIOSiz  equ   12
NumPaths  equ   16         Number of Local Paths

          csect 0
P$ID      rmb   1          Process ID
P$PID     rmb   1          Parent's ID
P$SID     rmb   1          Sibling's ID
P$CID     rmb   1          Child's ID
P$SP      rmb   2          Stack ptr
P$CHAP    rmb   1          process chapter number
P$ADDR    rmb   1          user address beginning page number
P$PagCnt  rmb   1          Memory Page Count
P$User    rmb   2          User Index $09
P$Prior   rmb   1          Priority $0B
P$Age     rmb   1          Age $0C
P$State   rmb   1
P$Queue   rmb   2          Queue Link (Process ptr) $0E
P$IOQP    rmb   1          Previous I/O Queue Link (Process ID) $10
P$IOQN    rmb   1          Next     I/O Queue Link (Process ID)
P$PModul  rmb   2          Primary Module
P$SWI     rmb   2          SWI Entry Point
P$SWI2    rmb   2          SWI2 Entry Point
P$SWI3    rmb   2          SWI3 Entry Point $18
P$DIO     rmb   DefIOSiz   default I/O ptrs $1A
P$PATH    rmb   NumPaths   I/O path table $26
P$Signal  rmb   1          Signal Code $36
P$SigVec  rmb   2          Signal Intercept Vector
P$SigDat  rmb   2          Signal Intercept Data Address
P$NIO     rmb   4          additional dio pointers for net
          rmb   $40-*      unused
P$Size    equ   *         Size of Process Descriptor
          endsect

*
* Process State Flags
*
SysState  equ   %10000000
TimSleep  equ   %01000000
TimOut    equ   %00100000
ImgChg    equ   %00010000
Condem    equ   %00000010
Dead      equ   %00000001

          ELSE

* Level 2 process descriptor defs
DefIOSiz  equ   16         Default I/O Data Length
NefIOSiz  equ   12         On-Net Default I/O Data Length
NumPaths  equ   16         Number of Local Paths

          csect 0
P$ID      rmb   1          Process ID
P$PID     rmb   1          Parent's ID
P$SID     rmb   1          Sibling's ID
P$CID     rmb   1          Child's ID
P$SP      rmb   2          Stack ptr
P$Task    rmb   1          Task Number
P$PagCnt  rmb   1          Memory Page Count
P$User    rmb   2          User Index
P$Prior   rmb   1          Priority
P$Age     rmb   1          Age
P$State   rmb   1          Status
P$Queue   rmb   2          Queue Link (Process ptr)
P$IOQP    rmb   1          Previous I/O Queue Link (Process ID)
P$IOQN    rmb   1          Next I/O Queue Link (Process ID)
P$PModul  rmb   2          Primary Module
P$SWI     rmb   2          SWI Entry Point
P$SWI2    rmb   2          SWI2 Entry Point
P$SWI3    rmb   2          SWI3 Entry Point
P$Signal  rmb   1          Signal Code
P$SigVec  rmb   2          Signal Intercept Vector
P$SigDat  rmb   2          Signal Intercept Data Address
P$DeadLk  rmb   1          Dominant proc ID if I/O locked
          rmb   $20-*      unused
P$DIO     rmb   DefIOSiz   Default I/O ptrs
P$Path    rmb   NumPaths   I/O Path Table
P$DATImg  rmb   64         DAT Image
P$Links   rmb   32         Block Link counts
P$NIO     rmb   6*2        additional DIO ptrs for net, compatible  with 68k
P$SelP    rmb   1          Selected Path for COCO Windows (Default 0)
P$UTicks  rmb   4          proc User Tick counter        (L2V3)
P$STicks  rmb   4          proc System Tick counter      (L2V3)
P$FCalls  rmb   4          proc F$ call counter          (L2V3)
P$ICalls  rmb   4          proc I$ call counter          (L2V3)
P$DatBeg  rmb   3          proc Date of creation (Y/M/D) (L2V3)
P$TimBeg  rmb   3          proc Time of creation (H/M/S) (L2V3)
P$Alarm   rmb   6
          rmb   $200-*     Local stack
P$Stack   equ   *          Top of Stack
P$Size    equ   *          Size of Process Descriptor
          endsect

*
* Process State Flags
*
SysState  equ   %10000000
TimSleep  equ   %01000000
TimOut    equ   %00100000
ImgChg    equ   %00010000
Suspend   equ   %00001000
Condem    equ   %00000010
Dead      equ   %00000001

          ENDC

          ttl   NitrOS-9 I/O Symbolic Definitions
          pag
*************************
* Path Descriptor Offsets
*
          csect 0
PD.PD     rmb   1          Path Number
PD.MOD    rmb   1          Mode (Read/Write/Update)
PD.CNT    rmb   1          Number of Open Images
PD.DEV    rmb   2          Device Table Entry Address
PD.CPR    rmb   1          Current Process
PD.RGS    rmb   2          Caller's Register Stack
PD.BUF    rmb   2          Buffer Address
PD.FST    rmb   32-*       File Manager's Storage
PD.OPT    equ   *          PD GetSts(0) Options
PD.DTP    rmb   1          Device Type
          rmb   64-*       Path options
PDSIZE    equ   *
          endsect

*
* Pathlist Special Symbols
*
PDELIM    equ   '/         Pathlist Name Separator
PDIR      equ   '.         Directory
PENTIR    equ   '@         Entire Device

          pag  
****************************
* File Manager Entry Offsets
*
          csect 0
FMCREA    rmb   3          Create (Open New) File
FMOPEN    rmb   3          Open File
FMMDIR    rmb   3          Make Directory
FMCDIR    rmb   3          Change Directory
FMDLET    rmb   3          Delete File
FMSEEK    rmb   3          Position File
FMREAD    rmb   3          Read from File
FMWRIT    rmb   3          Write to File
FMRDLN    rmb   3          ReadLn
FMWRLN    rmb   3          WritLn
FMGSTA    rmb   3          Get File Status
FMSSTA    rmb   3          Set File Status
FMCLOS    rmb   3          Close File
          endsect

*****************************
* Device Driver Entry Offsets
*
          csect 0
D$INIT    rmb   3          Device Initialization
D$READ    rmb   3          Read from Device
D$WRIT    rmb   3          Write to Device
D$GSTA    rmb   3          Get Device Status
D$PSTA    rmb   3          Put Device Status
D$TERM    rmb   3          Device Termination
          endsect

*********************
* Device Table Format
*
          csect 0
V$DRIV    rmb   2          Device Driver module
V$STAT    rmb   2          Device Driver Static storage
V$DESC    rmb   2          Device Descriptor module
V$FMGR    rmb   2          File Manager module
V$USRS    rmb   1          use count
          IFGT  Level-1
V$DRIVEX  rmb   2          Device Driver execution address
V$FMGREX  rmb   2          File Manager execution address
          ENDC
DEVSIZ    equ   *
          endsect

*******************************
* Device Static Storage Offsets
*
          csect 0
V.PAGE    rmb   1          Port Extended Address
V.PORT    rmb   2          Device 'Base' Port Address
V.LPRC    rmb   1          Last Active Process ID
V.BUSY    rmb   1          Active Process ID (0=UnBusy)
V.WAKE    rmb   1          Active PD if Driver MUST Wake-up
V.USER    equ   *          Driver Allocation Origin
          endsect

********************************
* Interrupt Polling Table Format
*
          csect 0
Q$POLL    rmb   2          Absolute Polling Address
Q$FLIP    rmb   1          Flip (EOR) Byte ..normally Zero
Q$MASK    rmb   1          Polling Mask (after Flip)
Q$SERV    rmb   2          Absolute Service routine Address
Q$STAT    rmb   2          Static Storage Address
Q$PRTY    rmb   1          Priority (Low Numbers=Top Priority)
          IFGT  Level-1
Q$MAP     rmb   2          NitrOS-9 Level 2 and above
          ENDC
POLSIZ    equ   *
          endsect

********************
* VIRQ packet format
*
          csect 0
Vi.Cnt    rmb   2          count down counter
Vi.Rst    rmb   2          reset value for counter
Vi.Stat   rmb   1          status byte
          endsect

Vi.IFlag  equ   %00000001  status byte virq flag

          pag  
*************************************
* Machine Characteristics Definitions
*
R$CC      equ   0          Condition Codes register
R$A       equ   1          A Accumulator
R$B       equ   2          B Accumulator
R$D       equ   R$A        Combined A B Accumulator
          IFNE  H6309
R$E       equ   3          E Accumulator
R$F       equ   4          F Accumulator
R$W       equ   R$E        Combined E F Accumulator
R$Q       equ   R$A        Combined A B E F Accumulator
R$DP      equ   5          Direct Page register
R$X       equ   6          X Index register
R$Y       equ   8          Y Index register
R$U       equ   10         User Stack register
R$PC      equ   12         Program Counter register
R$Size    equ   14         Total register package size
          ELSE
R$DP      equ   3          Direct Page register
R$X       equ   4          X Index register
R$Y       equ   6          Y Index register
R$U       equ   8          User Stack register
R$PC      equ   10         Program Counter register
R$Size    equ   12         Total register package size
          ENDC

* MD register masks
* 6309 definitions
DIV0      equ   %10000000  division by 0 trap flag         1 = trap occured
badinstr  equ   %01000000  illegal instruction trap flag   1 = trap occured

Entire    equ   %10000000  Full Register Stack flag
FIRQMask  equ   %01000000  Fast-Interrupt Mask bit
HalfCrry  equ   %00100000  Half Carry flag
IRQMask   equ   %00010000  Interrupt Mask bit
Negative  equ   %00001000  Negative flag
Zero      equ   %00000100  Zero flag
TwosOvfl  equ   %00000010  Two's Comp Overflow flag
Carry     equ   %00000001  Carry bit
IntMasks  equ   IRQMask+FIRQMask
Sign      equ   %10000000  sign bit

          ttl   Error Code Definitions
          pag
************************
* Error Code Definitions
*
* Basic09 Error Codes
*
          csect 10
E$UnkSym  rmb   1 Unknown symbol
E$ExcVrb  rmb   1 Excessive verbage
E$IllStC  rmb   1 Illegal statement construction
E$ICOvf   rmb   1 I-code overflow
E$IChRef  rmb   1 Illegal channel reference
E$IllMod  rmb   1 Illegal mode
E$IllNum  rmb   1 Illegal number
E$IllPrf  rmb   1 Illegal prefix
E$IllOpd  rmb   1 Illegal operand
E$IllOpr  rmb   1 Illegal operator
E$IllRFN  rmb   1 Illegal record field name
E$IllDim  rmb   1 Illegal dimension
E$IllLit  rmb   1 Illegal literal
E$IllRet  rmb   1 Illegal relational
E$IllSfx  rmb   1 Illegal type suffix
E$DimLrg  rmb   1 Dimension too large
E$LinLrg  rmb   1 Line number too large
E$NoAssg  rmb   1 Missing assignment statement
E$NoPath  rmb   1 Missing path number
E$NoComa  rmb   1 Missing coma
E$NoDim   rmb   1 Missing dimension
E$NoDO    rmb   1 Missing DO statement
E$MFull   rmb   1 Memory full
E$NoGoto  rmb   1 Missing GOTO
E$NoLPar  rmb   1 Missing left parenthesis
E$NoLRef  rmb   1 Missing line reference
E$NoOprd  rmb   1 Missing operand
E$NoRPar  rmb   1 Missing right parenthesis
E$NoTHEN  rmb   1 Missing THEN statement
E$NoTO    rmb   1 Missing TO statement
E$NoVRef  rmb   1 Missing variable reference
E$EndQou  rmb   1 Missing end quote
E$SubLrg  rmb   1 Too many subscripts
E$UnkPrc  rmb   1 Unknown procedure
E$MulPrc  rmb   1 Multiply defined procedure
E$DivZer  rmb   1 Divice by zero
E$TypMis  rmb   1 Operand type mismatch
E$StrOvf  rmb   1 String stack overflow
E$NoRout  rmb   1 Unimplemented routine
E$UndVar  rmb   1 Undefined variable
E$FltOvf  rmb   1 Floating Overflow
E$LnComp  rmb   1 Line with compiler error
E$ValRng  rmb   1 Value out of range for destination
E$SubOvf  rmb   1 Subroutine stack overflow
E$SubUnd  rmb   1 Subroutine stack underflow
E$SubRng  rmb   1 Subscript out of range
E$ParmEr  rmb   1 Paraemter error
E$SysOvf  rmb   1 System stack overflow
E$IOMism  rmb   1 I/O type mismatch
E$IONum   rmb   1 I/O numeric input format bad
E$IOConv  rmb   1 I/O conversion  number out of range
E$IllInp  rmb   1 Illegal input format
E$IOFRpt  rmb   1 I/O format repeat error
E$IOFSyn  rmb   1 I/O format syntax error
E$IllPNm  rmb   1 Illegal path number
E$WrSub   rmb   1 Wrong number of subscripts
E$NonRcO  rmb   1 Non-record type operand
E$IllA    rmb   1 Illegal argument
E$IllCnt  rmb   1 Illegal control structure
E$UnmCnt  rmb   1 Unmatched control structure
E$IllFOR  rmb   1 Illegal FOR variable
E$IllExp  rmb   1 Illegal expression type
E$IllDec  rmb   1 Illegal declarative statement
E$ArrOvf  rmb   1 Array size overflow
E$UndLin  rmb   1 Undefined line number
E$MltLin  rmb   1 Multiply defined line number
E$MltVar  rmb   1 Multiply defined variable
E$IllIVr  rmb   1 Illegal input variable
E$SeekRg  rmb   1 Seek out of range
E$NoData  rmb   1 Missing data statement
          endsect

*
* System Dependent Error Codes
*

* Level 2 windowing error codes
          csect 183
E$IWTyp   rmb   1          Illegal window type
E$WADef   rmb   1          Window already defined
E$NFont   rmb   1          Font not found
E$StkOvf  rmb   1          Stack overflow
E$IllArg  rmb   1          Illegal argument
          rmb   1          reserved
E$ICoord  rmb   1          Illegal coordinates
E$Bug     rmb   1          Bug (should never be returned)
E$BufSiz  rmb   1          Buffer size is too small
E$IllCmd  rmb   1          Illegal command
E$TblFul  rmb   1          Screen or window table is full
E$BadBuf  rmb   1          Bad/Undefined buffer number
E$IWDef   rmb   1          Illegal window definition
E$WUndef  rmb   1          Window undefined

E$Up      rmb   1          Up arrow pressed on SCF I$ReadLn with PD.UP enabled
E$Dn      rmb   1          Down arrow pressed on SCF I$ReadLn with PD.DOWN enabled
E$Alias   rmb   1
          endsect


*
* Standard NitrOS-9 Error Codes
*
          csect 200
E$PthFul  rmb   1          Path Table full
E$BPNum   rmb   1          Bad Path Number
E$Poll    rmb   1          Polling Table Full
E$BMode   rmb   1          Bad Mode
E$DevOvf  rmb   1          Device Table Overflow
E$BMID    rmb   1          Bad Module ID
E$DirFul  rmb   1          Module Directory Full
E$MemFul  rmb   1          Process Memory Full
E$UnkSvc  rmb   1          Unknown Service Code
E$ModBsy  rmb   1          Module Busy
E$BPAddr  rmb   1          Bad Page Address
E$EOF     rmb   1          End of File
          rmb   1
E$NES     rmb   1          Non-Existing Segment
E$FNA     rmb   1          File Not Accesible
E$BPNam   rmb   1          Bad Path Name
E$PNNF    rmb   1          Path Name Not Found
E$SLF     rmb   1          Segment List Full
E$CEF     rmb   1          Creating Existing File
E$IBA     rmb   1          Illegal Block Address
E$HangUp  rmb   1          Carrier Detect Lost
E$MNF     rmb   1          Module Not Found
          rmb   1
E$DelSP   rmb   1          Deleting Stack Pointer memory
E$IPrcID  rmb   1          Illegal Process ID
E$BPrcID  equ   E$IPrcID   Bad Process ID (formerly #238)
          rmb   1
E$NoChld  rmb   1          No Children
E$ISWI    rmb   1          Illegal SWI code
E$PrcAbt  rmb   1          Process Aborted
E$PrcFul  rmb   1          Process Table Full
E$IForkP  rmb   1          Illegal Fork Parameter
E$KwnMod  rmb   1          Known Module
E$BMCRC   rmb   1          Bad Module CRC
E$USigP   rmb   1          Unprocessed Signal Pending
E$NEMod   rmb   1          Non Existing Module
E$BNam    rmb   1          Bad Name
E$BMHP    rmb   1          (bad module header parity)
E$NoRAM   rmb   1          No (System) RAM Available
E$DNE     rmb   1          Directory not empty
E$NoTask  rmb   1          No available Task number
          rmb   $F0-*      reserved
E$Unit    rmb   1          Illegal Unit (drive)
E$Sect    rmb   1          Bad Sector number
E$WP      rmb   1          Write Protect
E$CRC     rmb   1          Bad Check Sum
E$Read    rmb   1          Read Error
E$Write   rmb   1          Write Error
E$NotRdy  rmb   1          Device Not Ready
E$Seek    rmb   1          Seek Error
E$Full    rmb   1          Media Full
E$BTyp    rmb   1          Bad Type (incompatable) media
E$DevBsy  rmb   1          Device Busy
E$DIDC    rmb   1          Disk ID Change
E$Lock    rmb   1          Record is busy (locked out)
E$Share   rmb   1          Non-sharable file busy
E$DeadLk  rmb   1          I/O Deadlock error
          endsect


          IFEQ  Level-1

********************************
* Boot defs for NitrOS-9 Level 1
*
* These defs are not strictly for 'Boot', but are for booting the
* system.
*
Bt.Start  equ   $EE00      Start address of the boot track in memory
Bt.Size   equ   $1080      Maximum size of bootfile

          ELSE

******************************************
* Boot defs for NitrOS-9 Level 2 and above
*
* These defs are not strictly for 'Boot', but are for booting the
* system.
*
Bt.Block  equ   $3B        Block to map in for the 'OS9BOOT' screen
Bt.Flag   equ   $8A34      Flag in Bt.Block to verify that it's unchanged
Bt.Offst  equ   2          Offset into the screen where the current ptr is
Bt.Start  equ   $ED00      Start address of the boot track in memory

          ENDC

Bt.Track  equ   34         Boot track


          IFGT  Level-2
***************************
* Level 3 Defs
*
* These definitions apply to NitrOS-9 Level 3
*
L3.Start  equ   $2000      Start off at slot 1
L3.Size   equ   $40        Go for 64 pages  2 slots total
L3.Blks   equ   L3.Size/$20 Number of slots
L3.End    equ   L3.Start+L3.Size*$0100 end of L3 memory
L3.SCF    equ   $0660      SCF block ptr
L3.RBF    equ   L3.SCF+1   RBF block ptr
          ENDC







********************************************************************
* SCFDefs - Sequential Character File Manager Definitions
*
* $Id  os9defs.a,v 1.1 2005/07/27 01 15 41 boisy Exp $
*
* SCF stands for 'Sequential Character Filemanager' and is a package of subroutines
* that define the logical structure of a serial device.
*
* The data structures in this file give SCF its 'personality' and are used
* by SCF itself, as well as applications that will require disk I/O.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          1984/01/11  YO
* Added V.KANJI, V.KBUF, V.MODADR for new kanji input process.
*
*          1985/04/20  Mark G. Hawkins
* Added V.PDLHd Path Descriptor List Head.
*
*          1985/04/21  Mark G. Hawkins
* Added PD.PLP and PD.PST for modem handling.
*
*          1987/06/23  Kevin K. Darling
* Updated with Dev Desc info.
*
*          1998/10/03  Boisy G. Pitre
* Consolidated L1/L2 scfdefs.
*
*          2003/01/21  Boisy G. Pitre
* Added symbolics for enhanced SCF line editing.
*
*          2003/06/02  Boisy G. Pitre
* Updated comments for clarity.
*
*          2004/05/17  Boisy G. Pitre
* Added higher baud rates.

          nam   SCFDefs
          ttl   Sequential File Manager Definitions

          pag
*******************************
* SCF Device Descriptor Offsets
*
* These definitions are for SCF device descriptors.

          csect    M$DTyp
IT.DVC    rmb   1          Device type (DT.SCF)
IT.UPC    rmb   1          Uppercase flag
IT.BSO    rmb   1          Backspace behavior
IT.DLO    rmb   1          Delete behavior
IT.EKO    rmb   1          Echo flag
IT.ALF    rmb   1          Auto linefeed flag
IT.NUL    rmb   1          End-of-line null count
IT.PAU    rmb   1          Page pause flag
IT.PAG    rmb   1          Number of lines per page
IT.BSP    rmb   1          Backspace character
IT.DEL    rmb   1          Delete-line character
IT.EOR    rmb   1          End-of-record character
IT.EOF    rmb   1          End-of-file character
IT.RPR    rmb   1          Reprint-line character
IT.DUP    rmb   1          Duplicate-last-line character
IT.PSC    rmb   1          Pause character
IT.INT    rmb   1          Interrupt character
IT.QUT    rmb   1          Quit character
IT.BSE    rmb   1          Backspace echo character
IT.OVF    rmb   1          Bell character
IT.PAR    rmb   1          Parity
IT.BAU    rmb   1          Baud rate
IT.D2P    rmb   2          Attached device name string offset
IT.XON    rmb   1          X-ON character
IT.XOFF   rmb   1          X-OFF character
IT.COL    rmb   1          Number of columns for display
IT.ROW    rmb   1          Number of rows for display
IT.XTYP   rmb   1          Extended type (added by BRI)
          endsect

          IFGT  Level-1
* Window Descriptor Additions
* For CoCo window, where IT.PAR = $80
          csect IT.ROW+1
IT.WND    rmb   1          Window number (matches device name) ($2E)
IT.VAL    rmb   1          Use defaults on Init (0=no, 1=yes)
IT.STY    rmb   1          Screen type default
IT.CPX    rmb   1          Column start default
IT.CPY    rmb   1          Row start default
IT.FGC    rmb   1          Foreground color default
IT.BGC    rmb   1          Background color default
IT.BDC    rmb   1          Border color default
          endsect
          ENDC


          pag
********************
* SCF Static Storage
*
* SCF devices must reserve this space for SCF
*
          csect V.USER
V.TYPE    rmb   1          Device type or parity
V.LINE    rmb   1          Lines left until end of page
V.PAUS    rmb   1          Immediate Pause request
V.DEV2    rmb   2          Attached device's static
V.INTR    rmb   1          Interrupt char
V.QUIT    rmb   1          Quit char
V.PCHR    rmb   1          Pause char
V.ERR     rmb   1          Accumulated errors
V.XON     rmb   1          X-On char
V.XOFF    rmb   1          X-Off char
V.KANJI   rmb   1          Kanji mode flag
V.KBUF    rmb   2          Kana - Kanji convert routine work address
V.MODADR  rmb   2          Kana - Kanji convert module address
V.PDLHd   rmb   2          Open path descriptor list head pointer
V.RSV     rmb   5          Reserve bytes for future expansion
V.SCF     equ   *          Total SCF manager static overhead
          endsect


          pag
***********************
* Character Definitions
*
C$NULL    set   0          Null char
C$RPET    set   $01        (CTRL-A - SOH) Repeat last input line
C$INTR    set   $03        (CTRL-C - ETX) Keyboard interrupt
C$RPRT    set   $04        (CTRL-D - EOT) Reprint current input line
C$QUIT    set   $05        (CTRL-E - ENQ) Keyboard Abort
C$BELL    set   $07        (CTRL-G - BEL) Line overflow warning
C$BSP     set   $08        (CTRL-H - BS ) Back space
C$RARR    set   $09        Right Arrow
C$EL      set   $05        Erase Line
C$LF      set   $0A        Line feed
C$HOME    set   $0B        Home position Code
C$Clsgr   set   $15        Graphic screen clear (use FM-11)
C$Clsall  set   $16        Graphic & character clear (use FM-11)
C$CR      set   $0D        Carriage return
C$FORM    set   $0C        (CTRL-L - FF ) Form Feed ... screen clear
C$SI      set   $0F        Shift IN Code
C$SO      set   $0E        Shift OUT Code
C$DELETE  set   $10        Delete char (for SCF enhanced line editing)
C$XON     set   $11        (CTRL-Q - DC1) Transmit Enable
C$INSERT  set   C$XON      Insert char (for SCF enhanced line editing)
C$XOFF    set   $13        (CTRL-S - DC3) Transmit Disable
C$PLINE   set   C$XOFF     Print remaining line (for SCF enhanced line editing)
C$PAUS    set   $17        (CTRL-W - ETB) Pause character
C$DEL     set   $18        (CTRL-X - CAN) Delete line
C$SHRARR  set   $19        Shift Right-Arrow
C$EOF     set   $1B        (CTRL-[ - ESC) END of file
C$RGT     set   $1C        Cursor right
C$LFT     set   $1D        Cursor left
C$UP      set   $1E        Cursor up
C$DWN     set   $1F        Cursor down
C$SPAC    set   $20        Space
C$PERD    set   '.
C$COMA    set   ',


          pag
*********************************************
* Sequential Character Path Descriptor Format
*
* A path descriptor is created for every new path that is open
* via the I$Open system call (processed by IOMan).  Process
* descriptors track state information of a path.
*
          csect PD.FST
PD.DV2    rmb   2          Output device table pointer
PD.RAW    rmb   1          Read/Write or ReadLn/WritLn mode
PD.MAX    rmb   2          ReadLn high byte count
PD.MIN    rmb   1          Devices are "mine" if clear
PD.STS    rmb   2          Status routine module addr
PD.STM    rmb   2          Reserved for status routine
          endsect

          csect PD.OPT
          rmb   1          Device type
PD.UPC    rmb   1          Case (0=both, 1=upper only)
PD.BSO    rmb   1          Backspace (0=BSE, 1=BSE,SP,BSE)
PD.DLO    rmb   1          Delete (0=BSE over line, 1=CRLF)
PD.EKO    rmb   1          Echo (0=No Echo)
PD.ALF    rmb   1          Auto linefeed (0=No auto LF)
PD.NUL    rmb   1          End of Line null count
PD.PAU    rmb   1          Page pause (0=No end of page pause)
PD.PAG    rmb   1          Lines per page
PD.BSP    rmb   1          Backspace character
PD.DEL    rmb   1          Delete Line character
PD.EOR    rmb   1          End of Record character (read only)
PD.EOF    rmb   1          End of File character
PD.RPR    rmb   1          Repront Line character
PD.DUP    rmb   1          Dup Last Line character
PD.PSC    rmb   1          Pause character
PD.INT    rmb   1          Keyboard interrupt character (CTRL-C)
PD.QUT    rmb   1          Keyboard quit character (CTRL-E)
PD.BSE    rmb   1          Backspace echo character
PD.OVF    rmb   1          Line overflow character (BELL)
PD.PAR    rmb   1          Parity code
PD.BAU    rmb   1          ACIA baud rate (Color Computer)
PD.D2P    rmb   2          Offset of DEV2 name
PD.XON    rmb   1          ACIA X-ON character
PD.XOFF   rmb   1          ACIA X-OFF character
OPTCNT    equ   *-PD.OPT   Total user settable options
PD.ERR    rmb   1          Most recent I/O error status
PD.TBL    rmb   2          Device table addr (copy)
PD.PLP    rmb   2          Path Descriptor List Pointer
PD.PST    rmb   1          Current path status
          endsect


* PD.PST values Path Descriptor Status byte
*
PST.DCD   equ   %00000001  Set if DCD is lost on Serial port


* PD.PAR definitions
*
* Parity
PARNONE   equ   %00000000
PARODD    equ   %00100000
PAREVEN   equ   %01100000
PARMARK   equ   %10100000
PARSPACE  equ   %11100000

* PD.BAU definitions
*
* Baud rate
B110      equ   %00000000
B300      equ   %00000001
B600      equ   %00000010
B1200     equ   %00000011
B2400     equ   %00000100
B4800     equ   %00000101
B9600     equ   %00000110
B19200    equ   %00000111
B38400    equ   %00001000
B57600    equ   %00001001
B115200   equ   %00001010
* Word size
WORD8     equ   %00000000
WORD7     equ   %00100000
* Stop bits
STOP1     equ   %00000000
STOP2     equ   %00010000

          endsect
