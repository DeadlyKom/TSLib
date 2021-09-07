
                ifndef _NVRAM_SET_DATA_
                define _NVRAM_SET_DATA_
; -----------------------------------------
; write data to NVRAM cells
; In :
;   D - cell address
;   E - new value
; Out :
; Corrupt :
;   BC
; Note:
; -----------------------------------------
SetData:        LD BC, PORT_NVCELLADR
                OUT (C), D
                LD B, HIGH PORT_NVCELLRW
                OUT (C), E
                RET

                endif ; ~_NVRAM_SET_DATA_
