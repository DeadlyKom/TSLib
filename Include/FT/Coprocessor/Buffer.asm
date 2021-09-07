
                ifndef _COPROCESSOR_BUFFER_
                define _COPROCESSOR_BUFFER_
   
                ifndef CMD_ADDRESS_PTR
                define CMD_ADDRESS_PTR #C000
                endif

                define CMD_ADDRESS_NEG (-CMD_ADDRESS_PTR) & 0xFFFF

; -----------------------------------------
; copy data to CMD buffer with 4-byte alignment
; In :
;   HL - address string
;   BC - length string
; Out :
;   
; Corrupt :
;   
; -----------------------------------------
Copy            LD DE, (BufferPtr)
                LDIR
                EX DE, HL
                LD (HL), C
                INC HL

                ; 4-byte alignment (L % 4)
                LD A, L
                AND %00000011
                JR Z, .Aligned

                rept 2
                LD (HL), C
                INC HL
                INC A
                JR Z, .Aligned
                endr

                LD (HL), C
                INC HL
                        
.Aligned        LD (BufferPtr), HL

                RET
; -----------------------------------------
; append CMD command to CMD buffer
; In :
;   DE - low command
;   BC - high command
; Out :
; Corrupt :
; -----------------------------------------
Command_BCDE:   LD HL, (BufferPtr)

                LD (HL), E
                INC HL

                LD (HL), D
                INC HL

                LD (HL), C
                INC HL

                LD (HL), B
                INC HL

                LD (BufferPtr), HL
                RET
; -----------------------------------------
; append ColorRGB command to CMD buffer
; In :
;   C - Red
;   D - Green
;   E - Blue
; Out :
; Corrupt :
; -----------------------------------------
ColorRGB:       LD B, #00
                SET 2, B

                JR Command_BCDE
; -----------------------------------------
; append Vertex2f command to CMD buffer
; In :
;   DE - Y
;   BC - X
; Out :
; Corrupt :
; -----------------------------------------
Vertex2f:       RL D
                OR A
                RR B
                RR C
                RR D
                
                SET 6, B
                RES 7, B

                JR Command_BCDE
; -----------------------------------------
; append Vertex2ii command to CMD buffer
; In :
;   H  - Handle
;   L  - Cell
;   DE - Y
;   BC - X
; Out :
; Corrupt :
; -----------------------------------------
Vertex2ii:      LD A, C
                rept 5
                ADD A, A
                RL B
                endr
                LD C, A
                
                LD A, E
                rept 4
                ADD A, A
                RL D
                endr
                LD E, A

                LD A, D
                AND %00011111
                OR C
                LD C, A
                LD D, E
                
                RL L
                RR H
                RR L
                LD E, L
                
                LD A, H
                AND %00001111
                OR D
                LD D, A

                SET 7, B
                RES 6, B

                JR Command_BCDE
BufferPtr:      DW #0000

                endif ; ~_COPROCESSOR_BUFFER_
