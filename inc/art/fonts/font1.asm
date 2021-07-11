;==============================================================
; GRAPHICS TILES
;==============================================================
; The 8x8 pixel graphics tiles that describe the font.
; 'SPACE' is first, which is unneccessary but it's a good teaching tool for
; why we leave the first tile in memory blank (try changing it
; and see what happens!).
;==============================================================
; 0 = transparent pixel
; 2 = colour 'white' in our palette (see palette above)
;==============================================================
; Change all of the 2's to 3, 4 or 5 to draw the text in red, blue
; or green (see the palette above).
;==============================================================

PixelFont: ; Font start address

	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$10000010
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$11101110
	dc.l	$00000000
	
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$10000110
	dc.l	$11111100
	dc.l	$00000000
	
	dc.l	$01111110
	dc.l	$11000010
	dc.l	$10111110
	dc.l	$10100000
	dc.l	$10111110
	dc.l	$11000010
	dc.l	$01111110
	dc.l	$00000000
	
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$10000110
	dc.l	$11111100
	dc.l	$00000000
	
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$10111110
	dc.l	$10001000
	dc.l	$10111110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$10111110
	dc.l	$10001000
	dc.l	$10111000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$00000000
	
	dc.l	$01111110
	dc.l	$11000010
	dc.l	$10111110
	dc.l	$10100010
	dc.l	$10111010
	dc.l	$11000010
	dc.l	$01111110
	dc.l	$00000000
	
	dc.l	$11101110
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$10000010
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$11101110
	dc.l	$00000000
	
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$11101110
	dc.l	$00101000
	dc.l	$11101110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	
	dc.l	$00001110
	dc.l	$00001010
	dc.l	$00001010
	dc.l	$11101010
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	
	dc.l	$11101110
	dc.l	$10111010
	dc.l	$10110110
	dc.l	$10001100
	dc.l	$10110110
	dc.l	$10111010
	dc.l	$11101110
	dc.l	$00000000

	dc.l	$11100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$10111110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	
	dc.l	$11101110
	dc.l	$10111010
	dc.l	$10010010
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$11101110
	dc.l	$00000000
	
	dc.l	$11101110
	dc.l	$10111010
	dc.l	$10011010
	dc.l	$10101010
	dc.l	$10110010
	dc.l	$10111010
	dc.l	$11101110
	dc.l	$00000000

	dc.l	$01111100
	dc.l	$01000100
	dc.l	$11111110
	dc.l	$10011010
	dc.l	$10101010
	dc.l	$10110010
	dc.l	$11111110
	dc.l	$00000000
	
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$10000110
	dc.l	$10111100
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$00000000
	
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$10110110
	dc.l	$11001010
	dc.l	$01111110
	dc.l	$00000000
	
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$10000110
	dc.l	$10110110
	dc.l	$10111010
	dc.l	$11101110
	dc.l	$00000000
	
	dc.l	$01111110
	dc.l	$11000010
	dc.l	$10111110
	dc.l	$11000110
	dc.l	$11111010
	dc.l	$10000110
	dc.l	$11111100
	dc.l	$00000000
	
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$11101110
	dc.l	$00101000
	dc.l	$00101000
	dc.l	$00101000
	dc.l	$00111000
	dc.l	$00000000
	
	dc.l	$11101110
	dc.l	$10101010
	dc.l	$10101010
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	
	dc.l	$11101110
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$11010110
	dc.l	$01010100
	dc.l	$01101100
	dc.l	$00111000
	dc.l	$00000000
	
	dc.l	$11101110
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$10101010
	dc.l	$10010010
	dc.l	$10111010
	dc.l	$11101110
	dc.l	$00000000
	
	dc.l	$11101110
	dc.l	$10111010
	dc.l	$11010110
	dc.l	$01101100
	dc.l	$11010110
	dc.l	$10111010
	dc.l	$11101110
	dc.l	$00000000
	
	dc.l	$11101110
	dc.l	$10111010
	dc.l	$11010110
	dc.l	$01101100
	dc.l	$00101000
	dc.l	$00101000
	dc.l	$00111000
	dc.l	$00000000
	
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$11110110
	dc.l	$01101100
	dc.l	$11011110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10110010
	dc.l	$10101010
	dc.l	$10011010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	
	dc.l	$11110000
	dc.l	$10010000
	dc.l	$11010000
	dc.l	$01010000
	dc.l	$11011000
	dc.l	$10001000
	dc.l	$11111000
	dc.l	$00000000
	
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$11111010
	dc.l	$11000110
	dc.l	$10111110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	
	dc.l	$11111100
	dc.l	$10000110
	dc.l	$11111010
	dc.l	$00100110
	dc.l	$11111010
	dc.l	$10000110
	dc.l	$11111100
	dc.l	$00000000
	
	dc.l	$11101110
	dc.l	$10101010
	dc.l	$10111010
	dc.l	$10000010
	dc.l	$11111010
	dc.l	$00001010
	dc.l	$00001110
	dc.l	$00000000
	
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$10111110
	dc.l	$10000110
	dc.l	$11111010
	dc.l	$10000110
	dc.l	$11111100
	dc.l	$00000000
	
	dc.l	$01111100
	dc.l	$11000100
	dc.l	$10111100
	dc.l	$10000110
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$11111010
	dc.l	$00110110
	dc.l	$01101100
	dc.l	$01011000
	dc.l	$01110000
	dc.l	$00000000
	
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$11000110
	dc.l	$01111100
	dc.l	$00000000
	
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$11000010
	dc.l	$01111010
	dc.l	$01000110
	dc.l	$01111100
	dc.l	$00000000

	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$11000000
	dc.l	$11000000
	dc.l	$00000000
	
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$11100000
	
	dc.l	$01111100
	dc.l	$11000110
	dc.l	$10111010
	dc.l	$11100110
	dc.l	$00111100
	dc.l	$00101000
	dc.l	$00111000
	dc.l	$00000000
	
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$00000000
	
	dc.l	$01110000
	dc.l	$11010000
	dc.l	$10110000
	dc.l	$10100000
	dc.l	$10110000
	dc.l	$11010000
	dc.l	$01110000
	dc.l	$00000000
	
	dc.l	$11100000
	dc.l	$10110000
	dc.l	$11010000
	dc.l	$01010000
	dc.l	$11010000
	dc.l	$10110000
	dc.l	$11100000
	dc.l	$00000000
	
	dc.l	$11111000
	dc.l	$10101000
	dc.l	$10101000
	dc.l	$11111000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	
	dc.l	$00000000
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$10100000
	dc.l	$11100000
	dc.l	$00000000
	dc.l	$00000000
	
	dc.l	$01111100
	dc.l	$11010110
	dc.l	$10000010
	dc.l	$11010110
	dc.l	$10000010
	dc.l	$11010110
	dc.l	$01111100
	dc.l	$00000000
	
	dc.l	$00111000
	dc.l	$00101000
	dc.l	$11101110
	dc.l	$10000010
	dc.l	$11101110
	dc.l	$00101000
	dc.l	$00111000
	dc.l	$00000000
	
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$11111110
	dc.l	$10000010
	dc.l	$11111110
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	
	dc.l	$00011100
	dc.l	$00110100
	dc.l	$01101100
	dc.l	$11011000
	dc.l	$10110000
	dc.l	$11100000
	dc.l	$00000000
	dc.l	$00000000

PixelFontEnd                                 ; Font end address
PixelFontSizeB: equ (PixelFontEnd-PixelFont) ; Font size in bytes
PixelFontSizeW: equ (PixelFontSizeB/2)       ; Font size in words
PixelFontSizeL: equ (PixelFontSizeB/4)       ; Font size in longs
PixelFontSizeT: equ (PixelFontSizeB/32)      ; Font size in tiles
PixelFontVRAM:  equ 0x0020                   ; Dest address in VRAM
PixelFontTileID: equ (PixelFontVRAM/32)      ; ID of first tile

;==============================================================
; TILE IDs
;==============================================================
; The indices of each tile above. Once the tiles have been
; written to VRAM, the VDP refers to each tile by its index.
;==============================================================

tile_id_space	equ 0x0
tile_id_a		equ 0x1
tile_id_b		equ 0x2
tile_id_c		equ 0x3
tile_id_d		equ 0x4
tile_id_e		equ 0x5
tile_id_f		equ 0x6
tile_id_g		equ 0x7
tile_id_h		equ 0x8
tile_id_i		equ 0x9
tile_id_j		equ 0xA
tile_id_k		equ 0xB
tile_id_l		equ 0xC
tile_id_m		equ 0xD
tile_id_n		equ 0xE
tile_id_ene		equ 0xF
tile_id_o		equ 0x10
tile_id_p		equ 0x11
tile_id_q		equ 0x12
tile_id_r		equ 0x13
tile_id_s		equ 0x14
tile_id_t		equ 0x15
tile_id_u		equ 0x16
tile_id_v		equ 0x17
tile_id_w		equ 0x18
tile_id_x		equ 0x19
tile_id_y		equ 0x1A
tile_id_z		equ 0x1B
tile_id_0		equ 0x1C
tile_id_1		equ 0x1D
tile_id_2		equ 0x1E
tile_id_3		equ 0x1F
tile_id_4		equ 0x20
tile_id_5		equ 0x21
tile_id_6		equ 0x22
tile_id_7		equ 0x23
tile_id_8		equ 0x24
tile_id_9		equ 0x25
tile_id_point	equ 0x26
tile_id_comma	equ 0x27
tile_id_quest	equ 0x28
tile_id_exc		equ 0x29
tile_id_par1	equ 0x2A
tile_id_par2	equ 0x2B
tile_id_quo_d	equ 0x2C
tile_id_quo		equ 0x2D
tile_id_colon	equ 0x2E
tile_id_pad		equ 0x2F
tile_id_plus	equ 0x30
tile_id_sub		equ 0x31
tile_id_div		equ 0x32
tile_count		equ 0x33	; Last entry is just the count