
                ifndef _COPROCESSOR_MACRO_
                define _COPROCESSOR_MACRO_
; -----------------------------------------
; decompress the compressed data into RAM_G
; In :
;   ADE - destination address in RAM_G
;   BC  - number of bytes
;   HL  - source offset 0x3FFF
;   A'  - start page
; Out :
;   if the C flag is set, the coprocessor is fault,
;   otherwise the command FIFO buffer is empty
; Corrupt :
;   HL, DE, BC, AF, AF'
; Note:
; -----------------------------------------
FT_WR_INFLATE   macro Destination?, Page?, Source?, Size?
                LD HL, (Source?) & 0xFFFF
                LD DE, (Destination?) & 0xFFFF
                LD BC, (Size?) & 0xFFFF
                LD A, (Page?) & 0xFF
                EX AF, AF'
                LD A, ((Destination?) >> 16) & 0xFF
                CALL FT.Coprocessor.Inflate
                endm

                endif ; ~_COPROCESSOR_MACRO_
