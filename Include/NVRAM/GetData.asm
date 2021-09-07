
                ifndef _NVRAM_GET_DATA_
                define _NVRAM_GET_DATA_
; -----------------------------------------
; read data from cell NVRAM
; In :
;   A - cell address
; Out :
;   A - read value
; Corrupt :
;   BC, AF
; Note:
; -----------------------------------------
GetData:        LD BC, PORT_NVCELLADR
                OUT (C), A
                LD B, HIGH PORT_NVCELLRW
                IN A, (C)
                RET

                endif ; ~_NVRAM_GET_DATA_
