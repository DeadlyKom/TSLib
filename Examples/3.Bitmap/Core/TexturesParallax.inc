
Parallax_FTRAM_A        EQU FT_RAM_G
Parallax_Format_A       EQU FT_RGB332
Parallax_Width_A        EQU 256
Parallax_Height_A       EQU 192
Parallax_Stride_A       EQU 256
Parallax_Size_A         EQU 3712                ; #1000
Parallax_RealSize_A     EQU 49152
Parallax_Page_A         EQU 16
Parallax_RAM_A          EQU #D600

Parallax_FTRAM_9        EQU Parallax_FTRAM_A +  Parallax_RealSize_A
Parallax_Format_9       EQU FT_ARGB1555
Parallax_Width_9        EQU 256
Parallax_Height_9       EQU 192
Parallax_Stride_9       EQU 512
Parallax_Size_9         EQU 19405               ; #4C00
Parallax_RealSize_9     EQU 98304
Parallax_Page_9         EQU 15
Parallax_RAM_9          EQU #CA00

Parallax_FTRAM_8        EQU Parallax_FTRAM_9 + Parallax_RealSize_9
Parallax_Format_8       EQU FT_ARGB1555
Parallax_Width_8        EQU 256
Parallax_Height_8       EQU 192
Parallax_Stride_8       EQU 512
Parallax_Size_8         EQU 16647               ; #4200
Parallax_RealSize_8     EQU 98304
Parallax_Page_8         EQU 14
Parallax_RAM_8          EQU #C800

Parallax_FTRAM_7        EQU Parallax_FTRAM_8 + Parallax_RealSize_8
Parallax_Format_7       EQU FT_ARGB1555
Parallax_Width_7        EQU 256
Parallax_Height_7       EQU 192
Parallax_Stride_7       EQU 512
Parallax_Size_7         EQU 17845               ; #4600
Parallax_RealSize_7     EQU 98304
Parallax_Page_7         EQU 13
Parallax_RAM_7          EQU #C200

Parallax_FTRAM_6        EQU Parallax_FTRAM_7 + Parallax_RealSize_7
Parallax_Format_6       EQU FT_ARGB1555
Parallax_Width_6        EQU 256
Parallax_Height_6       EQU 192
Parallax_Stride_6       EQU 512
Parallax_Size_6         EQU 20149               ; #5000
Parallax_RealSize_6     EQU 98304
Parallax_Page_6         EQU 11
Parallax_RAM_6          EQU #F200

Parallax_FTRAM_5        EQU Parallax_FTRAM_6 + Parallax_RealSize_6
Parallax_Format_5       EQU FT_ARGB1555
Parallax_Width_5        EQU 256
Parallax_Height_5       EQU 192
Parallax_Stride_5       EQU 512
Parallax_Size_5         EQU 861                 ; #0400
Parallax_RealSize_5     EQU 98304
Parallax_Page_5         EQU 11
Parallax_RAM_5          EQU #EE00

Parallax_FTRAM_4        EQU Parallax_FTRAM_5 + Parallax_RealSize_5
Parallax_Format_4       EQU FT_ARGB1555
Parallax_Width_4        EQU 256
Parallax_Height_4       EQU 192
Parallax_Stride_4       EQU 512
Parallax_Size_4         EQU 16945               ; #4400
Parallax_RealSize_4     EQU 98304
Parallax_Page_4         EQU 10
Parallax_RAM_4          EQU #EA00

Parallax_FTRAM_3        EQU Parallax_FTRAM_4 + Parallax_RealSize_4
Parallax_Format_3       EQU FT_ARGB1555
Parallax_Width_3        EQU 256
Parallax_Height_3       EQU 192
Parallax_Stride_3       EQU 512
Parallax_Size_3         EQU 890                 ; #0400
Parallax_RealSize_3     EQU 98304
Parallax_Page_3         EQU 10
Parallax_RAM_3          EQU #E600

Parallax_FTRAM_2        EQU Parallax_FTRAM_3 + Parallax_RealSize_3
Parallax_Format_2       EQU FT_ARGB1555
Parallax_Width_2        EQU 256
Parallax_Height_2       EQU 192
Parallax_Stride_2       EQU 512
Parallax_Size_2         EQU 3490                ; #0E00
Parallax_RealSize_2     EQU 98304
Parallax_Page_2         EQU 10
Parallax_RAM_2          EQU #D800

Parallax_FTRAM_1        EQU Parallax_FTRAM_2 + Parallax_RealSize_2
Parallax_Format_1       EQU FT_ARGB1555
Parallax_Width_1        EQU 256
Parallax_Height_1       EQU 192
Parallax_Stride_1       EQU 512
Parallax_Size_1         EQU 5853                ; #1800
Parallax_RealSize_1     EQU 98304
Parallax_Page_1         EQU 10
Parallax_RAM_1          EQU #C000