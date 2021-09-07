
                ifndef _COPROCESSOR_GET_PTR_
                define _COPROCESSOR_GET_PTR_
; -----------------------------------------
; get the first unallocated memory location after executing the CMD_INFLATE command
; In :
; Out :
;   BCDE - read 32-bit value
;   if the C flag is set, the coprocessor is faulty
; Corrupt :
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
GetPtr:         ; wait till the decompression was done
                CALL WaitFlush
                RET C

                ; x = rd16(REG_CMD_WRITE)
                FT_RD_REG16 FT_REG_CMD_WRITE
                PUSH BC

                ; cmd_getptr(0);
                FT_WR32_CMD FT_CMD_GETPTR
                FT_WR32_CMD 0x00000000

                POP HL

                ; wait till the decompression was done
                CALL WaitFlush
                RET C

                ; ending_address = rd32(RAM_CMD + x + 4)
                INC HL
                INC HL
                INC HL
                INC HL

                LD A, (FT_RAM_CMD >> 16) & 0xFF
                LD DE, FT_RAM_CMD & 0xFFFF
                ADD HL, DE
                EX DE, HL
                ADC A, #00

                CALL FT.Read32
                OR A

                RET

                endif ; ~_COPROCESSOR_GET_PTR_
