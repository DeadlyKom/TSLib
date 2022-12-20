
                ifndef _MENU_ANCHOR_
                define _MENU_ANCHOR_

ANCHOR_LEFT     EQU 0x01 << 0
ANCHOR_RIGHT    EQU 0x02 << 0
ANCHOR_H_CENTER EQU 0x03 << 0
ANCHOR_UP       EQU 0x01 << 2
ANCHOR_DOWN     EQU 0x02 << 2
ANCHOR_V_CENTER EQU 0x03 << 2
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
AdjustWidth:    PUSH HL
                LD HL, (ResolutionWidthPtr)
                OR A
                SBC HL, DE
                SRL H
                RR L
                EX DE, HL
                POP HL
                RET
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
AdjustHeight:   LD HL, (ResolutionHeightPtr)
                OR A
                SBC HL, DE
                SRL H
                RR L
                RET
; -----------------------------------------
; In:
;   A  - anchor
;   HL - offset x
;   DE - offset y
; Out:
;   HL - position x
;   DE - position y
; Corrupt:
; Note:
; -----------------------------------------
AnchorText:     PUSH AF
.Horizontal     ;
                AND #03
                CP ANCHOR_LEFT
                JR Z, .Left
                CP ANCHOR_RIGHT
                JR Z, .Right

.HCenter        LD BC, (ResolutionWidthPtr)
                SRL B
                RR C
                ADD HL, BC
                JR .Vertical

.Right          LD BC, (ResolutionWidthPtr)
                ADD HL, BC
.Left           ; not offset
.Vertical       POP AF
                AND #0C
                CP ANCHOR_UP
                RET Z                                                           ; not offset vertical
                CP ANCHOR_DOWN
                JR Z, .Down

.VCenter        LD BC, (ResolutionHeightPtr)
                SRL B
                RR C
                EX DE, HL
                ADD HL, BC
                EX DE, HL

                RET

.Down           LD BC, (ResolutionHeightPtr)
                EX DE, HL
                ADD HL, BC
                EX DE, HL
                RET

                endif ; ~_MENU_ANCHOR_
