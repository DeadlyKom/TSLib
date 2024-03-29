; Align to 256-byte page boundary
                align 256

; #define MAX_NUMBER 255
; #define TOP_BIT 0x8000
; #define PRICTI 0x3F
; #define POSUN_VPRAVO 7
; #define POCET_BITU 8

; // 1000 0000  0... ....  
; //              11 1111  
; //  765 4321  0... ....   

; //       neni presne: 31568 (48.168945%), preteceni: 31568, podteceni: 0
; // neni zaokrouhleno: 0 (0.000000%), preteceni: 0, podteceni: 0
; // sum(tab_dif[]): -130, sum(abs(tab_dif[])): 192
; // (( 256 + a ) * ( 256 + b )) >> 6 = (tab_plus[a+b] - tab_minus[a-b]) >> 6 = (1m mmmm mmm.) OR (01 mmmm mmmm)
; // 0 <= a <= 255, 0 <= b <= 255

; tab_minus je zvyseno o #FE0, a tab_plus zase snizeno o #FE0
; (ApB)+(AmB) >= #8000 => pricti: #20
; (ApB)+(AmB) >= #4000 => pricti: #0

TAB_AmB_lo:	    ; #FE0 - tab_minus[i]
                ;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
                DB #e0,#e0,#df,#e0,#de,#df,#dd,#dd,#dc,#db,#da,#d8,#d7,#d5,#d4,#d1   ; 0_     fe0,fe0,fdf,fe0,fde,fdf,fdd,fdd,fdc,fdb,fda,fd8,fd7,fd5,fd4,fd1 0_
                DB #d1,#ce,#cc,#cb,#c7,#c4,#c2,#c0,#bc,#b9,#b6,#b4,#af,#ab,#a8,#a4   ; 1_     fd1,fce,fcc,fcb,fc7,fc4,fc2,fc0,fbc,fb9,fb6,fb4,faf,fab,fa8,fa4 1_
                DB #a0,#9c,#98,#92,#8f,#8c,#86,#82,#7c,#77,#72,#6c,#67,#61,#5b,#55   ; 2_     fa0,f9c,f98,f92,f8f,f8c,f86,f82,f7c,f77,f72,f6c,f67,f61,f5b,f55 2_
                DB #51,#4b,#44,#3e,#37,#31,#2a,#23,#1c,#14,#0e,#06,#ff,#f7,#f0,#e8   ; 3_     f51,f4b,f44,f3e,f37,f31,f2a,f23,f1c,f14,f0e,f06,eff,ef7,ef0,ee8 3_
                DB #e0,#d7,#d0,#c8,#bf,#b6,#ae,#a5,#9c,#91,#8a,#81,#77,#6d,#64,#59   ; 4_     ee0,ed7,ed0,ec8,ebf,eb6,eae,ea5,e9c,e91,e8a,e81,e77,e6d,e64,e59 4_
                DB #51,#45,#3b,#33,#27,#1c,#12,#07,#fc,#f2,#e6,#da,#cf,#c3,#b8,#ab   ; 5_     e51,e45,e3b,e33,e27,e1c,e12,e07,dfc,df2,de6,dda,dcf,dc3,db8,dab 5_
                DB #a0,#92,#88,#7c,#6f,#62,#56,#4a,#3c,#2f,#22,#13,#07,#fa,#ec,#de   ; 6_     da0,d92,d88,d7c,d6f,d62,d56,d4a,d3c,d2f,d22,d13,d07,cfa,cec,cde 6_
                DB #d1,#c2,#b4,#a6,#97,#89,#7a,#6a,#5c,#4d,#3e,#2e,#1e,#0f,#00,#f0   ; 7_     cd1,cc2,cb4,ca6,c97,c89,c7a,c6a,c5c,c4d,c3e,c2e,c1e,c0f,c00,bf0 7_
                DB #e0,#d0,#c0,#b1,#9e,#8e,#7e,#6d,#5c,#4c,#3a,#29,#17,#05,#f4,#e2   ; 8_     be0,bd0,bc0,bb1,b9e,b8e,b7e,b6d,b5c,b4c,b3a,b29,b17,b05,af4,ae2 8_
                DB #d1,#bf,#ac,#99,#87,#75,#62,#4f,#3c,#29,#16,#03,#ef,#dc,#c8,#b5   ; 9_     ad1,abf,aac,a99,a87,a75,a62,a4f,a3c,a29,a16,a03,9ef,9dc,9c8,9b5 9_
                DB #a0,#8d,#78,#64,#4f,#3b,#26,#11,#fc,#e7,#d2,#bd,#a7,#91,#7b,#66   ; A_     9a0,98d,978,964,94f,93b,926,911,8fc,8e7,8d2,8bd,8a7,891,87b,866 A_
                DB #51,#3a,#24,#0e,#f7,#e1,#ca,#b4,#9c,#85,#6e,#56,#3f,#28,#10,#f8   ; B_     851,83a,824,80e,7f7,7e1,7ca,7b4,79c,785,76e,756,73f,728,710,6f8 B_
                DB #e0,#c8,#b0,#98,#7f,#67,#4e,#35,#1c,#03,#ea,#d1,#b7,#9e,#84,#69   ; C_     6e0,6c8,6b0,698,67f,667,64e,635,61c,603,5ea,5d1,5b7,59e,584,569 C_
                DB #50,#36,#1c,#02,#e7,#cd,#b2,#97,#7c,#61,#46,#2b,#0f,#f4,#d8,#bc   ; D_     550,536,51c,502,4e7,4cd,4b2,497,47c,461,446,42b,40f,3f4,3d8,3bc D_
                DB #a0,#84,#68,#4c,#2f,#14,#f6,#d9,#bc,#9f,#82,#65,#47,#2a,#0c,#ee   ; E_     3a0,384,368,34c,32f,314,2f6,2d9,2bc,29f,282,265,247,22a,20c,1ee E_
                DB #d0,#b2,#94,#76,#57,#39,#1a,#fb,#dc,#bd,#9e,#7f,#5f,#40,#20,#00   ; F_     1d0,1b2,194,176,157,139,11a, fb, dc, bd, 9e, 7f, 5f, 40, 20, 00 F_
                ;Tab_AmB_hi:	; #FE0 - tab_minus[i]
                ;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
                DB #0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f   ; 0_
                DB #0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f   ; 1_
                DB #0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f   ; 2_
                DB #0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0f,#0e,#0e,#0e,#0e   ; 3_
                DB #0e,#0e,#0e,#0e,#0e,#0e,#0e,#0e,#0e,#0e,#0e,#0e,#0e,#0e,#0e,#0e   ; 4_
                DB #0e,#0e,#0e,#0e,#0e,#0e,#0e,#0e,#0d,#0d,#0d,#0d,#0d,#0d,#0d,#0d   ; 5_
                DB #0d,#0d,#0d,#0d,#0d,#0d,#0d,#0d,#0d,#0d,#0d,#0d,#0d,#0c,#0c,#0c   ; 6_
                DB #0c,#0c,#0c,#0c,#0c,#0c,#0c,#0c,#0c,#0c,#0c,#0c,#0c,#0c,#0c,#0b   ; 7_
                DB #0b,#0b,#0b,#0b,#0b,#0b,#0b,#0b,#0b,#0b,#0b,#0b,#0b,#0b,#0a,#0a   ; 8_
                DB #0a,#0a,#0a,#0a,#0a,#0a,#0a,#0a,#0a,#0a,#0a,#0a,#09,#09,#09,#09   ; 9_
                DB #09,#09,#09,#09,#09,#09,#09,#09,#08,#08,#08,#08,#08,#08,#08,#08   ; A_
                DB #08,#08,#08,#08,#07,#07,#07,#07,#07,#07,#07,#07,#07,#07,#07,#06   ; B_
                DB #06,#06,#06,#06,#06,#06,#06,#06,#06,#06,#05,#05,#05,#05,#05,#05   ; C_
                DB #05,#05,#05,#05,#04,#04,#04,#04,#04,#04,#04,#04,#04,#03,#03,#03   ; D_
                DB #03,#03,#03,#03,#03,#03,#02,#02,#02,#02,#02,#02,#02,#02,#02,#01   ; E_
                DB #01,#01,#01,#01,#01,#01,#01,#00,#00,#00,#00,#00,#00,#00,#00,#00   ; F_

TAB_ApB_lo_1:	; tab_plus[i] - #FE0
                ;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
                DB #3f,#9f,#00,#5f,#c0,#20,#82,#e2,#43,#a4,#05,#66,#c8,#2a,#8b,#ec   ; 0_     803f,809f,8100,815f,81c0,8220,8282,82e2,8343,83a4,8405,8466,84c8,852a,858b,85ec 0_
                DB #4f,#b2,#13,#77,#d8,#3b,#9d,#00,#63,#c7,#29,#8c,#f0,#53,#b7,#1c   ; 1_     864f,86b2,8713,8777,87d8,883b,889d,8900,8963,89c7,8a29,8a8c,8af0,8b53,8bb7,8c1c 1_
                DB #7f,#e3,#47,#ab,#10,#76,#d9,#3e,#a3,#09,#6d,#d2,#38,#9e,#04,#69   ; 2_     8c7f,8ce3,8d47,8dab,8e10,8e76,8ed9,8f3e,8fa3,9009,906d,90d2,9138,919e,9204,9269 2_
                DB #cf,#35,#9b,#02,#68,#cf,#35,#9d,#03,#6a,#d1,#38,#a0,#09,#6f,#d7   ; 3_     92cf,9335,939b,9402,9468,94cf,9535,959d,9603,966a,96d1,9738,97a0,9809,986f,98d7 3_
                DB #3f,#a7,#0f,#78,#e0,#48,#b1,#1b,#83,#ec,#55,#be,#28,#92,#fb,#65   ; 4_     993f,99a7,9a0f,9a78,9ae0,9b48,9bb1,9c1b,9c83,9cec,9d55,9dbe,9e28,9e92,9efb,9f65 4_
                DB #cf,#39,#a4,#0f,#78,#e2,#4d,#b8,#23,#8f,#f9,#64,#d0,#3c,#a7,#13   ; 5_     9fcf,a039,a0a4,a10f,a178,a1e2,a24d,a2b8,a323,a38f,a3f9,a464,a4d0,a53c,a5a7,a613 5_
                DB #7f,#eb,#57,#c4,#30,#9d,#09,#76,#e3,#51,#bd,#2a,#98,#07,#73,#e1   ; 6_     a67f,a6eb,a757,a7c4,a830,a89d,a909,a976,a9e3,aa51,aabd,ab2a,ab98,ac07,ac73,ace1 6_
                DB #4f,#bd,#2b,#9b,#08,#76,#e5,#53,#c3,#32,#a1,#10,#81,#f0,#5f,#cf   ; 7_     ad4f,adbd,ae2b,ae9b,af08,af76,afe5,b053,b0c3,b132,b1a1,b210,b281,b2f0,b35f,b3cf 7_
                DB #3f,#af,#1f,#8f,#01,#70,#e1,#52,#c3,#35,#a5,#16,#88,#f9,#6b,#dd   ; 8_     b43f,b4af,b51f,b58f,b601,b670,b6e1,b752,b7c3,b835,b8a5,b916,b988,b9f9,ba6b,badd 8_
                DB #4f,#c1,#33,#a5,#18,#8b,#fd,#70,#e3,#56,#c9,#3d,#b0,#23,#97,#0b   ; 9_     bb4f,bbc1,bc33,bca5,bd18,bd8b,bdfd,be70,bee3,bf56,bfc9,c03d,c0b0,c123,c197,c20b 9_
                DB #7f,#f4,#67,#db,#50,#c4,#39,#ae,#23,#98,#0d,#83,#f8,#6d,#e4,#5a   ; A_     c27f,c2f4,c367,c3db,c450,c4c4,c539,c5ae,c623,c698,c70d,c783,c7f8,c86d,c8e4,c95a A_
                DB #cf,#45,#bb,#31,#a8,#1e,#95,#0c,#83,#fa,#71,#e9,#60,#d7,#4f,#c7   ; B_     c9cf,ca45,cabb,cb31,cba8,cc1e,cc95,cd0c,cd83,cdfa,ce71,cee9,cf60,cfd7,d04f,d0c7 B_
                DB #3f,#b7,#2f,#a7,#20,#98,#11,#8b,#03,#7c,#f5,#6e,#e8,#61,#db,#55   ; C_     d13f,d1b7,d22f,d2a7,d320,d398,d411,d48b,d503,d57c,d5f5,d66e,d6e8,d761,d7db,d855 C_
                DB #cf,#49,#c3,#3d,#b8,#32,#ad,#28,#a3,#1e,#99,#14,#90,#0b,#87,#03   ; D_     d8cf,d949,d9c3,da3d,dab8,db32,dbad,dc28,dca3,dd1e,dd99,de14,de90,df0b,df87,e003 D_
                DB #7f,#fb,#77,#f3,#70,#ec,#69,#e6,#63,#e0,#5d,#da,#58,#d5,#53,#d1   ; E_     e07f,e0fb,e177,e1f3,e270,e2ec,e369,e3e6,e463,e4e0,e55d,e5da,e658,e6d5,e753,e7d1 E_
                DB #4f,#cd,#4b,#c9,#48,#c6,#45,#c4,#43,#c2,#41,#c0,#40,#bf,#3f,#00   ; F_     e84f,e8cd,e94b,e9c9,ea48,eac6,eb45,ebc4,ec43,ecc2,ed41,edc0,ee40,eebf,ef3f,  00 F_
                ;Tab_ApB_hi_1:	; tab_plus[i] - #FE0
                ;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
                DB #80,#80,#81,#81,#81,#82,#82,#82,#83,#83,#84,#84,#84,#85,#85,#85   ; 0_
                DB #86,#86,#87,#87,#87,#88,#88,#89,#89,#89,#8a,#8a,#8a,#8b,#8b,#8c   ; 1_
                DB #8c,#8c,#8d,#8d,#8e,#8e,#8e,#8f,#8f,#90,#90,#90,#91,#91,#92,#92   ; 2_
                DB #92,#93,#93,#94,#94,#94,#95,#95,#96,#96,#96,#97,#97,#98,#98,#98   ; 3_
                DB #99,#99,#9a,#9a,#9a,#9b,#9b,#9c,#9c,#9c,#9d,#9d,#9e,#9e,#9e,#9f   ; 4_
                DB #9f,#a0,#a0,#a1,#a1,#a1,#a2,#a2,#a3,#a3,#a3,#a4,#a4,#a5,#a5,#a6   ; 5_
                DB #a6,#a6,#a7,#a7,#a8,#a8,#a9,#a9,#a9,#aa,#aa,#ab,#ab,#ac,#ac,#ac   ; 6_
                DB #ad,#ad,#ae,#ae,#af,#af,#af,#b0,#b0,#b1,#b1,#b2,#b2,#b2,#b3,#b3   ; 7_
                DB #b4,#b4,#b5,#b5,#b6,#b6,#b6,#b7,#b7,#b8,#b8,#b9,#b9,#b9,#ba,#ba   ; 8_
                DB #bb,#bb,#bc,#bc,#bd,#bd,#bd,#be,#be,#bf,#bf,#c0,#c0,#c1,#c1,#c2   ; 9_
                DB #c2,#c2,#c3,#c3,#c4,#c4,#c5,#c5,#c6,#c6,#c7,#c7,#c7,#c8,#c8,#c9   ; A_
                DB #c9,#ca,#ca,#cb,#cb,#cc,#cc,#cd,#cd,#cd,#ce,#ce,#cf,#cf,#d0,#d0   ; B_
                DB #d1,#d1,#d2,#d2,#d3,#d3,#d4,#d4,#d5,#d5,#d5,#d6,#d6,#d7,#d7,#d8   ; C_
                DB #d8,#d9,#d9,#da,#da,#db,#db,#dc,#dc,#dd,#dd,#de,#de,#df,#df,#e0   ; D_
                DB #e0,#e0,#e1,#e1,#e2,#e2,#e3,#e3,#e4,#e4,#e5,#e5,#e6,#e6,#e7,#e7   ; E_
                DB #e8,#e8,#e9,#e9,#ea,#ea,#eb,#eb,#ec,#ec,#ed,#ed,#ee,#ee,#ef,#00   ; F_
TAB_ApB_lo_0:	; tab_plus[i] - #FE0
                ;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
                DB #3f,#7f,#bf,#ff,#40,#80,#c1,#02,#43,#84,#c5,#06,#48,#89,#cb,#0d   ; 0_     303f,307f,30bf,30ff,3140,3180,31c1,3202,3243,3284,32c5,3306,3348,3389,33cb,340d 0_
                DB #4f,#91,#d3,#15,#58,#9a,#dd,#20,#63,#a6,#e9,#2c,#70,#b3,#f7,#3c   ; 1_     344f,3491,34d3,3515,3558,359a,35dd,3620,3663,36a6,36e9,372c,3770,37b3,37f7,383c 1_
                DB #7f,#c3,#07,#4b,#90,#d5,#19,#5e,#a3,#e8,#2d,#72,#b8,#fd,#44,#89   ; 2_     387f,38c3,3907,394b,3990,39d5,3a19,3a5e,3aa3,3ae8,3b2d,3b72,3bb8,3bfd,3c44,3c89 2_
                DB #cf,#15,#5b,#a1,#e8,#2f,#75,#bc,#03,#4a,#91,#d8,#21,#68,#b0,#f7   ; 3_     3ccf,3d15,3d5b,3da1,3de8,3e2f,3e75,3ebc,3f03,3f4a,3f91,3fd8,4021,4068,40b0,40f7 3_
                DB #3f,#87,#cf,#18,#61,#a9,#f1,#3a,#83,#cb,#15,#5f,#a8,#f2,#3b,#85   ; 4_     413f,4187,41cf,4218,4261,42a9,42f1,433a,4383,43cb,4415,445f,44a8,44f2,453b,4585 4_
                DB #cf,#19,#64,#af,#f8,#42,#8d,#d8,#23,#6f,#b9,#04,#50,#9c,#e7,#33   ; 5_     45cf,4619,4664,46af,46f8,4742,478d,47d8,4823,486f,48b9,4904,4950,499c,49e7,4a33 5_
                DB #7f,#cb,#17,#64,#b0,#fd,#49,#96,#e3,#30,#7d,#ca,#18,#67,#b3,#01   ; 6_     4a7f,4acb,4b17,4b64,4bb0,4bfd,4c49,4c96,4ce3,4d30,4d7d,4dca,4e18,4e67,4eb3,4f01 6_
                DB #4f,#9e,#eb,#3b,#88,#d6,#25,#73,#c3,#13,#62,#b0,#00,#4f,#a0,#ef   ; 7_     4f4f,4f9e,4feb,503b,5088,50d6,5125,5173,51c3,5213,5262,52b0,5300,534f,53a0,53ef 7_
                DB #3f,#8f,#e0,#30,#80,#d1,#22,#72,#c3,#15,#65,#b6,#08,#59,#ab,#fd   ; 8_     543f,548f,54e0,5530,5580,55d1,5622,5672,56c3,5715,5765,57b6,5808,5859,58ab,58fd 8_
                DB #4f,#a1,#f3,#45,#98,#ec,#3d,#90,#e3,#35,#89,#dd,#30,#83,#d7,#2d   ; 9_     594f,59a1,59f3,5a45,5a98,5aec,5b3d,5b90,5be3,5c35,5c89,5cdd,5d30,5d83,5dd7,5e2d 9_
                DB #7f,#d4,#27,#7c,#d0,#25,#79,#cd,#23,#78,#cd,#23,#78,#cc,#24,#7a   ; A_     5e7f,5ed4,5f27,5f7c,5fd0,6025,6079,60cd,6123,6178,61cd,6223,6278,62cc,6324,637a A_
                DB #cf,#26,#7b,#d2,#28,#7e,#d5,#2e,#83,#da,#31,#89,#e1,#37,#8f,#e8   ; B_     63cf,6426,647b,64d2,6528,657e,65d5,662e,6683,66da,6731,6789,67e1,6837,688f,68e8 B_
                DB #3f,#97,#ef,#48,#a1,#f9,#51,#ab,#03,#5c,#b5,#0e,#68,#c1,#1b,#74   ; C_     693f,6997,69ef,6a48,6aa1,6af9,6b51,6bab,6c03,6c5c,6cb5,6d0e,6d68,6dc1,6e1b,6e74 C_
                DB #cf,#2a,#84,#de,#38,#93,#ed,#48,#a3,#ff,#59,#b5,#10,#6b,#c7,#23   ; D_     6ecf,6f2a,6f84,6fde,7038,7093,70ed,7148,71a3,71ff,7259,72b5,7310,736b,73c7,7423 D_
                DB #7f,#db,#37,#93,#f0,#4f,#a9,#07,#63,#c0,#1d,#7b,#d8,#35,#93,#f1   ; E_     747f,74db,7537,7593,75f0,764f,76a9,7707,7763,77c0,781d,787b,78d8,7935,7993,79f1 E_
                DB #4f,#ac,#0b,#69,#c8,#27,#85,#e4,#43,#a2,#02,#60,#c0,#1f,#80,#e0   ; F_     7a4f,7aac,7b0b,7b69,7bc8,7c27,7c85,7ce4,7d43,7da2,7e02,7e60,7ec0,7f1f,7f80,7fe0 F_
                ;Tab_ApB_hi_0:	; tab_plus[i] - #FE0
                ;   _0  _1  _2  _3  _4  _5  _6  _7  _8  _9  _A  _B  _C  _D  _E  _F
                DB #30,#30,#30,#30,#31,#31,#31,#32,#32,#32,#32,#33,#33,#33,#33,#34   ; 0_
                DB #34,#34,#34,#35,#35,#35,#35,#36,#36,#36,#36,#37,#37,#37,#37,#38   ; 1_
                DB #38,#38,#39,#39,#39,#39,#3a,#3a,#3a,#3a,#3b,#3b,#3b,#3b,#3c,#3c   ; 2_
                DB #3c,#3d,#3d,#3d,#3d,#3e,#3e,#3e,#3f,#3f,#3f,#3f,#40,#40,#40,#40   ; 3_
                DB #41,#41,#41,#42,#42,#42,#42,#43,#43,#43,#44,#44,#44,#44,#45,#45   ; 4_
                DB #45,#46,#46,#46,#46,#47,#47,#47,#48,#48,#48,#49,#49,#49,#49,#4a   ; 5_
                DB #4a,#4a,#4b,#4b,#4b,#4b,#4c,#4c,#4c,#4d,#4d,#4d,#4e,#4e,#4e,#4f   ; 6_
                DB #4f,#4f,#4f,#50,#50,#50,#51,#51,#51,#52,#52,#52,#53,#53,#53,#53   ; 7_
                DB #54,#54,#54,#55,#55,#55,#56,#56,#56,#57,#57,#57,#58,#58,#58,#58   ; 8_
                DB #59,#59,#59,#5a,#5a,#5a,#5b,#5b,#5b,#5c,#5c,#5c,#5d,#5d,#5d,#5e   ; 9_
                DB #5e,#5e,#5f,#5f,#5f,#60,#60,#60,#61,#61,#61,#62,#62,#62,#63,#63   ; A_
                DB #63,#64,#64,#64,#65,#65,#65,#66,#66,#66,#67,#67,#67,#68,#68,#68   ; B_
                DB #69,#69,#69,#6a,#6a,#6a,#6b,#6b,#6c,#6c,#6c,#6d,#6d,#6d,#6e,#6e   ; C_
                DB #6e,#6f,#6f,#6f,#70,#70,#70,#71,#71,#71,#72,#72,#73,#73,#73,#74   ; D_
                DB #74,#74,#75,#75,#75,#76,#76,#77,#77,#77,#78,#78,#78,#79,#79,#79   ; E_
                DB #7a,#7a,#7b,#7b,#7b,#7c,#7c,#7c,#7d,#7d,#7e,#7e,#7e,#7f,#7f,#7f   ; F_

; nic nemusi: 25482(38.882446%), musi pricitat #20: 40054(61.117554%), pretece pricteni: 0
; neni presne: 0 (0.000000%), chyb: 0, sum: 65536