;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; sysglobs
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/05/17  Boisy G. Pitre
; Started.

           .title System Globals

           .area  SYSGLOBS (ABS)


           .if    Level=1
; Level 1 DP vars
           .org   0
D.WDAddr:: .rmb   2          ; FHL/Isted WD1002-05 interface base address
D.WDBtDr:: .rmb   1          ; FHL/Isted WD1002-05 boot physical device drive num.
           .rmb   5
D.COCOXT:: .rmb   1          ; Busy flag for CoCo-XT driver (one drive at a time)

	   .org   0h20
D.FMBM::   .rmb   4          ; Free memory bit map pointers
D.MLIM::   .rmb   2          ; Memory limit $24
D.ModDir:: .rmb   4          ; Module directory $26
D.Init::   .rmb   2          ; Rom base address $2A
D.SWI3::   .rmb   2          ; Swi3 vector $2C
D.SWI2::   .rmb   2          ; Swi2 vector $2E
D.FIRQ::   .rmb   2          ; Firq vector $30
D.IRQ::    .rmb   2          ; Irq vector $32
D.SWI::    .rmb   2          ; Swi vector $34
D.NMI::    .rmb   2          ; Nmi vector $36
D.SvcIRQ:: .rmb   2          ; Interrupt service entry $38
D.Poll::   .rmb   2          ; Interrupt polling routine $3A
D.UsrIRQ:: .rmb   2          ; User irq routine $3C
D.SysIRQ:: .rmb   2          ; System irq routine $3E
D.UsrSvc:: .rmb   2          ; User service request routine $40
D.SysSvc:: .rmb   2          ; System service request routine $42
D.UsrDis:: .rmb   2          ; User service request dispatch table
D.SysDis:: .rmb   2          ; System service reuest dispatch table
D.Slice::  .rmb   1          ; Process time slice count $48
D.PrcDBT:: .rmb   2          ; Process descriptor block address  $49
D.Proc::   .rmb   2          ; Process descriptor address $4B
D.AProcQ:: .rmb   2          ; Active process queue $4D
D.WProcQ:: .rmb   2          ; Waiting process queue $4F
D.SProcQ:: .rmb   2          ; Sleeping process queue $51
D.Time::   .equ   .          ; Time
D.Year::   .rmb   1          ; $53
D.Month::  .rmb   1          ; $54
D.Day::    .rmb   1          ; $55
D.Hour::   .rmb   1          ; $56
D.Min::    .rmb   1          ; $57
D.Sec::    .rmb   1          ; $58
D.Tick::   .rmb   1          ; $59
D.TSec::   .rmb   1          ; Ticks / second $5A
D.TSlice:: .rmb   1          ; Ticks / time-slice $5B
D.IOML::   .rmb   2          ; I/O mgr free memory low bound $5C
D.IOMH::   .rmb   2          ; I/O mgr free memory hi  bound $5E
D.DevTbl:: .rmb   2          ; Device driver table addr $60
D.PolTbl:: .rmb   2          ; Irq polling table addr $62
D.PthDBT:: .rmb   2          ; Path descriptor block table addr $64
D.BTLO::   .rmb   2          ; Bootstrap low address $66
D.BTHI::   .rmb   2          ; Bootstrap hi address $68
D.DMAReq:: .rmb   1          ; DMA in use flag $6A
D.AltIRQ:: .rmb   2          ; Alternate IRQ vector (CC) $6B
D.KbdSta:: .rmb   2          ; Keyboard scanner static storage (CC) $6D
D.DskTmr:: .rmb   2          ; Disk Motor Timer (CC) $6F
D.CBStrt:: .rmb   16         ; reserved for CC warmstart ($71)
D.Clock::  .rmb   2          ; Address of Clock Tick Routine (CC) $81
D.Boot::   .rmb   1          ; Bootstrap attempted flag
D.URtoSs:: .rmb   2          ; address of user to system routine (VIRQ) $84
D.CLTb::   .rmb   2          ; Pointer to clock interrupt table (VIRQ) $86
D.MDREG::  .rmb   1          ; 6309 MD (mode) shadow register $88 (added in V2.01.00)
D.CRC::    .rmb   1          ; CRC checking mode flag $89 (added in V2.01.00)
D.Clock2:: .rmb   2          ; CC Clock2 entry address

           .org   0h100
D.XSWI3::  .rmb   3
D.XSWI2::  .rmb   3
D.XSWI::   .rmb   3
D.XNMI::   .rmb   3
D.XIRQ::   .rmb   3
D.XFIRQ::  .rmb   3

; Table Sizes
BMAPSZ     ==     32         ; Bitmap table size
SVCTNM     ==     2          ; Number of service request tables
SVCTSZ     ==     (256-BMAPSZ)/SVCTNM-2 ; Service request table size

           .else

; Level 2 DP vars
           .org   0
D.WDAddr:: .rmb   2          ; FHL/Isted WD1002-05 interface base address
D.WDBtDr:: .rmb   1          ; FHL/Isted WD1002-05 boot physical device drive num.
           .rmb   5
D.COCOXT:: .rmb   1          ; Busy flag for CoCo-XT driver (one drive at a time)

	   .org   0h20
D.Tasks::  .rmb   2          ; Task User Table
D.TmpDAT:: .rmb   2          ; Temporary DAT Image stack
D.Init::   .rmb   2          ; Initialization Module ptr
D.Poll::   .rmb   2          ; Interrupt Polling Routine ptr
D.Time     ==     .          ; System Time
D.Year::   .rmb   1
D.Month::  .rmb   1
D.Day::    .rmb   1
D.Hour::   .rmb   1
D.Min::    .rmb   1
D.Sec::    .rmb   1
D.Tick::   .rmb   1
D.Slice::  .rmb   1          ; current slice remaining
D.TSlice:: .rmb   1          ; Ticks per Slice
D.Boot::   .rmb   1          ; Bootstrap attempted flag
D.MotOn::  .rmb   1          ; Floppy Disk Motor-On time out
D.ErrCod:: .rmb   1          ; Reset Error Code
D.Daywk::  .rmb   1          ; day of week, com-trol clock
D.TkCnt::  .rmb   1          ; Tick Counter
D.BtPtr::  .rmb   2          ; Address of Boot in System Address space
D.BtSz::   .rmb   2          ; Size of Boot
           .ifdef H6309
D.MDREG::  .rmb   1          ; 6309 MD (mode) shadow register
           .else
           .rmb   1          ; Currently unused in NitrOS-9/6809
           .endif
D.CRC::    .rmb   1          ; CRC checking mode flag
D.Tenths:: .rmb   1          ; Tenths and hundredths of second for F$Xtime
D.Task1N:: .rmb   1          ; Map type 1 task number*2 - offset into [D.TskIPt]
D.Quick::  .rmb   1          ; Quick system call return flag - 0 =stack is at $FEE1
D.QIRQ::   .rmb   1          ; Quick IRQ flag - 0 =IRQ wasn't clock, so quick return

           .org   0h40
D.BlkMap:: .rmb   4          ; Memory Block Map ptr
D.ModDir:: .rmb   4          ; Module Directory ptrs
D.PrcDBT:: .rmb   2          ; Process Descriptor Block Table ptr
D.SysPrc:: .rmb   2          ; System Process Descriptor ptr
D.SysDAT:: .rmb   2          ; System DAT Image ptr
D.SysMem:: .rmb   2          ; System Memory Map ptr
D.Proc::   .rmb   2          ; Current Process ptr
D.AProcQ:: .rmb   2          ; Active Process Queue
D.WProcQ:: .rmb   2          ; Waiting Process Queue
D.SProcQ:: .rmb   2          ; Sleeping Process Queue
D.ModEnd:: .rmb   2          ; Module Directory end ptr
D.ModDAT:: .rmb   2          ; Module Dir DAT image end ptr
D.CldRes:: .rmb   2          ; Cold Restart vector
D.BtBug::  .rmb   3          ; Boot debug information
D.Pipe::   .rmb   2

           .org   0h6B
D.Crash::  .rmb   6          ; Pointer to CC Crash Routine
D.CBStrt:: .rmb   0hB        ; Reserved for CC warmstart ($71)
D.QCnt::   .rmb   1          ; Count of number of quick system calls performed

           .org   0h80
D.DevTbl:: .rmb   2          ; I/O Device Table
D.PolTbl:: .rmb   2          ; I/O Polling Table
           .rmb   4          ; reserved
D.PthDBT:: .rmb   2          ; Path Descriptor Block Table ptr
D.DMAReq:: .rmb   1          ; DMA Request flag

; CoCo 3 STUFF COMES NEXT
; This area is used for the CoCo Hardware Registers
;
           .org   0h90
D.HINIT::  .rmb   1          ; GIME INIT0 register (hardware setup $FF90)
D.TINIT::  .rmb   1          ; GIME INIT1 register (timer/task register $FF91)
D.IRQER::  .rmb   1          ; Interrupt enable regsiter ($FF92)
D.FRQER::  .rmb   1          ; Fast Interrupt enable register ($FF93)
D.TIMMS::  .rmb   1          ; Timer most significant nibble ($FF94)
D.TIMLS::  .rmb   1          ; Timer least significant byte ($FF95)
D.RESV1::  .rmb   1          ; reserved register ($FF96)
D.RESV2::  .rmb   1          ; reserved register ($FF97)
D.VIDMD::  .rmb   1          ; video mode register ($FF98)
D.VIDRS::  .rmb   1          ; video resolution register ($FF99)
D.BORDR::  .rmb   1          ; border register ($FF9A)
D.RESV3::  .rmb   1          ; reserved register ($FF9B)
D.VOFF2::  .rmb   1          ; vertical scroll/offset 2 register ($FF9C)
D.VOFF1::  .rmb   1          ; vertical offset 1 register ($FF9D)
D.VOFF0::  .rmb   1          ; vertical offset 0 register ($FF9E)
D.HOFF0::  .rmb   1          ; horizontal offset 0 register ($FF9F)
D.Speed::  .rmb   1          ; Speed of COCO CPU 0=slow,1=fast ($A0)
D.TskIPt:: .rmb   2          ; Task image Pointer table (CC) ($A1)
D.MemSz::  .rmb   1          ; 128/512K memory flag (CC) ($A3)
D.SSTskN:: .rmb   1          ; System State Task Number (COCO) ($A4)
D.CCMem::  .rmb   2          ; Pointer to beginning of CC Memory ($A5)
D.CCStk::  .rmb   2          ; Pointer to top of CC Memory ($A7)
D.Flip0::  .rmb   2          ; Change to Task 0 ($A9)
D.Flip1::  .rmb   2          ; Change to reserved Task 1 ($AB)
D.VIRQ::   .rmb   2          ; VIRQ Polling routine ($AD)
D.IRQS::   .rmb   1          ; IRQ shadow register (CC Temporary) ($AF)
D.CLTb::   .rmb   2          ; VIRQ Table address ($B0)
D.AltIRQ:: .rmb   2          ; Alternate IRQ Vector (CC) ($B2)
D.GPoll::  .rmb   2          ; CC GIME IRQ enable/disable toggle
D.Clock2:: .rmb   2          ; CC Clock2 entry address
           .org   0hC0
D.SysSvc:: .rmb   2          ; System Service Routine entry
D.SysDis:: .rmb   2          ; System Service Dispatch Table ptr
D.SysIRQ:: .rmb   2          ; System IRQ Routine entry
D.UsrSvc:: .rmb   2          ; User Service Routine entry
D.UsrDis:: .rmb   2          ; User Service Dispatch Table ptr
D.UsrIRQ:: .rmb   2          ; User IRQ Routine entry
D.SysStk:: .rmb   2          ; System stack
D.SvcIRQ:: .rmb   2          ; In-System IRQ service
D.SysTsk:: .rmb   1          ; System Task number
           .org   0hE0
D.Clock::  .rmb   2
D.XSWI3::  .rmb   2
D.XSWI2::  .rmb   2
D.XFIRQ::  .rmb   2
D.XIRQ::   .rmb   2
D.XSWI::   .rmb   2
D.XNMI::   .rmb   2
D.ErrRst:: .rmb   2
D.SysVec:: .rmb   2          ; F$xxx system call vector for NitrOS-9 Level 3
D.SWI3::   .rmb   2
D.SWI2::   .rmb   2
D.FIRQ::   .rmb   2
D.IRQ::    .rmb   2
D.SWI::    .rmb   2
D.NMI::    .rmb   2

;
; Level 2 Block Map flags
;
NotRAM     ==     0b10000000  ; Block Not RAM flag
VidRAM     ==     0b00000100  ; Block is being used as Video RAM
ModBlock   ==     0b00000010  ; Module in Block
RAMinUse   ==     0b00000001  ; RAM Block in use flag

;
; Service Dispatch Table special entries
;
IOEntry    ==     254

           .endif
