
                    ifndef _TS_CONF_
                    define _TS_CONF_

; TS-config port regs
VCONFIG             EQU #00AF
STATUS              EQU #00AF
VPAGE               EQU #01AF
GXOFFSL             EQU #02AF
GXOFFSH             EQU #03AF
GYOFFSL             EQU #04AF
GYOFFSH             EQU #05AF
TSCONFIG            EQU #06AF
PALSEL              EQU #07AF
BORDER              EQU #0FAF
PAGE0               EQU #10AF
PAGE1               EQU #11AF
PAGE2               EQU #12AF
PAGE3               EQU #13AF
FMADDR              EQU #15AF
FMADDR_CRAM         EQU #0000
FMADDR_SFILE        EQU #0200
FMADDR_REGS         EQU #0400
TMPAGE              EQU #16AF
T0GPAGE             EQU #17AF
T1GPAGE             EQU #18AF
SGPAGE              EQU #19AF
DMASADDRL           EQU #1AAF
DMASADDRH           EQU #1BAF
DMASADDRX           EQU #1CAF
DMADADDRL           EQU #1DAF
DMADADDRH           EQU #1EAF
DMADADDRX           EQU #1FAF
SYSCONFIG           EQU #20AF
CACHECONFIG         EQU #2BAF

; Memory mode
; D7, D6    (LCK128)    = 00 - 512k, 01 — 128k, 10 — Auto, 11 — 1024 k
; D3        (WO_RAM)    = 0 - ROM, 1 - RAM
; D2        (WO_MAP)    = 0 - mapping allowed, 1 - mapping prohibited
; D1        (WO_WE)     = 0 - write allowed, 1 - write prohibited
; D0        (ROM128)    = same as D4 in #7FFD

MEM_WO_ROM128       EQU #01
MEM_WO_WE           EQU #02
MEM_WO_MAP          EQU #04
MEM_WO_RAM          EQU #08

MEMCONFIG           EQU #21AF
HSINT               EQU #22AF
VSINTL              EQU #23AF
VSINTH              EQU #24AF
DMALEN              EQU #26AF
DMACTR              EQU #27AF
DMASTATUS           EQU #27AF
DMANUM              EQU #28AF
FDDVIRT             EQU #29AF
INTMASK             EQU #2AAF
T0XOFFSL            EQU #40AF
T0XOFFSH            EQU #41AF
T0YOFFSL            EQU #42AF
T0YOFFSH            EQU #43AF
T1XOFFSL            EQU #44AF
T1XOFFSH            EQU #45AF
T1YOFFSL            EQU #46AF
T1YOFFSH            EQU #47AF

; TS parameters
FM_EN               EQU #10

; FPGA arrays
FM_CRAM             EQU #0000
FM_SFILE            EQU #0200

; Video
VID_256X192         EQU #00
VID_320X200         EQU #40
VID_320X240         EQU #80
VID_360X288         EQU #C0
VID_RASTER_BS       EQU #06

VID_ZX              EQU #00
VID_16C             EQU #01
VID_256C            EQU #02
VID_TEXT            EQU #03
VID_FT812           EQU #04
VID_NOGFX           EQU #20
VID_MODE_BS         EQU #00

; PALSEL
PAL_GPAL_MASK       EQU #0F
PAL_GPAL_BS         EQU #00
PAL_T0PAL_MASK      EQU #30
PAL_T0PAL_BS        EQU #04
PAL_T1PAL_MASK      EQU #C0
PAL_T1PAL_BS        EQU #06

; TSU
TSU_T0ZEN           EQU #04
TSU_T1ZEN           EQU #08
TSU_T0EN            EQU #20
TSU_T1EN            EQU #40
TSU_SEN             EQU #80

; System
SYS_ZCLK3_5         EQU #00
SYS_ZCLK7           EQU #01
SYS_ZCLK14          EQU #02
SYS_ZCLK_BS         EQU #00

SYS_CACHEEN         EQU #04

; Memory
MEM_ROM128          EQU #01
MEM_W0WE            EQU #02
MEM_W0MAP_N         EQU #04
MEM_W0RAM           EQU #08

MEM_LCK512          EQU #00
MEM_LCK128          EQU #40
MEM_LCKAUTO         EQU #80
MEM_LCK1024         EQU #C0
MEM_LCK_BS          EQU #06

; INT
INT_VEC_FRAME       EQU #FF
INT_VEC_LINE        EQU #FD
INT_VEC_DMA         EQU #FB

INT_MSK_FRAME       EQU #01
INT_MSK_LINE        EQU #02
INT_MSK_DMA         EQU #04

; DMA
DMA_WNR             EQU #80
DMA_SALGN           EQU #20
DMA_DALGN           EQU #10
DMA_ASZ             EQU #08

DMA_RAM             EQU #01
DMA_BLT             EQU #81
DMA_FILL            EQU #04
DMA_SPI_RAM         EQU #02
DMA_RAM_SPI         EQU #82
DMA_IDE_RAM         EQU #03
DMA_RAM_IDE         EQU #83
DMA_RAM_CRAM        EQU #84
DMA_RAM_SFILE       EQU #85

; Sprites
SP_XF               EQU #80
SP_YF               EQU #80
SP_LEAP             EQU #40
SP_ACT              EQU #20

SP_SIZE8            EQU #00
SP_SIZE16           EQU #02
SP_SIZE24           EQU #04
SP_SIZE32           EQU #06
SP_SIZE40           EQU #08
SP_SIZE48           EQU #0A
SP_SIZE56           EQU #0C
SP_SIZE64           EQU #0E
SP_SIZE_BS          EQU #01

SP_PAL_MASK         EQU #F0

SP_XF_W             EQU #8000
SP_YF_W             EQU #8000
SP_LEAP_W           EQU #4000
SP_ACT_W            EQU #2000

SP_SIZE8_W          EQU #0000
SP_SIZE16_W         EQU #0200
SP_SIZE24_W         EQU #0400
SP_SIZE32_W         EQU #0600
SP_SIZE40_W         EQU #0800
SP_SIZE48_W         EQU #0A00
SP_SIZE56_W         EQU #0C00
SP_SIZE64_W         EQU #0E00
SP_SIZE_BS_W        EQU #09

SP_X_MASK_W         EQU #01FF
SP_Y_MASK_W         EQU #01FF
SP_TNUM_MASK_W      EQU #0FFF
SP_PAL_MASK_W       EQU #F000

; Tiles
TL_XF               EQU #40
TL_YF               EQU #80
TL_PAL_MASK         EQU #30
TL_PAL_BS           EQU #04

TL_XF_W             EQU #4000
TL_YF_W             EQU #8000

TL_TNUM_MASK_W      EQU #0FFF
TL_PAL_MASK_W       EQU #3000
TL_PAL_BS_W         EQU #0C

; Cache
EN_0000             EQU #01             ; RAM #0000-#3FFF
EN_4000             EQU #02             ; RAM #4000-#7FFF
EN_8000             EQU #04             ; RAM #8000-#BFFF
EN_C000             EQU #08             ; RAM #C000-#FFFF

                    endif ; ~_TS_CONF_
