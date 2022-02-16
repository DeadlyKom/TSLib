
                ifndef _MEMORY_FUNCTIONS_
                define _MEMORY_FUNCTIONS_
; -----------------------------------------
; set the page number from the address #0000 - #3FFF
; In :
;   A - page number
; Out :
; Corrupt :
;   .. / (BC)
; Note:
; -----------------------------------------
SetPage0:       SetPage0_A
                RET
; -----------------------------------------
; get the page number from the address #0000 - #3FFF
; In :
; Out :
;   A - page number
; Corrupt :
;   A
; Note:
; -----------------------------------------
GetPage0:       GetPage0
                RET
; -----------------------------------------
; set the page number from the address #4000 - #7FFF
; In :
;   A - page number
; Out :
; Corrupt :
;   .. / (BC)
; Note:
; -----------------------------------------
SetPage1:       SetPage1_A
                RET
; -----------------------------------------
; get the page number from the address #4000 - #7FFF
; In :
; Out :
;   A - page number
; Corrupt :
;   A
; Note:
; -----------------------------------------
GetPage1:       GetPage1
                RET
; -----------------------------------------
; set the page number from the address #8000 - #BFFF
; In :
;   A - page number
; Out :
; Corrupt :
;   .. / (BC)
; Note:
; -----------------------------------------
SetPage2:       SetPage2_A
                RET
; -----------------------------------------
; get the page number from the address #8000 - #BFFF
; In :
; Out :
;   A - page number
; Corrupt :
;   A
; Note:
; -----------------------------------------
GetPage2:       GetPage2
                RET
; -----------------------------------------
; set the page number from the address #C000 - #FFFF
; In :
;   A - page number
; Out :
; Corrupt :
;   .. / (BC)
; Note:
; -----------------------------------------
SetPage3:       SetPage3_A
                RET
; -----------------------------------------
; get the page number from the address #C000 - #FFFF
; In :
; Out :
;   A - page number
; Corrupt :
;   A
; Note:
; -----------------------------------------
GetPage3:       GetPage3
                RET

                endif ; ~_MEMORY_FUNCTIONS_
