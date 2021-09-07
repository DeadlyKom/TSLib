
                ifndef _MEMORY_MACRO_
                define _MEMORY_MACRO_
; -----------------------------------------
; initialization of mapping of registers in 0x400-0x4FF 
; if the preprocessing directive MAPPING_REGISTERS is enabled
; In :
; Out :
; Corrupt :
; Note:
; -----------------------------------------
FMapAddrInit    macro
                ifdef MAPPING_REGISTERS
                SeFMAddr FM_EN
                endif
                SeMemConfig MEM_WO_RAM | MEM_WO_MAP | MEM_WO_WE
                SetPage0 TSLibPage
                endm
; -----------------------------------------
; set values to memory configuration register
; In :
;   Value? - memory config values
; Out :
; Corrupt :
;   BC, A
; Note:
; -----------------------------------------
SeMemConfig     macro Value?
                LD A, Value?
                LD BC, MEMCONFIG
                OUT (C), A
                endm
; -----------------------------------------
; set values in port FMaps Address
; In :
;   Value? - config values
; Out :
; Corrupt :
;   BC, A
; Note:
; -----------------------------------------
SeFMAddr        macro Value?
                LD A, Value?
                LD BC, FMADDR
                OUT (C), A
                endm
; -----------------------------------------
; set the page number from the address #0000 - #3FFF
; In :
;   Page? - page number
; Out :
; Corrupt :
;   HL / (BC, A)
; Note:
; -----------------------------------------
SetPage0        macro Page?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH PAGE0
                LD (HL), Page? & 0xFF
                else
                LD A, Page? & 0xFF
                LD (MemoryPages + 0), A
                LD BC, PAGE0
                OUT (C), A
                endif
                endm
; -----------------------------------------
; set the page number from the address #0000 - #3FFF
; In :
;   A - page number
; Out :
; Corrupt :
;   .. / (BC)
; Note:
; -----------------------------------------
SetPage0_A      macro
                ifdef MAPPING_REGISTERS
                LD (FMADDR_REGS + HIGH PAGE0), A
                else
                LD (MemoryPages + 0), A
                LD BC, PAGE0
                OUT (C), A
                endif
                endm
; -----------------------------------------
; set the page number from the address #4000 - #7FFF
; In :
;   Page? - page number
; Out :
; Corrupt :
;   HL / (BC, A)
; Note:
; -----------------------------------------
SetPage1        macro Page?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH PAGE1
                LD (HL), Page? & 0xFF
                else
                LD A, Page? & 0xFF
                LD (MemoryPages + 1), A
                LD BC, PAGE1
                OUT (C), A
                endif
                endm
; -----------------------------------------
; set the page number from the address #4000 - #7FFF
; In :
;   A - page number
; Out :
; Corrupt :
;   .. / (BC)
; Note:
; -----------------------------------------
SetPage1_A      macro
                ifdef MAPPING_REGISTERS
                LD (FMADDR_REGS + HIGH PAGE1), A
                else
                LD (MemoryPages + 1), A
                LD BC, PAGE1
                OUT (C), A
                endif
                endm
; -----------------------------------------
; set the page number from the address #8000 - #BFFF
; In :
;   Page? - page number
; Out :
; Corrupt :
;   HL / (BC, A)
; Note:
; -----------------------------------------
SetPage2        macro Page?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH PAGE2
                LD (HL), Page? & 0xFF
                else
                LD A, Page? & 0xFF
                LD (MemoryPages + 2), A
                LD BC, PAGE2
                OUT (C), A
                endif
                endm
; -----------------------------------------
; set the page number from the address #8000 - #BFFF
; In :
;   A - page number
; Out :
; Corrupt :
;   .. / (BC)
; Note:
; -----------------------------------------
SetPage2_A      macro
                ifdef MAPPING_REGISTERS
                LD (FMADDR_REGS + HIGH PAGE2), A
                else
                LD (MemoryPages + 2), A
                LD BC, PAGE2
                OUT (C), A
                endif
                endm
; -----------------------------------------
; set the page number from the address #C000 - #FFFF
; In :
;   Page? - page number
; Out :
; Corrupt :
;   HL / (BC, A)
; Note:
; -----------------------------------------
SetPage3        macro Page?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH PAGE3
                LD (HL), Page? & 0xFF
                else
                LD A, Page? & 0xFF
                LD (MemoryPages + 3), A
                LD BC, PAGE3
                OUT (C), A
                endif
                endm
; -----------------------------------------
; set the page number from the address #C000 - #FFFF
; In :
;   A - page number
; Out :
; Corrupt :
;   .. / (BC)
; Note:
; -----------------------------------------
SetPage3_A      macro
                ifdef MAPPING_REGISTERS
                LD (FMADDR_REGS + HIGH PAGE3), A
                else
                LD (MemoryPages + 3), A
                LD BC, PAGE3
                OUT (C), A
                endif
                endm
; -----------------------------------------
; get the page number from the address #C000 - #FFFF
; In :
; Out :
;   A - page number
; Corrupt :
;   A
; Note:
; -----------------------------------------
GetPage3:       macro
                ifdef MAPPING_REGISTERS
                LD A, (FMADDR_REGS + HIGH PAGE3)
                else
                LD A, (MemoryPages + 3)
                endif
                endm

                endif ; ~_MEMORY_MACRO_
