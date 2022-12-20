
                ifndef _CONST_FONTS_
                define _CONST_FONTS_
; ; HouseFly
; Font_12:
; .Handle         EQU 1
; .FTRAM_Adr      EQU FT_RAM_G + 0
; .Stride         EQU 2
; .Width          EQU 12
; .Height         EQU 13
; .FirstChar      EQU 32
; .RAM            EQU #C000
; .Page           EQU 10
; .Size           EQU 2618

; Font_30:
; .Handle         EQU 2
; .FTRAM_Adr      EQU FT_RAM_G + Font_12.Size
; .Stride         EQU 4
; .Width          EQU 28
; .Height         EQU 31
; .FirstChar      EQU 32
; .RAM            EQU #CC00
; .Page           EQU 10
; .Size           EQU 11928

; ; SpaceCyr
; Font_12:
; .Handle         EQU 1
; .FTRAM_Adr      EQU FT_RAM_G + 0
; .Stride         EQU 2
; .Width          EQU 10
; .Height         EQU 14
; .FirstChar      EQU 32
; .RAM            EQU #C000
; .Page           EQU 10
; .Size           EQU 2808

; Font_30:
; .Handle         EQU 2
; .FTRAM_Adr      EQU FT_RAM_G + Font_12.Size
; .Stride         EQU 3
; .Width          EQU 24
; .Height         EQU 34
; .FirstChar      EQU 32
; .RAM            EQU #CC00
; .Page           EQU 10
; .Size           EQU 9838

; ; Cameron
; Font_12:
; .Handle         EQU 1
; .FTRAM_Adr      EQU FT_RAM_G + 0
; .Stride         EQU 2
; .Width          EQU 14
; .Height         EQU 16
; .FirstChar      EQU 32
; .RAM            EQU #C000
; .Page           EQU 10
; .Size           EQU 3188

; Font_30:
; .Handle         EQU 2
; .FTRAM_Adr      EQU FT_RAM_G + Font_12.Size
; .Stride         EQU 3
; .Width          EQU 24
; .Height         EQU 29
; .FirstChar      EQU 32
; .RAM            EQU #CE00
; .Page           EQU 10
; .Size           EQU 12288

; ; Nosifer
; Font_12:
; .Handle         EQU 1
; .FTRAM_Adr      EQU FT_RAM_G + 0
; .Stride         EQU 2
; .Width          EQU 16
; .Height         EQU 19
; .FirstChar      EQU 32
; .RAM            EQU #C000
; .Page           EQU 10
; .Size           EQU 3758

; Font_30:
; .Handle         EQU 2
; .FTRAM_Adr      EQU FT_RAM_G + Font_12.Size
; .Stride         EQU 5
; .Width          EQU 38
; .Height         EQU 46
; .FirstChar      EQU 32
; .RAM            EQU #D000
; .Page           EQU 10
; .Size           EQU 21998

; ; Lkdown
; Font_12:
; .Handle         EQU 1
; .FTRAM_Adr      EQU FT_RAM_G + 0
; .Stride         EQU 2
; .Width          EQU 12
; .Height         EQU 14
; .FirstChar      EQU 32
; .RAM            EQU #C000
; .Page           EQU 10
; .Size           EQU 2808

; Font_30:
; .Handle         EQU 2
; .FTRAM_Adr      EQU FT_RAM_G + Font_12.Size
; .Stride         EQU 4
; .Width          EQU 32
; .Height         EQU 35
; .FirstChar      EQU 32
; .RAM            EQU #CC00
; .Page           EQU 10
; .Size           EQU 13448

; ; LongShotCyrillic
; Font_12:
; .Handle         EQU 1
; .FTRAM_Adr      EQU FT_RAM_G + 0
; .Stride         EQU 2
; .Width          EQU 10
; .Height         EQU 17
; .FirstChar      EQU 32
; .RAM            EQU #C000
; .Page           EQU 10
; .Size           EQU 3378

; Font_30:
; .Handle         EQU 2
; .FTRAM_Adr      EQU FT_RAM_G + Font_12.Size
; .Stride         EQU 3
; .Width          EQU 18
; .Height         EQU 32
; .FirstChar      EQU 32
; .RAM            EQU #CE00
; .Page           EQU 10
; .Size           EQU 9268

; BitOutRegular
Font_12:
.Handle         EQU 1
.FTRAM_Adr      EQU FT_RAM_G + 0
.Stride         EQU 3
.Width          EQU 20
.Height         EQU 26
.FirstChar      EQU 32
.RAM            EQU #C000
.Page           EQU 10
.Size           EQU 7558

Font_30:
.Handle         EQU 2
.FTRAM_Adr      EQU FT_RAM_G + Font_12.Size
.Stride         EQU 7
.Width          EQU 50
.Height         EQU 65
.FirstChar      EQU 32
.RAM            EQU #DE00
.Page           EQU 10
.Size           EQU 43373

; ; ZebulonBold
; Font_12:
; .Handle         EQU 1
; .FTRAM_Adr      EQU FT_RAM_G + 0
; .Stride         EQU 2
; .Width          EQU 16
; .Height         EQU 12
; .FirstChar      EQU 32
; .RAM            EQU #C000
; .Page           EQU 10
; .Size           EQU 2428

; Font_30:
; .Handle         EQU 2
; .FTRAM_Adr      EQU FT_RAM_G + Font_12.Size
; .Stride         EQU 5
; .Width          EQU 38
; .Height         EQU 28
; .FirstChar      EQU 32
; .RAM            EQU #CA00
; .Page           EQU 10
; .Size           EQU 13448

; ; Jefferies
; Font_12:
; .Handle         EQU 1
; .FTRAM_Adr      EQU FT_RAM_G + 0
; .Stride         EQU 2
; .Width          EQU 10
; .Height         EQU 9
; .FirstChar      EQU 32
; .RAM            EQU #C000
; .Page           EQU 10
; .Size           EQU 1858

; Font_30:
; .Handle         EQU 2
; .FTRAM_Adr      EQU FT_RAM_G + Font_12.Size
; .Stride         EQU 3
; .Width          EQU 22
; .Height         EQU 22
; .FirstChar      EQU 32
; .RAM            EQU #C800
; .Page           EQU 10
; .Size           EQU 6418

; ; HazelnutProLight
; Font_12:
; .Handle         EQU 1
; .FTRAM_Adr      EQU FT_RAM_G + 0
; .Stride         EQU 3
; .Width          EQU 24
; .Height         EQU 23
; .FirstChar      EQU 32
; .RAM            EQU #C000
; .Page           EQU 10
; .Size           EQU 6703

; Font_30:
; .Handle         EQU 2
; .FTRAM_Adr      EQU FT_RAM_G + Font_12.Size
; .Stride         EQU 4
; .Width          EQU 30
; .Height         EQU 29
; .FirstChar      EQU 32
; .RAM            EQU #DC00
; .Page           EQU 10
; .Size           EQU 11168

                endif ; ~_CONST_FONTS_
