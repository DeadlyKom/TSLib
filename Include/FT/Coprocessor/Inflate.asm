
                ifndef _COPROCESSOR_INFLATE_
                define _COPROCESSOR_INFLATE_
; -----------------------------------------
; decompress the compressed data into RAM_G
; In :
;   ADE - destination address in RAM_G
;   B'BC  - number of bytes
;   HL  - source offset 0x3FFF
;   A'  - start page
; Out :
;   if the C flag is set, the coprocessor is fault,
;   otherwise the command FIFO buffer is empty
; Corrupt :
;   HL, DE, BC, AF, AF'
; Note:
; -----------------------------------------
Inflate:        ; wait till the decompression was done
                CALL WaitFlush
                RET C

                PUSH HL
                PUSH DE
                FT_WR32_CMD FT_CMD_INFLATE
                POP DE
                
                ; set destination address in RAM_G
                LD H, #00
                LD L, A
                CALL Write32

                ; save number page at adress #C000 - #FFFF
                GetPage3
                LD (.ContanerPage), A

                POP HL

                ; adjust source address
                LD A, H
                OR %11000000
                LD H, A
                EXX

.LoopOver       EXX

.Loop           PUSH HL

                ; set the required page
                EX AF, AF'
                SetPage3_A
                INC A
                EX AF, AF'

                ; calculate remainder page space
                LD A, H
                AND %00111111
                LD H, A
                EX DE, HL
                LD HL, #4000
                SBC HL, DE
                EX DE, HL
                
                ; HL = remainder copy bytes
                LD H, B
                LD L, C

                ; DE - remainder page 
                ; BC - remainder page 
                LD B, D
                LD C, E

                ; ; it's 64kb
                ; LD A, H
                ; OR L
                ; JR Z, .NotEnoughSpace

                ; size = min(remainder, size)
                OR A
                SBC HL, DE
                JR NC, .NotEnoughSpace

                ; more than enough space
                ADD HL, DE
                LD B, H
                LD C, L
                LD HL, #0000
                SCF                 ; last packet needs to be 4-byte aligned
                
.NotEnoughSpace EX DE, HL           ; DE - remainder copy bytes

                POP HL
                PUSH DE

                ; 
                CALL FT.Coprocessor.Write

                LD HL, #C000
                POP BC

                LD A, B
                OR C
                JR NZ, .Loop

                ; EXX
                ; DJNZ .LoopOver
                ; EXX

.ContanerPage   EQU $+1
                LD A, #00
                SetPage3_A

                RET

                endif ; ~_COPROCESSOR_INFLATE_
