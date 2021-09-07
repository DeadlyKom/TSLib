
                            ifndef _DISPLAY_LIST_MACRO_
                            define _DISPLAY_LIST_MACRO_

FT_DISPLAY                  macro 
                            DEFD (0 << 24)
                            endm
FT_BITMAP_SOURCE            macro Address?
                            DEFD (1 << 24) | (((Address?) & 1048575) << 0)
                            endm
FT_CLEAR_COLOR_RGB          macro Red?, Green?, Blue?
                            DEFD (2 << 24) | (((Red?) & 255) << 16) | (((Green?) & 255) << 8) | (((Blue?) & 255) << 0)
                            endm
FT_TAG                      macro Tag?
                            DEFD (3 << 24) | (((Tag?) & 255) << 0)
                            endm
FT_COLOR_RGB                macro Red?, Green?, Blue?
                            DEFD (4 << 24) | (((Red?) & 255) << 16) | (((Green?) & 255) << 8) | (((Blue?) & 255) << 0)
                            endm
FT_BITMAP_HANDLE            macro Handle?
                            DEFD (5 << 24) | (((Handle?) & 31) << 0)
                            endm
FT_CELL                     macro Cell?
                            DEFD (6 << 24) | (((Cell?) & 127) << 0)
                            endm
FT_BITMAP_LAYOUT            macro Format?, Linestride?, Height?
                            DEFD (7 << 24) | (((Format?) & 31) << 19) | (((Linestride?) & 1023) << 9) | (((Height?) & 511) << 0)
                            endm
FT_BITMAP_SIZE              macro Filter?, WrapX?, WrapY?, Width?, Height?
                            DEFD (8 << 24) | (((Filter?) & 1) << 20) | (((WrapX?) & 1) << 19) | (((WrapY?) & 1) << 18) | (((Width?) & 511) << 9) | (((Height?) & 511) << 0)
                            endm
FT_ALPHA_FUNC               macro Func?, Ref?
                            DEFD (9 << 24) | (((Func?) & 7) << 8) | (((Ref?) & 255) << 0)
                            endm
; Func: Sets the stencil test function that determines whether a fragment passes or is discarded.
;       This test function is applied to the stored stencil value and the StencilFunc's ref value.
;       Possible options are: FT_NEVER, FT_LESS, FT_LEQUAL, FT_GREATER, FT_GEQUAL, FT_EQUAL, FT_NOTEQUAL and FT_ALWAYS.
; Ref:  Specifies the reference value for the stencil test. The stencil buffer's content is compared to this value.
; Mask: Specifies a mask that is ANDed with both the reference value and the stored stencil value before the test compares them.
FT_STENCIL_FUNC             macro Func?, Ref?, Mask?
                            DEFD (0x0A << 24) | (((Func?) & 0x0F) << 16) | (((Ref?) & 0xFF) << 8) | (((Mask?) & 0xFF) << 0)
                            endm
FT_BLEND_FUNC               macro Source?, Destination?
                            DEFD (11 << 24) | (((Source?) & 7) << 3) | (((Destination?) & 7) << 0)
                            endm
FT_STENCIL_OP               macro SFail?, SPass?
                            DEFD (0x0C << 24) | (((SFail?) & 0x07) << 3) | (((SPass?) & 0x07) << 0)
                            endm
FT_POINT_SIZE               macro SizePoint?
                            DEFD (13 << 24) | (((SizePoint?) & 8191) << 0)
                            endm
FT_LINE_WIDTH               macro Width?
                            DEFD (14 << 24) | (((Width?) & 4095) << 0)
                            endm
FT_CLEAR_COLOR_A            macro Alpha?
                            DEFD (15 << 24) | (((Alpha?) & 255) << 0)
                            endm
FT_COLOR_A                  macro Alpha?
                            DEFD (16 << 24) | (((Alpha?) & 255) << 0)
                            endm
FT_CLEAR_STENCIL            macro Stencil?
                            DEFD (17 << 24) | (((Stencil?) & 255) << 0)
                            endm
FT_CLEAR_TAG                macro Tag?
                            DEFD (18 << 24) | (((Tag?) & 255) << 0)
                            endm
FT_STENCIL_MASK             macro Mask?
                            DEFD (19 << 24) | (((Mask?) & 255) << 0)
                            endm
FT_TAG_MASK                 macro Mask?
                            DEFD (20 << 24) | (((Mask?) & 1) << 0)
                            endm
FT_BITMAP_TRANSFORM_A       macro A?
                            DEFD (21 << 24) | (((A?) & 131071) << 0)
                            endm
FT_BITMAP_TRANSFORM_B       macro B?
                            DEFD (22 << 24) | (((B?) & 131071) << 0)
                            endm
FT_BITMAP_TRANSFORM_C       macro C?
                            DEFD (23 << 24) | (((C?) & 16777215) << 0)
                            endm
FT_BITMAP_TRANSFORM_D       macro D?
                            DEFD (24 << 24) | (((D?) & 131071) << 0)
                            endm
FT_BITMAP_TRANSFORM_E       macro E?
                            DEFD (25 << 24) | (((E?) & 131071) << 0)
                            endm
FT_BITMAP_TRANSFORM_F       macro F?
                            DEFD (26 << 24) | (((F?) & 16777215) << 0)
                            endm
FT_SCISSOR_XY               macro X?, Y?
                            DEFD (27 << 24) | (((X?) & 1023) << 11) | (((Y?) & 1023) << 0)
                            endm
FT_SCISSOR_SIZE             macro Width?, Height?
                            DEFD (28 << 24) | (((Width?) & 2047) << 12) | (((Height?) & 2047) << 0)
                            endm
FT_CALL                     macro Destination?
                            DEFD (29 << 24) | (((Destination?) & 65535) << 0)
                            endm
FT_JUMP                     macro Destination?
                            DEFD (30 << 24) | (((Destination?) & 65535) << 0)
                            endm
FT_BEGIN                    macro Primitive?
                            DEFD (31 << 24) | (((Primitive?) & 15) << 0)
                            endm
FT_COLOR_MASK               macro Red?, Green?, Blue?, Alpha?
                            DEFD (32 << 24) | (((Red?) & 1) << 3) | (((Green?) & 1) << 2) | (((Blue?) & 1) << 1) | (((Alpha?) & 1) << 0)
                            endm
FT_END                      macro
                            DEFD (33 << 24)
                            endm
FT_SAVE_CONTEXT             macro
                            DEFD (34 << 24)
                            endm
FT_RESTORE_CONTEXT          macro
                            DEFD (35 << 24)
                            endm
FT_RETURN                   macro
                            DEFD (36 << 24)
                            endm
FT_MACRO                    macro Macros?
                            DEFD (37 << 24) | (((Macros?) & 1) << 0))
                            endm
FT_CLEAR                    macro  Color?, Stencil?, Tag?
                            DEFD (38 << 24) | (((Color?) & 1) <<2 ) | (((Stencil?) & 1) << 1) | (((Tag?) & 1) << 0)
                            endm
FT_VERTEX_FORMAT            macro Frac?
                            DEFD (39 << 24) | (Frac? & 7)
                            endm
FT_BITMAP_LAYOUT_H          macro Linestride?, Height?
                            DEFD (40 << 24) | (((Linestride?) & 3) << 2) | (((Height?) & 3) << 0)
                            endm
FT_BITMAP_SIZE_H            macro Width?, Height?
                            DEFD (41 << 24) | (((Width?) & 3) << 2) | (((Height?) & 3) << 0)
                            endm
FT_PALETTE_SOURCE           macro Address?
                            DEFD (42 << 24) | (Address? & 0x3FFFFF)
                            endm
FT_VERTEX_TRANSLATE_X       macro X?
                            DEFD (43 << 24) | (X? & 0x1FFFF)
                            endm
FT_VERTEX_TRANSLATE_Y       macro Y?
                            DEFD (44 << 24) | (Y? & 0x1FFFF)
                            endm
FT_NOP                      macro
                            DEFD (45 << 24)
                            endm
FT_VERTEX2F                 macro X?, Y?
                            DEFD (64 << 24) | (((X?) & 32767) << 15) | (((Y?) & 32767) << 0)
                            endm
FT_VERTEX2II                macro X?, Y?, Handle?, Cell?
                            DEFD (128 << 24) | (((X?) & 511) << 21) | (((Y?) & 511) << 12) | (((Handle?) & 31) << 7) | (((Cell?) & 127) << 0)
                            endm

                            endif ; ~_DISPLAY_LIST_MACRO_
