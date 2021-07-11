;==============================================================
; PALETTE
;==============================================================
; A single colour palette (16 colours) we'll be using to draw text.
; Colour #0 is always transparent, no matter what colour value
; you specify.
; We only use white (colour 2) and transparent (colour 0) in this
; demo, the rest are just examples.
;==============================================================
; Each colour is in binary format 0000 BBB0 GGG0 RRR0,
; so 0x0000 is black, 0x0EEE is white (NOT 0x0FFF, since the
; bottom bit is discarded), 0x000E is red, 0x00E0 is green, and
; 0x0E00 is blue.
;==============================================================
Palettes:
; Palette for sprite 2
Palette2:
	dc.w 0x0000
	dc.w 0x0004
	dc.w 0x0226
	dc.w 0x0040
	dc.w 0x0446
	dc.w 0x0262
	dc.w 0x0662
	dc.w 0x004A
	dc.w 0x0468
	dc.w 0x0882
	dc.w 0x006C
	dc.w 0x0202
	dc.w 0x04A0
	dc.w 0x0AC2
	dc.w 0x06AE
	dc.w 0x02EC

; Palette for font
Palette:
	dc.w	$0000	;	Color $0 is transparent (so the actual value doesn't matter)
	dc.w	$0e0e	;	Color $1
	dc.w	$0224	;	Color $2
	dc.w	$0002	;	Color $3
	dc.w	$0222	;	Color $4
	dc.w	$0eee	;	Color $5
	dc.w	$0248	;	Color $6
	dc.w	$0644	;	Color $7
	dc.w	$0000	;	Color $8
	dc.w	$0eca	;	Color $9
	dc.w	$0448	;	Color $a
	dc.w	$0eca	;	Color $b
	dc.w	$0ccc	;	Color $c
	dc.w	$0eee	;	Color $d
	dc.w	$0ccc	;	Color $c
	dc.w	$0eee	;	Color $d
;==============================================================

; Number of palettes to write to CRAM
palette_count	equ 0x3