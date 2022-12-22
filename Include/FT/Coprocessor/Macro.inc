
                ifndef _COPROCESSOR_MACRO_
                define _COPROCESSOR_MACRO_
; -----------------------------------------
; decompress the compressed data into RAM_G
; In :
;   Destination? - destination address in RAM_G
;   Page?        - start page
;   Source?      - source offset 0x3FFF
;   Size?        - number of bytes
; Out :
;   if the C flag is set, the coprocessor is fault,
;   otherwise the command FIFO buffer is empty
; Corrupt :
;   HL, DE, BC, AF, AF', B'
; Note:
; -----------------------------------------
FT_WR_INFLATE   macro Destination?, Page?, Source?, Size?
                LD HL, (Source?) & 0xFFFF
                LD DE, (Destination?) & 0xFFFF
                EXX
                LD B, 1 + ((Size?) >> 16) & 0xFF
                EXX
                LD BC, (Size?) & 0xFFFF
                LD A, (Page?) & 0xFF
                EX AF, AF'
                LD A, ((Destination?) >> 16) & 0xFF
                CALL FT.Coprocessor.Inflate
                endm

FT_ALIGN        macro
                ; 4-byte alignment (L % 4)
                LD A, L
                NEG
                AND %00000011
                JR Z, .Aligned

                rept 2
                LD (HL), #00
                INC HL
                DEC A
                JR Z, .Aligned
                endr

                LD (HL), #00
                INC HL
                        
.Aligned        ;
                endm

                endif ; ~_COPROCESSOR_MACRO_
