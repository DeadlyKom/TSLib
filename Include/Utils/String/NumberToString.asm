
                ifndef _STRING_NUMBER_TO_STRING_
                define _STRING_NUMBER_TO_STRING_
; -----------------------------------------
; convert unsigned char to string
; In:
;  entry  inputregister(s)  decimal value 0 to:
;   .D8               A                    255  ( 3 digits)
;   .D16             HL                  65535  ( 5 digits)
;   .D24           E:HL               16777215  ( 8 digits)
;   .D32          DE:HL             4294967295  (10 digits)
;   .D48       BC:DE:HL        281474976710655  (15 digits)
;   .D64    IX:BC:DE:HL   18446744073709551615  (20 digits)
; Out:
;   HL - points to the first digit
;   BC - number of decimals
; Corrupt:
;   HL, DE, BC, IX, AF
; Note:
;   the number is aligned to the right, and leading 0's are replaced with spaces.
;   by Alwin Henseler
;   https://www.msx.org/forum/development/msx-development/32-bit-long-ascii
; -----------------------------------------
Conver
.D8:            LD H, #00
                LD L, A
.D16:           LD E, #00
.D24:           LD D, #00
.D32:           LD BC, #0000
.D48:           LD IX, #0000                                                         ; zero all non-used bits
.D64:           LD (.B2DINV), HL
                LD (.B2DINV+2), DE
                LD (.B2DINV+4), BC
                LD (.B2DINV+6), IX                                              ; place full 64-bit input value in buffer
                LD HL, .B2DBUF
                LD DE, .B2DBUF+1
                LD (HL), " "
.B2DFILC        EQU $-1                                                         ; address of fill-character
                LD BC, 18
                LDIR                                                            ; fill 1st 19 bytes of buffer with spaces
                LD (.B2DEND-1), BC                                              ; set BCD value to "0" & place terminating 0
                LD E,1                                                          ; no. of bytes in BCD value
                LD HL, .B2DINV+8                                                ; (address MSB input)+1
                LD BC, #0909
                XOR A
.B2DSKP0        DEC B
                JR Z, .B2DSIZ                                                   ; all 0: continue with postprocessing
                DEC HL
                OR (HL)                                                         ; find first byte <>0
                JR Z, .B2DSKP0
.B2DFND1        DEC C
                RLA
                JR NC, .B2DFND1                                                 ; determine no. of most significant 1-bit
                RRA
                LD D, A                                                         ; byte from binary input value
.B2DLUS2        PUSH HL
                PUSH BC
.B2DLUS1        LD HL, .B2DEND-1                                                ; address LSB of BCD value
                LD B, E                                                         ; current length of BCD value in bytes
                RL D                                                            ; highest bit from input value -> carry
.B2DLUS0        LD A, (HL)
                ADC A, A
                DAA
                LD (HL), A                                                      ; double 1 BCD byte from intermediate result
                DEC HL
                DJNZ .B2DLUS0                                                   ; and go on to double entire BCD value (+carry!)
                JR NC, .B2DNXT
                INC E                                                           ; carry at MSB -> BCD value grew 1 byte larger
                LD (HL), #01                                                    ; initialize new MSB of BCD value
.B2DNXT         DEC C
                JR NZ, .B2DLUS1                                                 ; repeat for remaining bits from 1 input byte
                POP BC                                                          ; no. of remaining bytes in input value
                LD C, #08                                                       ; reset bit-counter
                POP HL                                                          ; pointer to byte from input value
                DEC HL
                LD D, (HL)                                                      ; get next group of 8 bits
                DJNZ .B2DLUS2                                                   ; and repeat until last byte from input value

.B2DSIZ         LD HL, .B2DEND                                                  ; address of terminating 0
                LD C, E                                                         ; size of BCD value in bytes
                OR A
                SBC HL, BC                                                      ; calculate address of MSB BCD
                LD D, H
                LD E, L
                SBC HL, BC
                EX DE, HL                                                       ; HL=address BCD value, DE=start of decimal value
                LD B, C                                                         ; no. of bytes BCD
                SLA C                                                           ; no. of bytes decimal (possibly 1 too high)
                LD A, "0"
                RLD                                                             ; shift bits 4-7 of (HL) into bit 0-3 of A
                CP "0"                                                          ; (HL) was > 9h?
                JR NZ, .B2DEXPH                                                 ; if yes, start with recording high digit
                DEC C                                                           ; correct number of decimals
                INC DE                                                          ; correct start address
                JR .B2DEXPL                                                     ; continue with converting low digit

.B2DEXP         RLD                                                             ; shift high digit (HL) into low digit of A
.B2DEXPH        LD (DE), A                                                      ; record resulting ASCII-code
                INC DE
.B2DEXPL        RLD
                LD (DE), A
                INC DE
                INC HL                                                          ; next BCD-byte
                DJNZ .B2DEXP                                                    ; and go on to convert each BCD-byte into 2 ASCII
                SBC HL, BC                                                      ; return with HL pointing to 1st decimal
                RET

.B2DINV         DS 8                                                            ; space for 64-bit input value (LSB first)
.B2DBUF         DS 20                                                           ; space for 20 decimal digits
.B2DEND         DS 1                                                            ; space for terminating 0

                endif ; ~_STRING_NUMBER_TO_STRING_
