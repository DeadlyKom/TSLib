
                        ifndef _COPROCESSOR_BUFFER_MACRO_
                        define _COPROCESSOR_BUFFER_MACRO_

FT_CMD_Start            macro
                        LD HL, CMD_ADDRESS_PTR
                        LD (FT.Coprocessor.BufferPtr), HL
                        endm
FT_CMD_BUF              macro Command?
                        LD HL, (FT.Coprocessor.BufferPtr)
                        LD DE, (Command? >>  0) & 0xFFFF
                        LD BC, (Command? >> 16) & 0xFFFF

                        LD (HL), E
                        INC HL

                        LD (HL), D
                        INC HL

                        LD (HL), C
                        INC HL

                        LD (HL), B
                        INC HL

                        LD (FT.Coprocessor.BufferPtr), HL
                        endm
FT_CMD_Write            macro
                        FT_CMD_Count
                        LD HL, CMD_ADDRESS_PTR
                        ; SCF
                        CALL FT.Coprocessor.Write
                        endm
FT_CMD_Count            macro
                        LD HL, (FT.Coprocessor.BufferPtr)
                        LD DE, CMD_ADDRESS_NEG
                        ADD HL, DE
                        LD B, H
                        LD C, L
                        endm
FT_AlphaFunc            macro Func?, Ref?
                        FT_CMD_BUF ((0x09 << 24) | (((Func?) & 0x07) << 8) | (((Ref?) & 0xFF) << 0))
                        endm
FT_Begin                macro Primitive?
                        FT_CMD_BUF ((0x1F << 24) | (((Primitive?) & 0x0F) << 0))
                        endm
FT_BitmapHandle         macro Handle?
                        FT_CMD_BUF ((0x05 << 24) | (((Handle?) & 0x1F) << 0))
                        endm
FT_BitmapLayout         macro Format?, Linestride?, Height?
                        FT_CMD_BUF ((0x28 << 24) | (((Linestride? >> 10) & 0x03) << 2)  | (((Height? >> 9) & 0x03)   << 0))
                        FT_CMD_BUF ((0x07 << 24) | (((Format?)           & 0x1F) << 19) | (((Linestride?)  & 0x03FF) << 9) | (((Height?) & 0x01FF) << 0))
                        endm
FT_BitmapSize           macro Filter?, WrapX?, WrapY?, Width?, Height?
                        FT_CMD_BUF ((0x29 << 24) | (((Width? >> 9) & 0x03) << 2)  | (((Height? >> 9) & 0x03) << 0))
                        FT_CMD_BUF ((0x08 << 24) | (((Filter?)     & 0x01) << 20) | (((WrapX?)       & 0x01) << 19) | (((WrapY?) & 0x01) << 18) | (((Width?) & 0x01FF) << 9) | (((Height?) & 0x01FF) << 0))
                        endm
FT_BitmapSource         macro Address?
                        FT_CMD_BUF ((0x01 << 24) | (((Address?) & 0x3FFFFF) << 0))
                        endm
FT_BitmapTransformA     macro fA?
                        FT_CMD_BUF ((0x15 << 24) | ((fA? & 0x01FFFF) << 0))
                        endm
FT_BitmapTransformB     macro fB?
                        FT_CMD_BUF ((0x16 << 24) | ((fB? & 0x01FFFF) << 0))
                        endm
FT_BitmapTransformC     macro fC?
                        FT_CMD_BUF ((0x17 << 24) | ((fC? & 0xFFFFFF) << 0))
                        endm
FT_BitmapTransformD     macro fD?
                        FT_CMD_BUF ((0x18 << 24) | ((fD? & 0x01FFFF) << 0))
                        endm
FT_BitmapTransformE     macro fE?
                        FT_CMD_BUF ((0x19 << 24) | ((fE? & 0x01FFFF) << 0))
                        endm
FT_BitmapTransformF     macro fF?
                        FT_CMD_BUF ((0x1A << 24) | ((fF? & 0xFFFFFF) << 0))
                        endm
FT_BlendFunc            macro Source?, Destination?
                        FT_CMD_BUF ((0x0B << 24) | ((Source? & 0x07) << 3) | ((Destination? & 0x07) << 0))
                        endm
FT_Call                 macro Address?
                        FT_CMD_BUF ((0x1D << 24) | (((Address?) & 0xFFFF) << 0))
                        endm
FT_Cell                 macro Cell?
                        FT_CMD_BUF ((0x06 << 24) | (((Cell?) & 0x7F) << 0))
                        endm
FT_ClearColorAlpha      macro Alpha?
                        FT_CMD_BUF ((0x0F << 24) | (((Alpha?) & 0xFF) << 0))
                        endm
FT_ClearColorRGB        macro Red?, Green?, Blue?
                        FT_CMD_BUF ((0x02 << 24) | (((Red?) & 0xFF) << 16) | (((Green?) & 0xFF) << 8) | (((Blue?) & 0xFF) << 0))
                        endm
FT_ClearColorRGB32      macro RGB?
                        FT_CMD_BUF ((0x02 << 24) | (RGB? & 0xFFFFFF))
                        endm                     
FT_Clear                macro Color?, Stencil?, Tag?
                        FT_CMD_BUF ((0x26 << 24) | (((Color?) & 0x01) << 2 ) | (((Stencil?) & 0x01) << 1) | (((Tag?) & 0x01) << 0))
                        endm
FT_ClearAll             macro
                        FT_CMD_BUF ((0x26 << 24) | 0x07)
                        endm
FT_ClearStencil         macro Stencil?
                        FT_CMD_BUF ((0x11 << 24) | (((Stencil?) & 0xFF) << 0))
                        endm
FT_ClearTag             macro Tag?
                        FT_CMD_BUF ((0x12 << 24) | (((Tag?) & 0xFF) << 0))
                        endm
FT_ColorA               macro Alpha?
                        FT_CMD_BUF ((0x10 << 24) | (((Alpha?) & 0xFF) << 0))
                        endm
FT_ColorMask            macro Red?, Green?, Blue?, Alpha?
                        FT_CMD_BUF ((0x20 << 24) | (((Red?) & 0x01) << 3) | (((Green?) & 0x01) << 2) | (((Blue?) & 0x01) << 1) | (((Alpha?) & 0x01) << 0))
                        endm
FT_ColorRGB             macro Red?, Green?, Blue?
                        FT_CMD_BUF ((0x04 << 24) | (((Red?) & 255) << 16) | (((Green?) & 255) << 8) | (((Blue?) & 255) << 0))
                        endm
FT_ColorRGB32           macro RGB?
                        FT_CMD_BUF ((0x04 << 24) | (RGB? & 0xFFFFFF))
                        endm   
FT_Display              macro
                        FT_CMD_BUF (0 << 24)
                        endm
FT_End                  macro
                        FT_CMD_BUF (0x21 << 24)
                        endm
FT_Jump                 macro Address?
                        FT_CMD_BUF ((0x1E << 24) | (((Address?) & 0xFFFF) << 0))
                        endm
FT_LineWidth            macro Width?
                        FT_CMD_BUF ((0x0E << 24) | (((Width?) & 0x0FFF) << 0))
                        endm
FT_Macro                macro Macros?
                        FT_CMD_BUF ((0x25 << 24) | (((Macros?) & 0x01) << 0)))
                        endm
FT_Nop                  macro
                        FT_CMD_BUF (0x2D << 24)
                        endm
FT_PaletteSource        macro Address?
                        FT_CMD_BUF ((0x2A << 24) | (Address? & 0x3FFFFF))
                        endm
FT_PointSize            macro SizePoint?
                        FT_CMD_BUF ((0x0D << 24) | (((SizePoint?) & 0x01FFF) << 0))
                        endm
FT_RestoreContext       macro
                        FT_CMD_BUF (0x23 << 24)
                        endm
FT_Return               macro
                        FT_CMD_BUF (0x24 << 24)
                        endm
FT_SaveContext          macro
                        FT_CMD_BUF (0x22 << 24)
                        endm
FT_ScissorSize          macro Width?, Height?
                        FT_CMD_BUF ((0x1C << 24) | (((Width?) & 0x07FF) << 12) | (((Height?) & 0x07FF) << 0))
                        endm
FT_ScissorXY            macro X?, Y?
                        FT_CMD_BUF ((0x1B << 24) | (((X?) & 0x03FF) << 11) | (((Y?) & 0x03FF) << 0))
                        endm
FT_StencilFunc          macro Func?, Ref?, Mask?
                        FT_CMD_BUF ((0x0A << 24) | (((Func?) & 0x0F) << 16) | (((Ref?) & 0xFF) << 8) | (((Mask?) & 0xFF) << 0))
                        endm
FT_StencilMask          macro Mask?
                        FT_CMD_BUF ((0x13 << 24) | (((Mask?) & 0xFF) << 0))
                        endm
FT_StencilOp            macro SFail?, SPass?
                        FT_CMD_BUF ((0x0C << 24) | (((SFail?) & 0x07) << 3) | (((SPass?) & 0x07) << 0))
                        endm
FT_Tag                  macro Tag?
                        FT_CMD_BUF ((0x03 << 24) | (((Tag?) & 0xFF) << 0))
                        endm
FT_TagMask              macro Mask?
                        FT_CMD_BUF ((0x14 << 24) | (((Mask?) & 0x01) << 0))
                        endm
FT_Vertex2f             macro X?, Y?
                        FT_CMD_BUF ((0x40 << 24) | (((X?) & 0x07FFF) << 15) | (((Y?) & 0x07FFF) << 0))
                        endm
FT_Vertex2ii            macro X?, Y?, Handle?, Cell?
                        FT_CMD_BUF ((0x80 << 24) | (((X?) & 0x01FF) << 21) | (((Y?) & 0x01FF) << 12) | (((Handle?) & 0x1F) << 7) | (((Cell?) & 0x7F) << 0))
                        endm
FT_VertexFormat         macro Frac?
                        FT_CMD_BUF ((0x27 << 24) | (Frac? & 0x07))
                        endm
FT_VertexTranslateX     macro X?
                        FT_CMD_BUF ((0x2B << 24) | (X? & 0xFFFF))
                        endm
FT_VertexTranslateY     macro X?
                        FT_CMD_BUF ((0x2C << 24) | (Y? & 0xFFFF))
                        endm
FT_DL_Start             macro
                        FT_CMD_BUF FT_CMD_DLSTART
                        endm
FT_Text                 macro X?, Y?, Font?, Options?
                        FT_CMD_BUF FT_CMD_TEXT
                        FT_CMD_BUF ((Y?       & 0xFFFF) << 16 | (X?    & 0xFFFF))
                        FT_CMD_BUF ((Options? & 0xFFFF) << 16 | (Font? & 0xFFFF))
                        endm
FT_Gradient             macro x1?, y1?, rgb1?, x2?, y2?, rgb2?
                        FT_CMD_BUF FT_CMD_GRADIENT
                        FT_CMD_BUF ((y1?  & 0xFFFF) << 16 | (x1?    & 0xFFFF))
                        FT_CMD_BUF (rgb1? & 0xFFFFFF)
                        FT_CMD_BUF ((y2?  & 0xFFFF) << 16 | (x2?    & 0xFFFF))
                        FT_CMD_BUF (rgb2? & 0xFFFFFF)
                        endm
FT_ScrollBar            macro x?, y?, w?, h?, Options?, Value?, Size?, Range?
                        FT_CMD_BUF FT_CMD_SCROLLBAR
                        FT_CMD_BUF ((y?      & 0xFFFF) << 16 | (x?        & 0xFFFF))
                        FT_CMD_BUF ((h?      & 0xFFFF) << 16 | (w?        & 0xFFFF))
                        FT_CMD_BUF ((Value?  & 0xFFFF) << 16 | (Options?  & 0xFFFF))
                        FT_CMD_BUF ((Range?  & 0xFFFF) << 16 | (Size?     & 0xFFFF))
                        endm
FT_SetBase              macro Base?
                        FT_CMD_BUF FT_CMD_SETBASE
                        FT_CMD_BUF (Base? & 0xFFFFFFFF)
                        endm
FT_Number               macro x?, y?, Font?, Options?, Number?
                        FT_CMD_BUF FT_CMD_NUMBER
                        FT_CMD_BUF ((y?       & 0xFFFF) << 16 | (x?    & 0xFFFF))
                        FT_CMD_BUF ((Options? & 0xFFFF) << 16 | (Font? & 0xFFFF))
                        FT_CMD_BUF (Number?   & 0xFFFFFFFF)
                        endm
FT_NumberDEBC           macro x?, y?, Font?, Options?
                        LD (.DE), DE
                        LD (.BC), BC
                        FT_CMD_BUF FT_CMD_NUMBER
                        FT_CMD_BUF ((y?       & 0xFFFF) << 16 | (x?    & 0xFFFF))
                        FT_CMD_BUF ((Options? & 0xFFFF) << 16 | (Font? & 0xFFFF))
.DE                     EQU $+1
                        LD DE, #0000
.BC                     EQU $+1
                        LD BC, #0000
                        FT_CMD_Command_DEBC_M
                        endm
FT_Inflate              macro Destination?
                        FT_CMD_BUF FT_CMD_INFLATE
                        FT_CMD_BUF Destination?
                        endm
FT_LoadIdentity         macro
                        FT_CMD_BUF FT_CMD_LOADIDENTITY
                        endm
FT_Scale                macro ScaleX?, ScaleY?
                        FT_CMD_BUF FT_CMD_SCALE
                        FT_CMD_BUF ScaleX?
                        FT_CMD_BUF ScaleY?
                        endm
FT_SetMatrix            macro
                        FT_CMD_BUF FT_CMD_SETMATRIX
                        endm
FT_BitmapTransform      macro Sx0?, Sy0?, Sx1?, Sy1?, Sx2?, Sy2?, Tx0?, Ty0?, Tx1?, Ty1?, Tx2?, Ty2?, Result?
                        FT_CMD_BUF FT_CMD_BITMAP_TRANSFORM
                        FT_CMD_BUF Sx0?
                        FT_CMD_BUF Sy0?
                        FT_CMD_BUF Sx1?
                        FT_CMD_BUF Sy1?
                        FT_CMD_BUF Sx2?
                        FT_CMD_BUF Sy2?
                        FT_CMD_BUF Tx0?
                        FT_CMD_BUF Ty0?
                        FT_CMD_BUF Tx1?
                        FT_CMD_BUF Ty1?
                        FT_CMD_BUF Tx2?
                        FT_CMD_BUF Ty2?
                        FT_CMD_BUF Result?
                        endm
FT_String               macro Address?, Length?
                        LD HL, Address? & 0xFFFF
                        LD BC, Length?  & 0xFFFF
                        CALL Copy
                        endm
FT_Printf               macro Source?, Destination?
                        LD HL, Source?
                        LD DE, Destination?
                        CALL Utils_Printf
                        LD A, (Utils_Printf.Length)
                        LD B, #00
                        LD C, A
                        LD HL, Destination?
                        CALL Copy
                        endm
FT_CMD_Command_DEBC_M   macro 
                        LD HL, (FT.Coprocessor.BufferPtr)
                        LD (HL), C
                        INC HL
                        LD (HL), B
                        INC HL
                        LD (HL), E
                        INC HL
                        LD (HL), D
                        INC HL
                        LD (FT.Coprocessor.BufferPtr), HL
                        endm

                        endif ; ~_COPROCESSOR_BUFFER_MACRO_
