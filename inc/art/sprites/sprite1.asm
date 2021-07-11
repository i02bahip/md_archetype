Sprite1:
	; --- Tiles ---
	dc.l	$00000000	;	Tile (col 0, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00500000
	dc.l	$00500002
	dc.l	$00500002
	dc.l	$00900003	;	Tile (col 0, row 0)
	dc.l	$00900000
	dc.l	$00500000
	dc.l	$00900004
	dc.l	$00970004
	dc.l	$00790045
	dc.l	$00790454
	dc.l	$00074754
	dc.l	$00474474	;	Tile (col 0, row 2)
	dc.l	$00444740
	dc.l	$00045400
	dc.l	$00004300
	dc.l	$00000200
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000002	;	Tile (col 0, row 3)
	dc.l	$00000023
	dc.l	$00000023
	dc.l	$00000063
	dc.l	$00000036
	dc.l	$00000333
	dc.l	$00006622
	dc.l	$00006662
	dc.l	$00000222	;	Tile (col 0, row 0)
	dc.l	$00002226
	dc.l	$00022262
	dc.l	$00232626
	dc.l	$02332262
	dc.l	$23322626
	dc.l	$33332262
	dc.l	$33323226
	dc.l	$33333232	;	Tile (col 0, row 0)
	dc.l	$33333332
	dc.l	$88833333
	dc.l	$44883333
	dc.l	$55448888
	dc.l	$78795555
	dc.l	$48795555
	dc.l	$80877799
	dc.l	$00047444	;	Tile (col 0, row 2)
	dc.l	$00084444
	dc.l	$00082662
	dc.l	$00077626
	dc.l	$00795555
	dc.l	$07955557
	dc.l	$79955774
	dc.l	$79558008
	dc.l	$75570000	;	Tile (col 0, row 3)
	dc.l	$75780000
	dc.l	$33700000
	dc.l	$63300000
	dc.l	$36000000
	dc.l	$30000000
	dc.l	$30000000
	dc.l	$20000000
	dc.l	$00000000	;	Tile (col 2, row 0)
	dc.l	$20000000
	dc.l	$62000000
	dc.l	$26200000
	dc.l	$66620000
	dc.l	$26662000
	dc.l	$62666200
	dc.l	$26266200
	dc.l	$62626200	;	Tile (col 2, row 0)
	dc.l	$32238000
	dc.l	$23380000
	dc.l	$38844000
	dc.l	$84447400
	dc.l	$55875400
	dc.l	$55487744
	dc.l	$74088755
	dc.l	$40008875	;	Tile (col 2, row 2)
	dc.l	$70000044
	dc.l	$30000000
	dc.l	$30000000
	dc.l	$57000000
	dc.l	$55700000
	dc.l	$95570000
	dc.l	$79557000
	dc.l	$87557000	;	Tile (col 2, row 3)
	dc.l	$03332000
	dc.l	$02633000
	dc.l	$06336000
	dc.l	$00332000
	dc.l	$00366600
	dc.l	$00226666
	dc.l	$00222226
	dc.l	$00000000	;	Tile (col 3, row 0)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00050000
	dc.l	$00050000
	dc.l	$00050000
	dc.l	$00090000
	dc.l	$00090000	;	Tile (col 3, row 0)
	dc.l	$00050000
	dc.l	$00090000
	dc.l	$00090000
	dc.l	$00790000
	dc.l	$00970000
	dc.l	$00900000
	dc.l	$44740000
	dc.l	$44440000	;	Tile (col 3, row 2)
	dc.l	$75700000
	dc.l	$47400000
	dc.l	$02300000
	dc.l	$02000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000	;	Tile (col 3, row 3)
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
Sprite1End								 ; Sprite end address
Sprite1SizeB: equ (Sprite1End-Sprite1)	 ; Sprite size in bytes
Sprite1SizeW: equ (Sprite1SizeB/2)		 ; Sprite size in words
Sprite1SizeL: equ (Sprite1SizeB/4)		 ; Sprite size in longs
Sprite1SizeT: equ (Sprite1SizeB/32)		 ; Sprite size in tiles
Sprite1TileID: equ (Sprite1VRAM/32)		 ; ID of first tile
Sprite1Dimentions: equ (%00001111)       ; Sprite dimentions (4x4)