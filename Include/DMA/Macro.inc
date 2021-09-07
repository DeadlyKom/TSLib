
                ifndef _DMA_MACRO_
                define _DMA_MACRO_
; -----------------------------------------
; setting source address DMA
; In :
;   SourcePage    - page (16Kb)
;   SourceAddress - offset in page
; Out :
; Corrupt :
;   HL / (HL, BC, F)
; Note:
; the address for DMA does not take into account the state of the two most significant bits of a 16-bit address
; -----------------------------------------
DMA_Src         macro SourcePage?, SourceAddress?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH DMASADDRL
                LD (HL), LOW SourceAddress?
                INC L
                LD (HL), HIGH SourceAddress?
                INC L
                LD (HL), SourcePage? & 0xFF
                else
                LD HL, $+14
                LD BC, DMASADDRX + #0100
                OUTI
                OUTI
                OUTI
                JR $+5
                DB SourcePage?, HIGH SourceAddress?, LOW SourceAddress?
                endif
                endm
; -----------------------------------------
; setting the address of the DMA destination buffer
; In :
;   DestinationPage    - page (16Kb)
;   DestinationAddress - offset in page
; Out :
; Corrupt :
;   HL, BC, F
; Note:
; the address for DMA does not take into account the state of the two most significant bits of a 16-bit address
; -----------------------------------------
DMA_Dst         macro DestinationPage?, DestinationAddress?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH DMADADDRL
                LD (HL), LOW DestinationAddress?
                INC L
                LD (HL), HIGH DestinationAddress?
                INC L
                LD (HL), DestinationPage? & 0xFF
                else
                LD HL, $+14
                LD BC, DMADADDRX + #0100
                OUTI
                OUTI
                OUTI
                JR $+5
                DB DestinationPage?, HIGH DestinationAddress?, LOW DestinationAddress?
                endif
                endm
; -----------------------------------------
; setting the address of the DMA destination buffer
; In :
;   NumberBurst - number of transmitted data blocks
;   BurstSize   - the size of one burst
; Out :
; Corrupt :
;   HL, BC, F
; Note:
; -----------------------------------------
DMA_Size        macro NumberBurst?, BurstSize?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH DMALEN
                LD (HL), ((BurstSize? >> 1) - 1)
                INC L
                INC L
                LD (HL), NumberBurst? - 1
                else
                LD HL, $+13
                LD BC, DMANUM + #0100
                OUTI
                DEC B
                OUTI
                JR $+4
                DB NumberBurst? - 1, ((BurstSize? >> 1) - 1)
                endif
                endm
; -----------------------------------------
; setting the DMA transfer mode
; In :
;   Mode - one of mode (DMA_RAM/DMA_BLT/DMA_FILL/DMA_SPI_RAM/DMA_RAM_SPI/DMA_IDE_RAM/DMA_RAM_IDE/DMA_RAM_CRAM/DMA_RAM_SFILE)
;   additional:
;    DMA_SALGN - alignment of the source address, up to the starting address with an increase in the highest address depending on the A_SZ flag
;    DMA_DALGN - alignment of the destination address, up to the starting address with an increase in the highest address depending on the A_SZ flag
;    DMA_ASZ   - data alignment: 256/512 bytes after each burst
; Out :
; Corrupt :
;   BC, A
; Note:
; after setting the mode, the transmission via DMA is automatically started
; -----------------------------------------
DMA_Ctrl        macro Mode?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH DMACTR
                LD (HL), Mode? & 0xFF
                else
                LD A, Mode? & 0xFF
                LD BC, DMACTR
                OUT (C), A
                endif
                endm
; -----------------------------------------
; waiting for the end of the DMA transfer
; In :
;   Mode - 
; Out :
; Corrupt :
;   BC, F
; Note:
; -----------------------------------------
DMA_Wait        macro
                LD BC, DMASTATUS
                IN F, (C)
                JP M, $-2
                endm

                endif ; ~_DMA_MACRO_
