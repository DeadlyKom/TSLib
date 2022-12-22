
                            ifndef _FT_81x_INCLUDE
                            define _FT_81x_INCLUDE
; -- Ports
SPI_CTRL                    EQU 0x77
SPI_DATA                    EQU 0x57

SPI_FT_CS_OFF               EQU 0x03
SPI_FT_CS_ON                EQU 0x07

; Memory addresses
FT_RAM_G                    EQU 0x000000    ; Main graphics RAM
FT_ROM_CHIPID               EQU 0x0C0000    ; Chip ID and revision
FT_ROM_FONT                 EQU 0x1E0000    ; Fonts
FT_ROM_FONT_ADDR            EQU 0x2FFFFC    ; Font table pointer address
FT_RAM_DL                   EQU 0x300000    ; Display list RAM
FT_RAM_REG                  EQU 0x302000    ; Registers
FT_RAM_CMD                  EQU 0x308000    ; Coprocessor command buffer
FT_RAM_ERR_REPORT           EQU 0x309800    ; Error

; Commands
FT_CMD_ACTIVE               EQU 0x00        ; cc 00 00
FT_CMD_STANDBY              EQU 0x41        ; cc 00 00
FT_CMD_SLEEP                EQU 0x42        ; cc 00 00
FT_CMD_PWRDOWN              EQU 0x43        ; cc 00 00
FT_CMD_PWRDOWN_             EQU 0x50        ; cc 00 00
FT_CMD_CLKEXT               EQU 0x44        ; cc 00 00
FT_CMD_CLKINT               EQU 0x48        ; cc 00 00
FT_CMD_PDROMS               EQU 0x49        ; cc xx 00
FT_CMD_CLKSEL               EQU 0x61        ; cc xx 00 -> [5:0] - mul, [7:6] - PLL range (0 for mul=0..3, 1 for mul=4..5)
FT_CMD_RST_PULSE            EQU 0x68        ; cc 00 00

; Registers
FT_REG_ID                   EQU 0x302000
FT_REG_FRAMES               EQU 0x302004
FT_REG_CLOCK                EQU 0x302008
FT_REG_FREQUENCY            EQU 0x30200C
FT_REG_RENDERMODE           EQU 0x302010
FT_REG_SNAPY                EQU 0x302014
FT_REG_SNAPSHOT             EQU 0x302018
FT_REG_SNAPFORMAT           EQU 0x30201C
FT_REG_CPURESET             EQU 0x302020
FT_REG_TAP_CRC              EQU 0x302024
FT_REG_TAP_MASK             EQU 0x302028
FT_REG_HCYCLE               EQU 0x30202C
FT_REG_HOFFSET              EQU 0x302030
FT_REG_HSIZE                EQU 0x302034
FT_REG_HSYNC0               EQU 0x302038
FT_REG_HSYNC1               EQU 0x30203C
FT_REG_VCYCLE               EQU 0x302040
FT_REG_VOFFSET              EQU 0x302044
FT_REG_VSIZE                EQU 0x302048
FT_REG_VSYNC0               EQU 0x30204C
FT_REG_VSYNC1               EQU 0x302050
FT_REG_DLSWAP               EQU 0x302054
FT_REG_ROTATE               EQU 0x302058
FT_REG_OUTBITS              EQU 0x30205C
FT_REG_DITHER               EQU 0x302060
FT_REG_SWIZZLE              EQU 0x302064
FT_REG_CSPREAD              EQU 0x302068
FT_REG_PCLK_POL             EQU 0x30206C
FT_REG_PCLK                 EQU 0x302070
FT_REG_TAG_X                EQU 0x302074
FT_REG_TAG_Y                EQU 0x302078
FT_REG_TAG                  EQU 0x30207C
FT_REG_VOL_PB               EQU 0x302080
FT_REG_VOL_SOUND            EQU 0x302084
FT_REG_SOUND                EQU 0x302088
FT_REG_PLAY                 EQU 0x30208C
FT_REG_GPIO_DIR             EQU 0x302090
FT_REG_GPIO                 EQU 0x302094
FT_REG_GPIOX_DIR            EQU 0x302098
FT_REG_GPIOX                EQU 0x30209C

FT_REG_INT_FLAGS            EQU 0x3020A8
FT_REG_INT_EN               EQU 0x3020AC
FT_REG_INT_MASK             EQU 0x3020B0
FT_REG_PLAYBACK_START       EQU 0x3020B4
FT_REG_PLAYBACK_LENGTH      EQU 0x3020B8
FT_REG_PLAYBACK_READPTR     EQU 0x3020BC
FT_REG_PLAYBACK_FREQ        EQU 0x3020C0
FT_REG_PLAYBACK_FORMAT      EQU 0x3020C4
FT_REG_PLAYBACK_LOOP        EQU 0x3020C8
FT_REG_PLAYBACK_PLAY        EQU 0x3020CC
FT_REG_PWM_HZ               EQU 0x3020D0
FT_REG_PWM_DUTY             EQU 0x3020D4
FT_REG_MACRO_0              EQU 0x3020D8
FT_REG_MACRO_1              EQU 0x3020DC

FT_REG_CMD_READ             EQU 0x3020F8
FT_REG_CMD_WRITE            EQU 0x3020FC
FT_REG_CMD_DL               EQU 0x302100
FT_REG_TOUCH_MODE           EQU 0x302104
FT_REG_TOUCH_ADC_MODE       EQU 0x302108
FT_REG_TOUCH_CHARGE         EQU 0x30210C
FT_REG_TOUCH_SETTLE         EQU 0x302110
FT_REG_TOUCH_OVERSAMPLE     EQU 0x302114
FT_REG_TOUCH_RZTHRESH       EQU 0x302118
FT_REG_TOUCH_RAW_XY         EQU 0x30211C
FT_REG_TOUCH_RZ             EQU 0x302120
FT_REG_TOUCH_SCREEN_XY      EQU 0x302124
FT_REG_TOUCH_TAG_XY         EQU 0x302128
FT_REG_TOUCH_TAG            EQU 0x30212C
FT_REG_TOUCH_TAG1_XY        EQU 0x302130
FT_REG_TOUCH_TAG1           EQU 0x302134
FT_REG_TOUCH_TAG2_XY        EQU 0x302138
FT_REG_TOUCH_TAG2           EQU 0x30213C
FT_REG_TOUCH_TAG3_XY        EQU 0x302140
FT_REG_TOUCH_TAG3           EQU 0x302144
FT_REG_TOUCH_TAG4_XY        EQU 0x302148
FT_REG_TOUCH_TAG4           EQU 0x30214C
FT_REG_TOUCH_TRANSFORM_A    EQU 0x302150
FT_REG_TOUCH_TRANSFORM_B    EQU 0x302154
FT_REG_TOUCH_TRANSFORM_C    EQU 0x302158
FT_REG_TOUCH_TRANSFORM_D    EQU 0x30215C
FT_REG_TOUCH_TRANSFORM_E    EQU 0x302160
FT_REG_TOUCH_TRANSFORM_F    EQU 0x302164
FT_REG_TOUCH_CONFIG         EQU 0x302168
FT_REG_CTOUCH_TOUCH4_X      EQU 0x30216C

FT_REG_BIST_EN              EQU 0x302174

FT_REG_TRIM                 EQU 0x302180
FT_REG_ANA_COMP             EQU 0x302184
FT_REG_SPI_WIDTH            EQU 0x302188
FT_REG_TOUCH_DIRECT_XY      EQU 0x30218C
FT_REG_TOUCH_DIRECT_Z1Z2    EQU 0x302190

FT_REG_DATESTAMP            EQU 0x302564

FT_REG_CMDB_SPACE           EQU 0x302574
FT_REG_CMDB_WRITE           EQU 0x302578

FT_REG_TRACKER              EQU 0x309000
FT_REG_TRACKER_1            EQU 0x309004
FT_REG_TRACKER_2            EQU 0x309008
FT_REG_TRACKER_3            EQU 0x30900C
FT_REG_TRACKER_4            EQU 0x309010

FT_REG_MEDIAFIFO_READ       EQU 0x309014
FT_REG_MEDIAFIFO_WRITE      EQU 0x309018

; Test functions

; The test never passes.
FT_NEVER                    EQU 0x00
; Passes if the value is less than the stored value.
FT_LESS                     EQU 0x01
; Passes if the value is less than or equal to the stored value.
FT_LEQUAL                   EQU 0x02
; Passes if the value is greater than the stored value.
FT_GREATER                  EQU 0x03
; Passes if the value is greater than or equal to the stored value
FT_GEQUAL                   EQU 0x04
; Passes if the value is equal to the stored value
FT_EQUAL                    EQU 0x05
; Passes if the value is not equal to the stored value
FT_NOTEQUAL                 EQU 0x06
; The test always passes.
FT_ALWAYS                   EQU 0x07

; Primitives
FT_BITMAPS                  EQU 1
FT_POINTS                   EQU 2
FT_LINES                    EQU 3
FT_LINE_STRIP               EQU 4
FT_EDGE_STRIP_R             EQU 5
FT_EDGE_STRIP_L             EQU 6
FT_EDGE_STRIP_A             EQU 7
FT_EDGE_STRIP_B             EQU 8
FT_RECTS                    EQU 9

; Formats
FT_ARGB1555                 EQU 0
FT_L1                       EQU 1
FT_L4                       EQU 2
FT_L8                       EQU 3
FT_RGB332                   EQU 4
FT_ARGB2                    EQU 5
FT_ARGB4                    EQU 6
FT_RGB565                   EQU 7
FT_PALETTED                 EQU 8  ; deprecated???
FT_TEXT8X8                  EQU 9
FT_TEXTVGA                  EQU 10
FT_BARGRAPH                 EQU 11
FT_PALETTED565              EQU 14
FT_PALETTED4444             EQU 15
FT_PALETTED8                EQU 16
FT_L2                       EQU 17

; Blend functions
FT_ZERO                     EQU 0
FT_ONE                      EQU 1
FT_SRC_ALPHA                EQU 2
FT_DST_ALPHA                EQU 3
FT_ONE_MINUS_SRC_ALPHA      EQU 4
FT_ONE_MINUS_DST_ALPHA      EQU 5

; Stencil operations

; The currently stored stencil value is kept.
FT_KEEP                     EQU 0x01
; The stencil value is replaced with the reference value set with StencilFunc
FT_REPLACE                  EQU 0x02
; The stencil value is increased by 1 if it is lower than the maximum value
FT_INCR                     EQU 0x03
; The stencil value is decreased by 1 if it is higher than the minimum value
FT_DECR                     EQU 0x04
; Bitwise inverts the current stencil buffer value
FT_INVERT                   EQU 0x05
; Same as FT_INCR, but wraps it back to 0 as soon as the maximum value is exceeded
FT_INCR_WRAP                EQU 0x06 ; undocumented???
; Same as FT_DECR, but wraps it to the maximum value if it ends up lower than 0
FT_DECR_WRAP                EQU 0x07 ; undocumented???

; Bitmap wrap mode
FT_REPEAT                   EQU 1
FT_BORDER                   EQU 0

; Bitmap filtering mode
FT_NEAREST                  EQU 0
FT_BILINEAR                 EQU 1

; DL_SWAP modes
FT_DLSWAP_DONE              EQU 0
FT_DLSWAP_LINE              EQU 1
FT_DLSWAP_FRAME             EQU 2

; INT sources
FT_INT_SWAP                 EQU 1
FT_INT_TOUCH                EQU 2
FT_INT_TAG                  EQU 4
FT_INT_SOUND                EQU 8
FT_INT_PLAYBACK             EQU 16
FT_INT_CMDEMPTY             EQU 32
FT_INT_CMDFLAG              EQU 64
FT_INT_CONVCOMPLETE         EQU 128

; Playback formats
FT_LINEAR_SAMPLES           EQU 0
FT_ULAW_SAMPLES             EQU 1
FT_ADPCM_SAMPLES            EQU 2

; Touch ADC modes
FT_ADC_SINGLE_ENDED         EQU 0
FT_ADC_DIFFERENTIAL         EQU 1

; Touch modes
FT_TOUCHMODE_OFF            EQU 0
FT_TOUCHMODE_ONESHOT        EQU 1
FT_TOUCHMODE_FRAME          EQU 2
FT_TOUCHMODE_CONTINUOUS     EQU 3

; Constants
FT_RAM_G_SIZE               EQU 0x100000
FT_DL_SIZE                  EQU 0x2000      ; 8KB Display List buffer size
FT_DL_COUNT                 EQU 0x0800
FT_CMD_FIFO_SIZE            EQU 0x1000      ; 4KB coprocessor FIFO size
FT_CMD_SIZE                 EQU 4           ; 4 byte per coprocessor command of EVE
FT_CMD_FIFO_COUNT           EQU 0x0400
FT_CMDBUF_SIZE              EQU 4096
FT_GPU_NUMCHAR_PERFONT      EQU 128
FT_GPU_FONT_TABLE_SIZE      EQU 148
FT_DL_MASK                  EQU (FT_DL_SIZE - 1)
FT_CMD_FIFO_MASK            EQU (FT_CMD_FIFO_SIZE - 1)

; Coprocessor commands
FT_CMD_APPEND               EQU 0xFFFFFF00 + 30
FT_CMD_BGCOLOR              EQU 0xFFFFFF00 + 9
FT_CMD_BITMAP_TRANSFORM     EQU 0xFFFFFF00 + 33
FT_CMD_BUTTON               EQU 0xFFFFFF00 + 13
FT_CMD_CALIBRATE            EQU 0xFFFFFF00 + 21
FT_CMD_CLOCK                EQU 0xFFFFFF00 + 20
FT_CMD_COLDSTART            EQU 0xFFFFFF00 + 50
FT_CMD_CRC                  EQU 0xFFFFFF00 + 3
FT_CMD_CSKETCH              EQU 0xFFFFFF00 + 53 ; Deprecated
FT_CMD_DIAL                 EQU 0xFFFFFF00 + 45
FT_CMD_DLSTART              EQU 0xFFFFFF00 + 0
FT_CMD_EXECUTE              EQU 0xFFFFFF00 + 7
FT_CMD_FGCOLOR              EQU 0xFFFFFF00 + 10
FT_CMD_GAUGE                EQU 0xFFFFFF00 + 19
FT_CMD_GETMATRIX            EQU 0xFFFFFF00 + 51
FT_CMD_GETPOINT             EQU 0xFFFFFF00 + 8
FT_CMD_GETPROPS             EQU 0xFFFFFF00 + 37
FT_CMD_GETPTR               EQU 0xFFFFFF00 + 35
FT_CMD_GRADCOLOR            EQU 0xFFFFFF00 + 52
FT_CMD_GRADIENT             EQU 0xFFFFFF00 + 11
FT_CMD_HAMMERAUX            EQU 0xFFFFFF00 + 4
FT_CMD_IDCT                 EQU 0xFFFFFF00 + 6
FT_CMD_INFLATE              EQU 0xFFFFFF00 + 34
FT_CMD_INTERRUPT            EQU 0xFFFFFF00 + 2
FT_CMD_KEYS                 EQU 0xFFFFFF00 + 14
FT_CMD_LOADIDENTITY         EQU 0xFFFFFF00 + 38
FT_CMD_LOADIMAGE            EQU 0xFFFFFF00 + 36
FT_CMD_LOGO                 EQU 0xFFFFFF00 + 49
FT_CMD_MARCH                EQU 0xFFFFFF00 + 5
FT_CMD_MEDIAFIFO            EQU 0xFFFFFF00 + 57
FT_CMD_MEMCPY               EQU 0xFFFFFF00 + 29
FT_CMD_MEMCRC               EQU 0xFFFFFF00 + 24
FT_CMD_MEMSET               EQU 0xFFFFFF00 + 27
FT_CMD_MEMWRITE             EQU 0xFFFFFF00 + 26
FT_CMD_MEMZERO              EQU 0xFFFFFF00 + 28
FT_CMD_NUMBER               EQU 0xFFFFFF00 + 46
FT_CMD_PLAYVIDEO            EQU 0xFFFFFF00 + 58
FT_CMD_PROGRESS             EQU 0xFFFFFF00 + 15
FT_CMD_REGREAD              EQU 0xFFFFFF00 + 25
FT_CMD_ROMFONT              EQU 0xFFFFFF00 + 63
FT_CMD_ROTATE               EQU 0xFFFFFF00 + 41
FT_CMD_SCALE                EQU 0xFFFFFF00 + 40
FT_CMD_SCREENSAVER          EQU 0xFFFFFF00 + 47
FT_CMD_SCROLLBAR            EQU 0xFFFFFF00 + 17
FT_CMD_SETBASE              EQU 0xFFFFFF00 + 56
FT_CMD_SETFONT              EQU 0xFFFFFF00 + 43
FT_CMD_SETFONT2             EQU 0xFFFFFF00 + 59
FT_CMD_SETMATRIX            EQU 0xFFFFFF00 + 42
FT_CMD_SETROTATE            EQU 0xFFFFFF00 + 54
FT_CMD_SETSCRATCH           EQU 0xFFFFFF00 + 60
FT_CMD_SKETCH               EQU 0xFFFFFF00 + 48
FT_CMD_SLIDER               EQU 0xFFFFFF00 + 16
FT_CMD_SNAPSHOT             EQU 0xFFFFFF00 + 31
FT_CMD_SNAPSHOT2            EQU 0xFFFFFF00 + 55
FT_CMD_SPINNER              EQU 0xFFFFFF00 + 22
FT_CMD_STOP                 EQU 0xFFFFFF00 + 23
FT_CMD_SWAP                 EQU 0xFFFFFF00 + 1
FT_CMD_TEXT                 EQU 0xFFFFFF00 + 12
FT_CMD_TOGGLE               EQU 0xFFFFFF00 + 18
FT_CMD_TOUCH_TRANSFORM      EQU 0xFFFFFF00 + 32
FT_CMD_TRACK                EQU 0xFFFFFF00 + 44
FT_CMD_TRANSLATE            EQU 0xFFFFFF00 + 39
FT_CMD_VIDEOFRAME           EQU 0xFFFFFF00 + 65
FT_CMD_VIDEOSTART           EQU 0xFFFFFF00 + 64

; Parameter options
FT_OPT_NONE                 EQU 0
FT_OPT_3D                   EQU 0
FT_OPT_RGB565               EQU 0
FT_OPT_MONO                 EQU 1
FT_OPT_NODL                 EQU 2
FT_OPT_FLAT                 EQU 256
FT_OPT_SIGNED               EQU 256
FT_OPT_CENTERX              EQU 512
FT_OPT_CENTERY              EQU 1024
FT_OPT_CENTER               EQU 1536
FT_OPT_RIGHTX               EQU 2048
FT_OPT_NOBACK               EQU 4096
FT_OPT_FILL                 EQU 8192
FT_OPT_FLASH                EQU 64
FT_OPT_FORMAT               EQU 4096
FT_OPT_NOTICKS              EQU 8192
FT_OPT_NOHM                 EQU 16384
FT_OPT_NOPOINTER            EQU 16384
FT_OPT_NOSECS               EQU 32768
FT_OPT_NOHANDS              EQU 49152
FT_OPT_NOTEAR               EQU 4
FT_OPT_FULLSCREEN           EQU 8
FT_OPT_MEDIAFIFO            EQU 16
FT_OPT_SOUND                EQU 32

; Video modes
; 640x480@57Hz (24Mhz)
F0_MUL                      EQU 3
H0_FPORCH                   EQU 16
H0_SYNC                     EQU 96
H0_BPORCH                   EQU 48
H0_VISIBLE                  EQU 640
V0_FPORCH                   EQU 11
V0_SYNC                     EQU 2
V0_BPORCH                   EQU 31
V0_VISIBLE                  EQU 480

; 640x480@74Hz (32Mhz)
F1_MUL                      EQU 4 
H1_FPORCH                   EQU 24
H1_SYNC                     EQU 40
H1_BPORCH                   EQU 128
H1_VISIBLE                  EQU 640
V1_FPORCH                   EQU 9
V1_SYNC                     EQU 3
V1_BPORCH                   EQU 28
V1_VISIBLE                  EQU 480

; 640x480@76Hz (32Mhz)
F2_MUL                      EQU 4
H2_FPORCH                   EQU 16
H2_SYNC                     EQU 96
H2_BPORCH                   EQU 48
H2_VISIBLE                  EQU 640
V2_FPORCH                   EQU 11
V2_SYNC                     EQU 2
V2_BPORCH                   EQU 31
V2_VISIBLE                  EQU 480

; 800x600@60Hz (40Mhz)
F3_MUL                      EQU 5
H3_FPORCH                   EQU 40
H3_SYNC                     EQU 128
H3_BPORCH                   EQU 88
H3_VISIBLE                  EQU 800
V3_FPORCH                   EQU 1
V3_SYNC                     EQU 4
V3_BPORCH                   EQU 23
V3_VISIBLE                  EQU 600

; 800x600@69Hz (48Mhz)
F4_MUL                      EQU 6
H4_FPORCH                   EQU 56
H4_SYNC                     EQU 120
H4_BPORCH                   EQU 64
H4_VISIBLE                  EQU 800
V4_FPORCH                   EQU 37
V4_SYNC                     EQU 6
V4_BPORCH                   EQU 23
V4_VISIBLE                  EQU 600

; 800x600@85Hz (56Mhz)
F5_MUL                      EQU 7
H5_FPORCH                   EQU 32
H5_SYNC                     EQU 64
H5_BPORCH                   EQU 152
H5_VISIBLE                  EQU 800
V5_FPORCH                   EQU 1
V5_SYNC                     EQU 3
V5_BPORCH                   EQU 27
V5_VISIBLE                  EQU 600

; 1024x768@59Hz (64Mhz)
F6_MUL                      EQU 8
H6_FPORCH                   EQU 24
H6_SYNC                     EQU 136
H6_BPORCH                   EQU 160
H6_VISIBLE                  EQU 1024
V6_FPORCH                   EQU 3
V6_SYNC                     EQU 6
V6_BPORCH                   EQU 29
V6_VISIBLE                  EQU 768

; 1024x768@67Hz (72Mhz)
F7_MUL                      EQU 9
H7_FPORCH                   EQU 24
H7_SYNC                     EQU 136
H7_BPORCH                   EQU 144
H7_VISIBLE                  EQU 1024
V7_FPORCH                   EQU 3
V7_SYNC                     EQU 6
V7_BPORCH                   EQU 29
V7_VISIBLE                  EQU 768

; 1024x768@76Hz (80Mhz)
F8_MUL                      EQU 10
H8_FPORCH                   EQU 16
H8_SYNC                     EQU 96
H8_BPORCH                   EQU 176
H8_VISIBLE                  EQU 1024
V8_FPORCH                   EQU 1
V8_SYNC                     EQU 3
V8_BPORCH                   EQU 28
V8_VISIBLE                  EQU 768

; Video mode macros
FT_ModeTab                  macro F_MUL, H_FPORCH, H_SYNC, H_BPORCH, H_VISIBLE, V_FPORCH, V_SYNC, V_BPORCH, V_VISIBLE
                            DB F_MUL
                            DW H_FPORCH
                            DW H_FPORCH + H_SYNC
                            DW H_FPORCH + H_SYNC + H_BPORCH
                            DW H_VISIBLE
                            DW H_FPORCH + H_SYNC + H_BPORCH + H_VISIBLE
                            DW V_FPORCH - 1
                            DW V_FPORCH + V_SYNC - 1
                            DW V_FPORCH + V_SYNC + V_BPORCH - 1
                            DW V_VISIBLE
                            DW V_FPORCH + V_SYNC + V_BPORCH + V_VISIBLE
                            endm
; Vmodes
VM_640_480_57Hz             FT_ModeTab F0_MUL, H0_FPORCH, H0_SYNC, H0_BPORCH, H0_VISIBLE, V0_FPORCH, V0_SYNC, V0_BPORCH, V0_VISIBLE
VM_640_480_74Hz             FT_ModeTab F1_MUL, H1_FPORCH, H1_SYNC, H1_BPORCH, H1_VISIBLE, V1_FPORCH, V1_SYNC, V1_BPORCH, V1_VISIBLE
VM_640_480_76Hz             FT_ModeTab F2_MUL, H2_FPORCH, H2_SYNC, H2_BPORCH, H2_VISIBLE, V2_FPORCH, V2_SYNC, V2_BPORCH, V2_VISIBLE
VM_800_600_60Hz             FT_ModeTab F3_MUL, H3_FPORCH, H3_SYNC, H3_BPORCH, H3_VISIBLE, V3_FPORCH, V3_SYNC, V3_BPORCH, V3_VISIBLE
VM_800_600_69Hz             FT_ModeTab F4_MUL, H4_FPORCH, H4_SYNC, H4_BPORCH, H4_VISIBLE, V4_FPORCH, V4_SYNC, V4_BPORCH, V4_VISIBLE
VM_800_600_85Hz             FT_ModeTab F5_MUL, H5_FPORCH, H5_SYNC, H5_BPORCH, H5_VISIBLE, V5_FPORCH, V5_SYNC, V5_BPORCH, V5_VISIBLE
VM_1024_768_59Hz            FT_ModeTab F6_MUL, H6_FPORCH, H6_SYNC, H6_BPORCH, H6_VISIBLE, V6_FPORCH, V6_SYNC, V6_BPORCH, V6_VISIBLE
VM_1024_768_67Hz            FT_ModeTab F7_MUL, H7_FPORCH, H7_SYNC, H7_BPORCH, H7_VISIBLE, V7_FPORCH, V7_SYNC, V7_BPORCH, V7_VISIBLE
VM_1024_768_76Hz            FT_ModeTab F8_MUL, H8_FPORCH, H8_SYNC, H8_BPORCH, H8_VISIBLE, V8_FPORCH, V8_SYNC, V8_BPORCH, V8_VISIBLE

                            endif ; ~_FT_81x_INCLUDE
