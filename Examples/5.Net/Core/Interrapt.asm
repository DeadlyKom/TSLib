
                ifndef _EXAMPLE_CORE_ITERRUPT_
                define _EXAMPLE_CORE_ITERRUPT_
                
TickCounterRef  EQU INT_Handler.TickCounterPtr                                  ; счётчик тиков 1/50

; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
INT_Handler:    PUSH HL
                PUSH DE
                PUSH BC
                PUSH IX
                PUSH IY
                PUSH AF
                EX AF, AF'
                PUSH AF
                EXX
                PUSH HL
                PUSH DE
                PUSH BC

.TickCounter    ; ********** TICK COUNTER *********
.TickCounterPtr EQU $+1
                LD HL, #0000
                INC HL
                LD (.TickCounterPtr), HL

                ; update key states for PS2 keyboard
                ifdef KEYBOARD_PS2
                CALL Input.Keyboard.PS2.StateUpdates
                endif

                POP BC
                POP DE
                POP HL
                EXX
                POP AF
                EX AF, AF'
                POP AF
                POP IY
                POP IX
                POP BC
                POP DE
                POP HL

                EI
                RET

                endif ; ~_EXAMPLE_CORE_ITERRUPT_
