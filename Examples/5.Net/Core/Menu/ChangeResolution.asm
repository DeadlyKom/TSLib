
                ifndef _MENU_CHANGE_RESOLUTION_
                define _MENU_CHANGE_RESOLUTION_
; -----------------------------------------
; 
; In:
;   A -
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetResolution:  LD (Res.Counter), A
                ;
                LD HL, .AvailableRes
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ;
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                LD (ResolutionWidthPtr), BC
                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                LD (ResolutionHeightPtr), BC
                LD C, (HL)
                INC HL
                LD B, (HL)
                LD (ResolutionFreqPtr), BC
                
                EX DE, HL
                JP FT.Initialize

.AvailableRes   DW VM_640_480_57Hz,   640, 480, 57
                DW VM_640_480_74Hz,   640, 480, 74
                DW VM_640_480_76Hz,   640, 480, 76
                DW VM_800_600_60Hz,   800, 600, 60
                DW VM_800_600_69Hz,   800, 600, 69
                DW VM_800_600_85Hz,   800, 600, 85
                DW VM_1024_768_59Hz, 1024, 768, 59
                DW VM_1024_768_67Hz, 1024, 768, 67
                DW VM_1024_768_76Hz, 1024, 768, 76

                endif ; ~_MENU_CHANGE_RESOLUTION_
