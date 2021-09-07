                
                ifndef _NVRAM_CLOSE_ACCESS_
                define _NVRAM_CLOSE_ACCESS_
; -----------------------------------------
; close access to the clock cells
; In :
; Out :
; Corrupt :
;   BC, A
; Note:
; -----------------------------------------
CloseAccess:    LD A, FLAG_NONE_NVRAM
                LD BC, PORT_RESMGR
                OUT (C), A
                RET

                endif ; ~_NVRAM_CLOSE_ACCESS_ 
