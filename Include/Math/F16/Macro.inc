
LoadInt_HL      macro Value?

.Value          defl Value?
.Sign           defl 0
.Exp            defl BIAS
.Mantisa        defl 0

                ; sign
                if .Value <? 0
.Sign           = 1 << SIGN_POS
.Value          = -1 * .Value
                endif

                ; mantisa
.Mantisa_tmp    defl .Value

                while (.Mantisa_tmp >> 1)
.Bit            = .Mantisa_tmp & 0x01
.Mantisa_tmp    = .Mantisa_tmp >> 1
.Exp            = .Exp + 1
.Mantisa        = .Mantisa >> 1 | .Bit << 7
                endw

.Exp            = .Exp << 8
                LD HL, .Sign | (.Exp & MASK_EXP) | .Mantisa
                endm

LoadInt_DE      macro Value?

.Value          defl Value?
.Sign           defl 0
.Exp            defl BIAS
.Mantisa        defl 0

                ; sign
                if .Value <? 0
.Sign           = 1 << SIGN_POS
.Value          = -1 * .Value
                endif

                ; mantisa
.Mantisa_tmp    defl .Value

                while (.Mantisa_tmp >> 1)
.Bit            = .Mantisa_tmp & 0x01
.Mantisa_tmp    = .Mantisa_tmp >> 1
.Exp            = .Exp + 1
.Mantisa        = .Mantisa >> 1 | .Bit << 7
                endw

.Exp            = .Exp << 8
                LD DE, .Sign | (.Exp & MASK_EXP) | .Mantisa
                endm

LoadInt_BC      macro Value?

.Value          defl Value?
.Sign           defl 0
.Exp            defl BIAS
.Mantisa        defl 0

                ; sign
                if .Value <? 0
.Sign           = 1 << SIGN_POS
.Value          = -1 * .Value
                endif

                ; mantisa
.Mantisa_tmp    defl .Value

                while (.Mantisa_tmp >> 1)
.Bit            = .Mantisa_tmp & 0x01
.Mantisa_tmp    = .Mantisa_tmp >> 1
.Exp            = .Exp + 1
.Mantisa        = .Mantisa >> 1 | .Bit << 7
                endw

.Exp            = .Exp << 8
                LD BC, .Sign | (.Exp & MASK_EXP) | .Mantisa
                endm
; LoadFloat       macro Value?, Exponent?

; .Value          defl Value?
; .Sign           defl 0
; .Exp            defl BIAS + Exponent?
; .Mantisa        defl 0

;                 ; sign
;                 if .Value <? 0
; .Sign           = 1 << SIGN_POS
; .Value          = -1 * .Value
;                 endif

;                 if Exponent? <? 0

;                 endif


; .Mantisa          = .Value * 10 ^ Exponent?

;                 LD HL, .Sign + (.Exp & MASK_EXP) + .Mantisa
;                 endm
