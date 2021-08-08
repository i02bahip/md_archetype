;==============================================================
; VRAM WRITE MACROS
;==============================================================
; Some utility macros to help generate addresses and commands for
; writing data to video memory, since they're tricky (and
; error prone) to calculate manually.
; The resulting command and address is written to the VDP's
; control port, ready to accept data in the data port.
;==============================================================
	
; Set the VRAM (video RAM) address to write to next
SetVRAMWrite: macro addr
	move.l  #(vdp_cmd_vram_write)|((\addr)&$3FFF)<<16|(\addr)>>14, vdp_control
	endm
	
; Set the CRAM (colour RAM) address to write to next
SetCRAMWrite: macro addr
	move.l  #(vdp_cmd_cram_write)|((\addr)&$3FFF)<<16|(\addr)>>14, vdp_control
	endm

; Set the VSRAM (vertical scroll RAM) address to write to next
SetVSRAMWrite: macro addr
	move.l  #(vdp_cmd_vsram_write)|((\addr)&$3FFF)<<16|(\addr)>>14, vdp_control
	endm

;==============================================================
; SPRITE ATTRIBUTE MACRO
;==============================================================
; A macro to help build an entry in the Sprite Attribute
; Table, since manipulating structures and bit twiddling isn't
; the focus of this demo, and would make the code harder to
; read.
;==============================================================
; Proper game implementations would make use of a local SAT
; table in RAM and use DMA to transfer the table to VRAM each
; frame (which also allows us to use RAM like a "stream" to write
; this data more efficiently) but this is the best method for
; teaching the basics first.
;==============================================================
; Each sprite attribute entry is in the following format:
;
;   Y coordinate      1 word - the Y coordinate on the sprite plane
;   Dimensions bits   1 byte - bits describing the layout (1x1 tiles up to 4x4 tiles)
;   Linked list next  1 byte - the index of the next sprite to draw, or 0 if end of list
;   Prio/palette/flip 1 byte - the priority (bit 15), palette (bits 14-13),
;                              v/h flip (bits 12 and 11), and top 3 bits of the tile ID
;   Tile ID bottom    1 byte - the bottom 8 bits of the tile ID
;   X coordinate      1 word - the X coordinate on the sprite plane
;==============================================================

; Writes a sprite attribute structure to 4 registers, ready to write to VRAM
BuildSpriteStructure: macro x_pos,	; X pos on sprite plane
	y_pos,							; Y pos on sprite plane
	dimension_bits,					; Sprite tile dimensions (4 bits)
	next_id,						; Next sprite index in linked list
	priority_bit,					; Draw priority
	palette_id,						; Palette index
	flip_x,							; Flip horizontally
	flip_y,							; Flip vertically
	tile_id,						; First tile index
	reg1,							; Output: reg1
	reg2,							; Output: reg2
	reg3,							; Output: reg3
	reg4							; Output: reg4

	move.w #y_pos, \reg1
	move.w #(\dimension_bits<<8|\next_id), \reg2
	move.w #(\priority_bit<<14|\palette_id<<13|\flip_x<<11|\flip_y<<10|\tile_id), \reg3
	move.w #x_pos, \reg4
	endm

;DrawSprite: macro x_pos,
;	y_pos,
;	speed