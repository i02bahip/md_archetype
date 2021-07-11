;==============================================================
; INITIAL VDP REGISTER VALUES
;==============================================================
; 24 register values to be copied to the VDP during initialisation.
; These specify things like initial width/height of the planes,
; addresses within VRAM to find scroll/sprite data, the
; background palette/colour index, whether or not the display
; is on, and clears initial values for things like DMA.
;==============================================================
VDPRegisters:
	dc.b 0x14 ; 0x00:  H interrupt on, palettes on
	dc.b 0x74 ; 0x01:  V interrupt on, display on, DMA on, Genesis mode on
	dc.b 0x30 ; 0x02:  Pattern table for Scroll Plane A at VRAM 0xC000 (bits 3-5 = bits 13-15)
	dc.b 0x00 ; 0x03:  Pattern table for Window Plane at VRAM 0x0000 (disabled) (bits 1-5 = bits 11-15)
	dc.b 0x07 ; 0x04:  Pattern table for Scroll Plane B at VRAM 0xE000 (bits 0-2 = bits 11-15)
	dc.b 0x78 ; 0x05:  Sprite table at VRAM 0xF000 (bits 0-6 = bits 9-15)
	dc.b 0x00 ; 0x06:  Unused
	dc.b 0x00 ; 0x07:  Background colour: bits 0-3 = colour, bits 4-5 = palette
	dc.b 0x00 ; 0x08:  Unused
	dc.b 0x00 ; 0x09:  Unused
	dc.b 0x08 ; 0x0A: Frequency of Horiz. interrupt in Rasters (number of lines travelled by the beam)
	dc.b 0x00 ; 0x0B: External interrupts off, V scroll fullscreen, H scroll fullscreen
	dc.b 0x81 ; 0x0C: Shadows and highlights off, interlace off, H40 mode (320 x 224 screen res)
	dc.b 0x3F ; 0x0D: Horiz. scroll table at VRAM 0xFC00 (bits 0-5)
	dc.b 0x00 ; 0x0E: Unused
	dc.b 0x02 ; 0x0F: Autoincrement 2 bytes
	dc.b 0x01 ; 0x10: Scroll plane size: 64x32 tiles
	dc.b 0x00 ; 0x11: Window Plane X pos 0 left (pos in bits 0-4, left/right in bit 7)
	dc.b 0x00 ; 0x12: Window Plane Y pos 0 up (pos in bits 0-4, up/down in bit 7)
	dc.b 0xFF ; 0x13: DMA length lo byte
	dc.b 0xFF ; 0x14: DMA length hi byte
	dc.b 0x00 ; 0x15: DMA source address lo byte
	dc.b 0x00 ; 0x16: DMA source address mid byte
	dc.b 0x80 ; 0x17: DMA source address hi byte, memory-to-VRAM mode (bits 6-7)
	
	even
	
;==============================================================
; CONSTANTS
;==============================================================
; Defines names for commonly used values and addresses to make
; the code more readable.
;==============================================================
	
; VDP port addresses
vdp_control				equ 0x00C00004
vdp_data				equ 0x00C00000

; VDP commands
vdp_cmd_vram_write		equ 0x40000000
vdp_cmd_cram_write		equ 0xC0000000
vdp_cmd_vsram_write		equ 0x40000010	; NEW to this demo - Vertical Scroll RAM address

; VDP memory addresses
vram_addr_tiles			equ 0x0000
vram_addr_plane_a		equ 0xC000
vram_addr_plane_b		equ 0xE000
vram_addr_hscroll_a		equ 0xFC00
vram_addr_hscroll_b		equ 0xFC02
vram_addr_vscroll_a		equ 0x0000
vram_addr_vscroll_b		equ 0x0002
vram_addr_sprite_table	equ 0xF000

; Screen width and height (in pixels)
vdp_screen_width		equ 0x0140
vdp_screen_height		equ 0x00F0

; The plane width and height (in tiles)
; according to VDP register 0x10 (see table above)
vdp_plane_width			equ 0x40
vdp_plane_height		equ 0x20

; Hardware version address
hardware_ver_address	equ 0x00A10001

; TMSS
tmss_address			equ 0x00A14000
tmss_signature			equ 'SEGA'

; The size of a word and longword
size_word				equ 2
size_long				equ 4

; The size of one palette (in bytes, words, and longwords)
size_palette_b			equ 0x20
size_palette_w			equ size_palette_b/size_word
size_palette_l			equ size_palette_b/size_long

; The size of one graphics tile (in bytes, words, and longwords)
size_tile_b				equ 0x20
size_tile_w				equ size_tile_b/size_word
size_tile_l				equ size_tile_b/size_long

; Text draw position (in tiles)
text_pos_x				equ 0x08
text_pos_y				equ 0x10

; Speed (in pixels per frame) to move our scroll planes
plane_a_scroll_speed_x	equ 0x1
plane_a_scroll_speed_y	equ 0x1
plane_b_scroll_speed_x	equ 0x1
plane_b_scroll_speed_y	equ 0x1

;==============================================================
; MEMORY MAP
;==============================================================
; We need to store the current scroll values in RAM and update
; them each frame. There are a few ways to create a memory map,
; but the cleanest, simplest, and easiest to maintain method
; uses the assembler's "RS" keywords. RSSET begins a new table of
; offsets starting from any other offset (here we're starting at
; 0x00FF0000, the start of RAM), and allows us to add named entries
; of any size for the "variables". We can then read/write these
; variables using the offsets' labels (see INT_VInterrupt for use
; cases).
;==============================================================
	RSSET 0x00FF0000			; Start a new offset table from beginning of RAM
ram_plane_a_scroll_x	rs.w 1	; 1 table entry of word size for plane A's X scroll
ram_plane_a_scroll_y	rs.w 1	; 1 table entry of word size for plane A's Y scroll
ram_plane_b_scroll_x	rs.w 1	; 1 table entry of word size for plane B's X scroll
ram_plane_b_scroll_y	rs.w 1	; 1 table entry of word size for plane B's Y scroll
ram_sprite_1_pos_x		rs.w 1	; 1 table entry of word size for sprite 1's X pos
ram_sprite_1_pos_y		rs.w 1	; 1 table entry of word size for sprite 1's Y pos
ram_sprite_2_pos_x		rs.w 1	; 1 table entry of word size for sprite 2's X pos
ram_sprite_2_pos_y		rs.w 1	; 1 table entry of word size for sprite 2's Y pos
joy1state				rs.w 1

; !! Be careful when adding any table entries of BYTE size, since
; you'll need to start worrying about alignment. More of this in a
; future demo.

; The size of the sprite plane (512x512 pixels)
;
; With only a 320x240 display size, a lot of this
; is off screen, which is useful for hiding sprites
; when not needed (saves needing to adjust the linked
; list in the attribute table).
vdp_sprite_plane_width	equ 0x0200
vdp_sprite_plane_height	equ 0x0200

; The sprite border (invisible area left + top) size
;
; The sprite plane is 512x512 pixels, but is offset by
; -128 pixels in both X and Y directions. To see a sprite
; on screen at 0,0 we need to offset its position by
; this border.
vdp_sprite_border_x		equ 0x80
vdp_sprite_border_y		equ 0x80

; Sprite initial draw positions (in pixels)
sprite_1_start_pos_x	equ vdp_sprite_border_x
sprite_1_start_pos_y	equ vdp_sprite_border_y
sprite_2_start_pos_x	equ vdp_sprite_border_x+0x0040
sprite_2_start_pos_y	equ vdp_sprite_border_y+0x0020

; Speed (in pixels per frame) to move our sprites
sprite_1_move_speed_x	equ 0x1
sprite_1_move_speed_y	equ 0x1
sprite_2_move_speed_x	equ 0x1
sprite_2_move_speed_y	equ 0x1

;==============================================================
; TILE IDs
;==============================================================
; The indices of the first tile in each sprite. We only need
; to tell the sprite table where to find the starting tile of
; each sprite, so we don't bother keeping track of every tile
; index.
;
; Note we still leave the first tile blank (planes A and B are
; filled with tile 0) so we'll be uploading our sprite tiles
; from index 1.
;
; See bottom of the file for the sprite tiles themselves.
;==============================================================
tile_id_blank		equ 0x00	; The blank tile at index 0
tile_id_sprite_1	equ 0x0033	; Sprite 1 index (16 tiles)
tile_id_sprite_2	equ 0x0043	; Sprite 2 index (12 tiles)

; Total number of tiles in the sprites to upload to VRAM
sprite_tile_count			equ 0x1d	; Total tiles = 28

;==============================================================

; Gamepad ports
pad_data_a				equ 0x00A10003
pad_data_b				equ 0x00A10005
pad_data_c				equ 0x00A10007
pad_ctrl_a				equ 0x00A10009
pad_ctrl_b				equ 0x00A1000B
pad_ctrl_c				equ 0x00A1000D

pad_button_up           equ 0x0
pad_button_down         equ 0x1
pad_button_left         equ 0x2
pad_button_right        equ 0x3
pad_button_a            equ 0x6;0xC
pad_button_b            equ 0x4
pad_button_c            equ 0x5
pad_button_start        equ 0x7;0xD

;==============================================================