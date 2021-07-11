;==============================================================
; SEGA MEGA DRIVE/GENESIS - DEMO 1 - HELLO WORLD SAMPLE
;==============================================================
; by Big Evil Corporation
;==============================================================

; A small, discreet, and complete Hello World sample, with
; a healthy dose of comments and explanations for beginners.
; Runs on genuine hardware, and (hopefully) all emulators.
;
; To assemble this program with ASM68K.EXE:
;    ASM68K.EXE /p hello.asm,hello.bin,hello.map,hello.lst
;
; To assemble this program with SNASM68K.EXE:
;    SNASM68K.EXE /p hello.asm,hello.map,hello.lst,hello.bin
;
; hello.asm = this source file
; hello.bin = the binary file, fire this up in your emulator!
; hello.lst = listing file, shows assembled addresses alongside your source code, open in a text editor
; hello.map = symbol map file for linking (unused)

;==============================================================

; A label defining the start of ROM so we can compute the total size.
ROM_Start:

	include 'inc/init.asm'
	
;==============================================================
; CODE ENTRY POINT
;==============================================================
; The "main()" function. Your code starts here. Once the CPU
; has finished initialising, it will jump to this entry point
; (specified in the vector table at the top of the file).
;==============================================================
CPU_EntryPoint:

	;==============================================================
	; Initialise the Mega Drive
	;==============================================================

	; Write the TMSS signature (if a model 1+ Mega Drive)
	jsr    VDP_WriteTMSS

	; Load the initial VDP registers
	jsr    VDP_LoadRegisters

	;==============================================================
	; Clear VRAM (video memory)
	;==============================================================

	; Setup the VDP to write to VRAM address 0x0000 (start of VRAM)
	SetVRAMWrite 0x0000

	; Write 0's across all of VRAM
	move.w #(0x00010000/size_word)-1, d0	; Loop counter = 64kb, in words (-1 for DBRA loop)
	@ClrVramLp:								; Start of loop
	move.w #0x0, vdp_data					; Write a 0x0000 (word size) to VRAM
	dbra   d0, @ClrVramLp					; Decrement d0 and loop until finished (when d0 reaches -1)
	
	;==============================================================
	; Initialise status register and set interrupt level.
	; This begins firing vertical and horizontal interrupts.
	;==============================================================
	move.w #0x2300, sr
	
	;==============================================================
	; Write the palette to CRAM (colour memory)
	;==============================================================
	
	; Setup the VDP to write to CRAM address 0x0000 (first palette)
	SetCRAMWrite 0x0000
	
	; Write the palettes to CRAM
	;
	; This time we're writing multiple palettes, so multiply the word count
	; by the palette count (and don't forget the -1 for the loop counter).
	lea    Palettes, a0				; Move palette address to a0
	move.w #(palette_count*size_palette_w)-1, d0	; Loop counter = 8 words in palette (-1 for DBRA loop)
	@PalLp:							; Start of loop
	move.w (a0)+, vdp_data			; Write palette entry, post-increment address
	dbra d0, @PalLp					; Decrement d0 and loop until finished (when d0 reaches -1)
	
	;==============================================================
	; Write the font tiles to VRAM
	;==============================================================
	
	; Setup the VDP to write to VRAM address 0x0000 (the address of the first graphics tile, index 0)
	SetVRAMWrite vram_addr_tiles+size_tile_b
	
	; Write the font glyph tiles to VRAM
	lea    PixelFont, a0					; Move the address of the first graphics tile into a0
	move.w #(tile_count*size_tile_l)-1, d0		; Loop counter = 8 longwords per tile * num tiles (-1 for DBRA loop)
	@CharLp:									; Start of loop
	move.l (a0)+, vdp_data						; Write tile line (4 bytes per line), and post-increment address
	dbra d0, @CharLp							; Decrement d0 and loop until finished (when d0 reaches -1)

	;==============================================================
	; Write the sprite tiles to VRAM
	;==============================================================
	
	; Setup the VDP to write to VRAM address 0x0020 (the address of the first sprite tile, index 1)
	;
	; We need to leave the first tile blank (we cleared VRAM, so it should be all 0's) for
	; planes A and B to display, so skip the first tile (offset address by size_tile_b).
	SetVRAMWrite vram_addr_tiles+size_tile_b+PixelFontSizeB
	
	; Write the sprite tiles to VRAM
	lea    sprite_tiles, a0						; Move the address of the first graphics tile into a0
	move.w #(sprite_tile_count*size_tile_l)-1, d0		; Loop counter = 8 longwords per tile * num tiles (-1 for DBRA loop)
	@CharLp2:									; Start of loop
	move.l (a0)+, vdp_data						; Write tile line (4 bytes per line), and post-increment address
	dbra d0, @CharLp2	

	;==============================================================
	; Write the tile IDs of "HELLO WORLD" to Plane A's cell grid
	;==============================================================

	; Each scroll plane is made up of a 64x32 tile grid (this size is specified in VDP register 0x10),
	; with each cell specifying the index of each tile to draw, the palette to draw it with, and
	; some flags (for priority and flipping).
	;
	; Each plane cell is 1 word in size (2 bytes), in the binary format
	; ABBC DEEE EEEE EEEE, where:
	;
	;   A = Draw priority (1 bit)
	;   B = Palette index (2 bits, specifies palette 0, 1, 2, or 3)
	;   C = Flip tile horizontally (1 bit)
	;   D = Flip tile vertically (1 bit)
	;   E = Tile index to draw (11 bits, specifies tile index from 0 to 2047)
	;
	; Since we're using priority 0, palette 0, and no flipping, we
	; only need to write the tile ID and leave everything else zero.
	
	; Setup the VDP to write the tile ID at text_pos_x,text_pos_y in plane A's cell grid.
	; Plane A's cell grid starts at address 0xC000, which is specified in VDP register 0x2.
	;
	; Since each cell is 1 word in size, to compute a cell address within plane A:
	; ((y_pos * plane_width) + x_pos) * size_word
	SetVRAMWrite vram_addr_plane_a+(((text_pos_y*vdp_plane_width)+text_pos_x)*size_word)
	
	; then move the tile ID for "P" to VRAM
	move.w #tile_id_p, vdp_data		; P
	
	; Repeat for the remaining characters in the string.
	; We don't need to adjust the VRAM address each time, since the auto-increment
	; register (VDP register 0xF) is set to 2, so the destination address
	; will automatically increment by one word (conveniently the size of a cell)
	; after each write.
	move.w #tile_id_l, vdp_data		; L
	move.w #tile_id_a, vdp_data		; A
	move.w #tile_id_n, vdp_data		; N
	move.w #tile_id_e, vdp_data		; E
	move.w #tile_id_space, vdp_data	; SPACE
	move.w #tile_id_a, vdp_data		; A

	; Write "PLANE B" font tile IDs to Plane B
	SetVRAMWrite vram_addr_plane_b+(((text_pos_y*vdp_plane_width)+text_pos_x)*size_word)
	move.w #tile_id_p, vdp_data		; P
	move.w #tile_id_l, vdp_data		; L
	move.w #tile_id_a, vdp_data		; A
	move.w #tile_id_n, vdp_data		; N
	move.w #tile_id_e, vdp_data		; E
	move.w #tile_id_space, vdp_data	; SPACE
	move.w #tile_id_b, vdp_data		; B

	;==============================================================
	; Intitialise variables in RAM
	;==============================================================
	move.w #0x0000, ram_plane_a_scroll_x
	move.w #0x0000, ram_plane_a_scroll_y
	move.w #0x0000, ram_plane_b_scroll_x
	move.w #0x0000, ram_plane_b_scroll_y

	;==============================================================
	; Set up the Sprite Attribute Table (SAT)
	;==============================================================

	; The Sprite Attribute Table is a table of sprites to draw.
	; Each entry in the table describes the first tile ID, the number
	; of tiles to draw (and their layout), the X and Y position
	; (on the 512x512 sprite plane), the palette to draw with, a
	; priority flag, and X/Y flipping flags.
	;
	; Sprites can be layed out in these tile dimensions:
	;
	; 1x1 (1 tile)  - 0000
	; 1x2 (2 tiles) - 0001
	; 1x3 (3 tiles) - 0010
	; 1x4 (4 tiles) - 0011
	; 2x1 (2 tiles) - 0100
	; 2x2 (4 tiles) - 0101
	; 2x3 (6 tiles) - 0110
	; 2x4 (8 tiles) - 0111
	; 3x1 (3 tiles) - 1000
	; 3x2 (6 tiles) - 1001
	; 3x3 (9 tiles) - 1010
	; 3x4 (12 tiles)- 1011
	; 4x1 (4 tiles) - 1100
	; 4x2 (8 tiles) - 1101
	; 4x3 (12 tiles)- 1110
	; 4x4 (16 tiles)- 1111
	;
	; The tiles are layed out in COLUMN MAJOR, rather than planes A and B
	; which are row major. Tiles within a sprite cannot be reused (since it
	; only accepts a starting tile and a count/layout) so the whole sprite
	; needs uploading to VRAM in one consecutive chunk, even if some tiles
	; are duplicates.
	;
	; The X/Y flipping flags take the layout into account, you don't need
	; to re-adjust the layout, position, or tile IDs to flip the entire
	; sprite as a whole.
	;
	; There are 64 entries in the table, but the number of them drawn,
	; and the order in which they're processed, is determined by a linked
	; list. Each sprite entry has an index to the NEXT sprite to be drawn.
	; If this index is 0, the list ends, and the VDP won't draw any more
	; sprites this frame.

	; Start writing to the sprite attribute table in VRAM
	SetVRAMWrite vram_addr_sprite_table

	;==============================================================
	; Set up sprite 1

	; Write all values into registers first to make it easier. We
	; write to VRAM one word at a time (auto-increment is set to 2
	; in VDP register 0xF), so we'll assign each word to a register.
	;
	; Since bit twiddling and manipulating structures isn't the focus of
	; this sample, we have a macro to simplify this part.

	; Position:   sprite_1_start_pos_x,sprite_1_start_pos_y
	; Dimensions: 2x2 tiles (8 tiles total) = 0101 in binary (see table above)
	; Next link:  sprite index 1 is next to be processed
	; Priority:   0
	; Palette id: 0
	; Flip X:     0
	; Flip Y:     0
	; Tile id:    tile_id_sprite_1
	BuildSpriteStructure sprite_1_start_pos_x,sprite_1_start_pos_y,%1111,0x1,0x0,0x1,0x0,0x0,tile_id_sprite_1,d0,d1,d2,d3

	; Write the entire sprite attribute structure to the sprite table
	move.w d0, vdp_data
	move.w d1, vdp_data
	move.w d2, vdp_data
	move.w d3, vdp_data

	;==============================================================
	; Set up sprite 2

	; Position:   sprite_2_start_pos_x,sprite_2_start_pos_y
	; Dimensions: 4x3 tiles (16 tiles total) = 1110 in binary (see table above)
	; Next link:  sprite index 0 (end of linked list)
	; Priority:   0
	; Palette id: 1
	; Flip X:     0
	; Flip Y:     0
	; Tile id:    tile_id_sprite_2
	BuildSpriteStructure sprite_2_start_pos_x,sprite_2_start_pos_y,%1110,0x0,0x0,0x0,0x0,0x0,tile_id_sprite_2,d0,d1,d2,d3

	; Write the entire sprite attribute structure to the sprite table
	move.w d0, vdp_data
	move.w d1, vdp_data
	move.w d2, vdp_data
	move.w d3, vdp_data

	;==============================================================
	; Intitialise variables in RAM
	;==============================================================
	move.w #sprite_1_start_pos_x, ram_sprite_1_pos_x
	move.w #sprite_1_start_pos_y, ram_sprite_1_pos_y
	move.w #sprite_2_start_pos_x, ram_sprite_2_pos_x
	move.w #sprite_2_start_pos_y, ram_sprite_2_pos_y


	;==============================================================
	; Initialise status register and set interrupt level.
	; This begins firing vertical and horizontal interrupts.
	;
	; Since the vinterrupt does something meaningful in this
	; demo, we start this AFTER setting up the VDP to draw and
	; intialising the variables in RAM.
	;==============================================================
	move.w #0x2300, sr

	; Finished!
	
	;==============================================================
	; Loop forever
	;==============================================================
	; This loops forever, effectively ending our code. The VDP will
	; still continue to run (and fire vertical/horizontal interrupts)
	; of its own accord, so it will continue to render our Hello World
	; even though the CPU is stuck in this loop.
	@InfiniteLp:


	bra @InfiniteLp
	
;==============================================================
; INTERRUPT ROUTINES
;==============================================================
; The interrupt routines, as specified in the vector table at
; the top of the file.
; Note that we use RTE to return from an interrupt, not
; RTS like a subroutine.
;==============================================================

; Vertical interrupt - run once per frame (50hz in PAL, 60hz in NTSC)
INT_VInterrupt:
	
	; Fetch the current scroll values from RAM.
	;
	; These labels are just named offsets from 0x00FF0000 (start of RAM)
	; so we can read from/write to them like any other address.
	move.w ram_plane_a_scroll_x, d0
	move.w ram_plane_b_scroll_y, d1
	move.w ram_plane_a_scroll_y, d2
	move.w ram_plane_b_scroll_x, d3

	; Animate them
	subi.w #plane_a_scroll_speed_x, d0	; Scroll plane A left
	addi.w #plane_b_scroll_speed_y, d1	; Scroll plane B up
	subi.w #plane_a_scroll_speed_y, d2	; Scroll plane A left
	addi.w #plane_b_scroll_speed_x, d3	; Scroll plane B up

	; Store updated scroll values back into RAM
	move.w d0, ram_plane_a_scroll_x
	move.w d1, ram_plane_b_scroll_y
	move.w d2, ram_plane_a_scroll_y
	move.w d3, ram_plane_b_scroll_x

	; VDP register 0xB specifies how the planes scroll. It's set to per-page mode
	; in this demo, so we only need to write one word value to scroll an entire plane
	; in a particular direction.
	;
	; There are two areas of memory used for scroll values - horizontal scroll
	; is within VRAM (location is specified by VDP register 0xD), and
	; vertical scroll has its own separate memory (VSRAM), and therefore has
	; its own macro for setting the address (it has its own VDP command).

	; Write Plane A's H-scroll value to horizontal scroll memory (in VRAM).
	; Plane A's horizontal page scroll value is at VRAM 0xFC00, Plane B's is at 0xFC02.
	SetVRAMWrite vram_addr_hscroll_a
	move.w d0, vdp_data

	; Write Plane B's V-scroll value to vertical scroll memory (VSRAM).
	; Plane A's vertical page scroll value is at VSRAM 0x0000, Plane B's is at 0x0002.
	SetVSRAMWrite vram_addr_vscroll_b
	move.w d1, vdp_data

	; Write Plane A's V-scroll value to vertical scroll memory (VSRAM).
	; Plane A's vertical page scroll value is at VSRAM 0x0000, Plane B's is at 0x0002.
	SetVSRAMWrite vram_addr_vscroll_a
	move.w d2, vdp_data
	
	; Write Plane B's H-scroll value to horizontal scroll memory (in VRAM).
	; Plane A's horizontal page scroll value is at VRAM 0xFC00, Plane B's is at 0xFC02.
	SetVRAMWrite vram_addr_hscroll_b
	move.w d3, vdp_data

	;-----------------------------------

	; Fetch current sprite coordinates from RAM
	;move.w ram_sprite_1_pos_x, d4
	;move.w ram_sprite_1_pos_y, d5
	move.w ram_sprite_2_pos_x, d2
	move.w ram_sprite_2_pos_y, d3

	; ************************************
	; Read gamepad input
	; d6 -> sprite speed
	; d4 -> X pos
	; d5 -> Y pos
	; ************************************
	jsr     ReadPad1              ; Read pad 1 state, result in d0

	move.l  #0x1, d6              ; Default sprite move speed speed

	btst    #pad_button_a, d7     ; Check A button
	bne     @NoA                  ; Branch if button off
	move.l  #0x2, d6              ; Double sprite move speed speed
	@NoA:

	btst    #pad_button_b, d7     ; Check B button
	bne     @NoB                  ; Branch if button off
	move.l  #0x2, d6              ; triple sprite move speed speed
	@NoB:

	btst    #pad_button_c, d7     ; Check C button
	bne     @NoC                  ; Branch if button off
	move.l  #0x2, d6              ; *4 sprite move speed speed
	@NoC:

	btst    #pad_button_start, d7 ; Check start button
	bne     @NoStart              ; Branch if button off
	move.l  #0x2, d6              ; Double sprite move speed speed
	@NoStart:

	btst    #pad_button_right, d7 ; Check right button
	bne     @NoRight              ; Branch if button off
	add.w   d6, ram_sprite_1_pos_x                ; Increment sprite X pos
	@NoRight:

	btst    #pad_button_left, d7  ; Check left button
	bne     @NoLeft               ; Branch if button off
	sub.w   d6, ram_sprite_1_pos_x                ; Decrement sprite X pos
	@NoLeft:

	btst    #pad_button_down, d7  ; Check down button
	bne     @NoDown               ; Branch if button off
	add.w   d6, ram_sprite_1_pos_y                ; Increment sprite Y pos
	@NoDown:

	btst    #pad_button_up, d7    ; Check up button
	bne     @NoUp                 ; Branch if button off
	sub.w   d6, ram_sprite_1_pos_y                ; Decrement sprite Y pos
	@NoUp:


	; Animate them (x/y coords are 9 bits, so this
	; wraps around the whole 512x512 sprite plane)
	addi.w #sprite_2_move_speed_x, d2
	addi.w #sprite_2_move_speed_y, d3

	; Store updated values back in RAM for next frame
	;move.w d4, ram_sprite_1_pos_x
	;move.w d5, ram_sprite_1_pos_y
	move.w d2, ram_sprite_2_pos_x
	move.w d3, ram_sprite_2_pos_y

	; Write updated coordinates to the Sprite Attribute Table in VRAM.
	; Each entry is 8 bytes in size, so sprite 1 is at table+0x0000,
	; and sprite 2 is at table+0x0008.
	;
	; The Y coord is the 1st word in the structure, and the X coord is
	; the 4th. As already noted, there are cleaner ways to do this,
	; like storing the tables in RAM and copying them via DMA every
	; frame, but that's beyond the focus of this sample.

	; Sprite 1's Y coordinate is at table+0x0000
	SetVRAMWrite vram_addr_sprite_table+0x0000
	move.w ram_sprite_1_pos_y, vdp_data

	; Sprite 1's X coordinate is at table+0x0006
	SetVRAMWrite vram_addr_sprite_table+0x0006
	move.w ram_sprite_1_pos_x, vdp_data

	; Sprite 2's Y coordinate is at table+0x0008
	SetVRAMWrite vram_addr_sprite_table+0x0008
	move.w d3, vdp_data

	; Sprite 2's X coordinate is at table+0x000E
	SetVRAMWrite vram_addr_sprite_table+0x000E
	move.w d2, vdp_data


	rte

; Horizontal interrupt - run once per N scanlines (N = specified in VDP register 0xA)
INT_HInterrupt:
	; Doesn't do anything in this demo
	rte

; NULL interrupt - for interrupts we don't care about
INT_Null:
	rte

; Exception interrupt - called if an error has occured
CPU_Exception:
	; Just halt the CPU if an error occurred. Later on, you may want to write
	; an exception handler to draw the current state of the machine to screen
	; (registers, stack, error type, etc) to help debug the problem.
	stop   #0x2700
	rte

; A label defining the end of ROM so we can compute the total size.
ROM_End:
