
                ifndef _GAME_MATH_CROSS_PRODUCT_2D_
                define _GAME_MATH_CROSS_PRODUCT_2D_
; -----------------------------------------
; векторное произведение 2D
; In :
;   A - Utils.Mesh.Primitive.VertexA
;   B - Utils.Mesh.Primitive.VertexB
;   C - Utils.Mesh.Primitive.VertexC
; Out :
; Corrupt :
;   флаг знака сброшен, если порядок вершин по часовой стрелке, т.е. видим
; Note:
;  (B.x - A.x) * (C.y - B.y) - (C.x - B.x) * (B.y - A.y)
; -----------------------------------------
CrossProduct2D: ; ---------------------------------------------
                ; B.x - A.x
                ; ---------------------------------------------
                LD HL, (Utils.Mesh.Primitive.VertexB.X)
                LD DE, (Utils.Mesh.Primitive.VertexA.X)
                OR A
                SBC HL, DE
                PUSH HL

                ; ---------------------------------------------
                ; C.y - B.y
                ; ---------------------------------------------
                LD HL, (Utils.Mesh.Primitive.VertexC.Y)
                LD DE, (Utils.Mesh.Primitive.VertexB.Y)
                OR A
                SBC HL, DE
                PUSH HL

                ; ---------------------------------------------
                ; C.x - B.x
                ; ---------------------------------------------
                LD HL, (Utils.Mesh.Primitive.VertexC.X)
                LD DE, (Utils.Mesh.Primitive.VertexB.X)
                OR A
                SBC HL, DE
                PUSH HL

                ; ---------------------------------------------
                ; B.y - A.y
                ; ---------------------------------------------
                LD HL, (Utils.Mesh.Primitive.VertexB.Y)
                LD DE, (Utils.Mesh.Primitive.VertexA.Y)
                OR A
                SBC HL, DE

                ; ---------------------------------------------
                ; DEHL = (C.x - B.x) * (B.y - A.y)
                ; ---------------------------------------------
                EX DE, HL
                POP BC

                ; определение результирующего знака 
                LD A, B
                XOR D
                EX AF, AF'

                ; BC = abc(BC)
                BIT 7, B
                JR Z, $+8
                XOR A
                SUB C
                LD C, A
                SBC A, A
                SUB B
                LD B, A

                ; DE = abc(DE)
                BIT 7, D
                JR Z, $+8
                XOR A
                SUB E
                LD E, A
                SBC A, A
                SUB D
                LD D, A

                ; DEHL = BC * DE
                CALL Math.Mul_16x16

                ; установка результирующего знака
                EX AF, AF'
                RLA
                JR NC, .SetResult

                ; NEG DEHL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A
                LD A, #00
                SBC A, E
                LD E, A
                SBC A, A
                SUB D
                LD D, A

.SetResult      POP BC
                EX DE, HL
                EX (SP), HL
                EX DE, HL
                PUSH HL

                ; ---------------------------------------------
                ; DEHL = (B.x - A.x) * (C.y - B.y)
                ; ---------------------------------------------

                ; определение результирующего знака 
                LD A, B
                XOR D
                EX AF, AF'

                ; BC = abc(BC)
                BIT 7, B
                JR Z, $+8
                XOR A
                SUB C
                LD C, A
                SBC A, A
                SUB B
                LD B, A

                ; DE = abc(DE)
                BIT 7, D
                JR Z, $+8
                XOR A
                SUB E
                LD E, A
                SBC A, A
                SUB D
                LD D, A

                ; DEHL = BC * DE
                CALL Math.Mul_16x16

                ; установка результирующего знака
                EX AF, AF'
                RLA
                JR NC, .Calculate

                ; NEG DEHL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A
                LD A, #00
                SBC A, E
                LD E, A
                SBC A, A
                SUB D
                LD D, A

                ; ---------------------------------------------
.Calculate      ; (B.x - A.x) * (C.y - B.y) - (C.x - B.x) * (B.y - A.y)
                ; ---------------------------------------------
                POP BC
                OR A
                SBC HL, BC
                EX DE, HL

                POP BC
                SBC HL, BC

                RET

                endif ; ~_GAME_MATH_CROSS_PRODUCT_2D_
