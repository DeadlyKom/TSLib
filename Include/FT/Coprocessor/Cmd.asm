
                ifndef _COPROCESSOR_CMD_
                define _COPROCESSOR_CMD_
; -----------------------------------------
; write a block data to FT812 coprocessor
; In :
;   HL  - source address Z80
;   BC  - number of bytes
;   if the C flag is set, it is necessary to align the data with 4 bytes
; Out :
;   if the C flag is set, the coprocessor is fault,
;   otherwise the data has successfully append to FIFO
; Corrupt :
;   F
; Note:
; -----------------------------------------
Write:          ; save registers
                PUSH AF
                LD (.ContainerHL), HL
                LD (.ContainerDE), DE
                LD (.ContainerBC), BC

                JR NC, .Aligned

                ; 4-byte alignment
                LD A, C
                NEG
                AND %00000011
                JR Z, .Aligned
                
                ADD A, C
                LD C, A
                JR NC, .Aligned
                INC B

.Aligned        ; 

.Loop           PUSH HL
                PUSH BC

.Wait           CALL IsFault
                JR NC, .IsNotFault
                ifdef DEBUG_EVE
                POP BC
                POP HL
                POP AF
                JP DisplayError
                else
                POP BC
                POP HL
                POP AF
                SCF                                         ; set flag C
                RET
                endif

.IsNotFault     ; coprocessor not fault

                ; read available CMDB buffer space
                FT_RD_REG16 FT_REG_CMDB_SPACE
                LD A, B
                OR C
                JR Z, .Wait

                ; size = min(remainder, size)
                POP HL
                OR A
                SBC HL, BC
                JR NC, .NotEnoughSpace

                ; more than enough space
                ADD HL, BC
                LD B, H
                LD C, L
                LD HL, #0000

.NotEnoughSpace EX (SP), HL                                 ; remainder <-> memory address

                LD A, (FT_REG_CMDB_WRITE >> 16) & 0xFF
                LD DE, FT_REG_CMDB_WRITE & 0xFFFF
                CALL FT.WriteMem

                POP BC                                      ; remainder
                LD A, B
                OR C
                JR NZ, .Loop

                ; TODO check align 4 bytes transfer 

                ; restore registers
.ContainerHL    EQU $+1
                LD HL, #0000
.ContainerDE    EQU $+1
                LD DE, #0000
.ContainerBC    EQU $+1
                LD BC, #0000
                POP AF
                OR A                                        ; reset flag C

                RET
; -----------------------------------------
; write 32-bit value to FT812 coprocessor
; In :
;   HLDE - 32-bit value
; Out :
;   if the C flag is set, the coprocessor is fault,
;   otherwise the command or data has successfully append to FIFO
; Corrupt :
;   F
; Note:
; -----------------------------------------
Write32:        PUSH AF
                PUSH BC

                LD (.ContainerDE), DE

.Wait           CALL IsFault
                JR NC, .IsNotFault
                ifdef DEBUG_EVE
                POP BC
                POP AF
                JP DisplayError
                else
                POP BC
                POP AF
                SCF                                         ; set flag C
                RET
                endif

.IsNotFault     ; coprocessor not fault

                ; read available CMDB buffer space
                FT_RD_REG16 FT_REG_CMDB_SPACE
                LD A, B
                OR C
                JR Z, .Wait

.ContainerDE    EQU $+1
                LD DE, #0000

                ; TODO check 4 bytes is free

                FT_ON

                ; set address memory
                LD A, (FT_REG_CMDB_WRITE >> 16) & 0xFF
                OR #80
                OUT (SPI_DATA), A
                LD A, (FT_REG_CMDB_WRITE >> 8) & 0xFF
                OUT (SPI_DATA), A
                LD A, FT_REG_CMDB_WRITE & 0xFF
                OUT (SPI_DATA), A

                ; write 32-bits value
                LD A, E
                OUT (SPI_DATA), A
                LD A, D
                OUT (SPI_DATA), A
                LD A, L
                OUT (SPI_DATA), A
                LD A, H
                OUT (SPI_DATA), A

                FT_OFF
                POP BC
                POP AF
                OR A                                        ; reset flag C

                RET
; -----------------------------------------
; FT812 coprocessor
; In :
; Out :
;   if the C flag is set, the coprocessor is fault,
;   otherwise the command or data has successfully append to FIFO
; Corrupt :
;   F
; Note:
; -----------------------------------------
Wait:           CALL IsFault
                JR NC, .IsNotFault
                ifdef DEBUG_EVE
                POP BC
                POP AF
                JP DisplayError
                else
                POP BC
                POP AF
                SCF                                         ; set flag C
                RET
                endif

.IsNotFault     ; coprocessor not fault

                ; read available CMDB buffer space
                FT_RD_REG16 FT_REG_CMDB_SPACE
                LD A, B
                OR C
                JR Z, Wait
                RET

                ifdef DEBUG_EVE
; -----------------------------------------
; load a 32-bit value to the memory area of the FT812 coprocessor
; In :
;   HLDE - 32-bit value
; Out :
; Corrupt :
; Note:
; -----------------------------------------
DisplayError:   LD HL, .DL_Text
                LD A, (.DL_Address >> 16) & 0xFF
                LD DE, .DL_Address & 0xFFFF
                LD BC, .DL_TextSize
                CALL FT.WriteMem

                LD HL, .DL_Error
                LD BC, .DL_ErrorSize
                CALL FT.WriteDL

                FT_WR_REG8 FT_REG_DLSWAP, FT_DLSWAP_FRAME
                JR $

.DL_Text        BYTE "Coprocessor fault!\0\0"                                   ; needs to be aligned at 4-bytes
.DL_TextSize    EQU $ - .DL_Text
.DL_Address     EQU FT_RAM_G + FT_RAM_G_SIZE - .DL_TextSize
.DL_Error       EQU $
                FT_CLEAR_COLOR_RGB 0x00, 0x00, 0x82
                FT_CLEAR 1, 1, 1
                FT_BITMAP_HANDLE 15
                FT_BITMAP_SOURCE .DL_Address
                FT_BITMAP_SIZE_H 0, 0
                FT_BITMAP_SIZE FT_NEAREST, FT_BORDER, FT_BORDER, 256, 128 >> 2
                FT_BITMAP_LAYOUT_H 0, 0
                FT_BITMAP_LAYOUT FT_TEXT8X8, 32, 128 >> 2
                FT_BEGIN FT_BITMAPS
                FT_VERTEX2II 32, 32, 15, 0
                FT_DISPLAY
.DL_ErrorSize   EQU $ - .DL_Error

                endif

                endif ; ~_COPROCESSOR_CMD_
