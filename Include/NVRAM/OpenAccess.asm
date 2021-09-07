
                ifndef _NVRAM_OPEN_ACCESS_
                define _NVRAM_OPEN_ACCESS_
; -----------------------------------------
; open access to the clock cells
; In :
; Out :
; Corrupt :
;   BC, A
; Note:
; -----------------------------------------
OpenAccess:     LD A, FLAG_ACCESS_NVRAM
                LD BC, PORT_RESMGR
                OUT (C), A
                RET

                endif ; ~_NVRAM_OPEN_ACCESS_
