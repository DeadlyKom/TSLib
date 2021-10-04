Scale           EQU 2

                FT_CLEAR_COLOR_RGB 0, 0, 0
                FT_CLEAR 1, 1, 1

                FT_BITMAP_HANDLE 0
                FT_BITMAP_SOURCE Tileset_RAM_G
                FT_BITMAP_LAYOUT_H Tileset_Stride, Tileset_Height
                FT_BITMAP_LAYOUT Tileset_Format, Tileset_Stride, Tileset_Height
                FT_BITMAP_SIZE_H 16 * 16, 12 * 16
                FT_BITMAP_SIZE FT_NEAREST, FT_BORDER, FT_BORDER, 16 * 32, 16 * 24

                FT_BITMAP_TRANSFORM_A 128
                FT_BITMAP_TRANSFORM_B 0
                FT_BITMAP_TRANSFORM_C 0
                FT_BITMAP_TRANSFORM_D 0
                FT_BITMAP_TRANSFORM_E 128
                FT_BITMAP_TRANSFORM_F 0

                FT_VERTEX_TRANSLATE_X 8192

                FT_BEGIN FT_BITMAPS
.Y              defl 0
                rept 12
.X              defl 0
                rept 16
                FT_VERTEX2II Tileset_Width * Scale * .X, Tileset_Width * Scale * .Y, 0, 0
.X              = .X + 1
                endr
.Y              = .Y + 1
                endr


                FT_END

                FT_DISPLAY

