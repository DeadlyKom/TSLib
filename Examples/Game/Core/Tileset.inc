
Tileset_RAM_G           EQU FT_RAM_G
Tileset_Format          EQU FT_RGB565
Tileset_Width           EQU 16
Tileset_Height          EQU 16
Tileset_Stride          EQU Tileset_Width * 2
Tileset_Size            EQU Tileset_Stride * Tileset_Height
Tileset_RealSize        EQU Tileset_Size
Tileset_Page            EQU 128
Tileset_RAM             EQU #C000


; Tileset_RAM_G           EQU FT_RAM_G
; Tileset_Format          EQU FT_RGB565
; Tileset_Width           EQU 16
; Tileset_Height          EQU 16
; Tileset_Stride          EQU Tileset_Width * 2
; Tileset_Size            EQU Tileset_Stride * Tileset_Height
; Tileset_RealSize        EQU Tileset_Size
; Tileset_Page            EQU 128
; Tileset_RAM             EQU #C000