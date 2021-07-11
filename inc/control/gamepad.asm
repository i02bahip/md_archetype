ReadPad1:
	; d7 (w) - Return result (00SA0000 00CBRLDU)
	;move.b  pad_data_a, d7     ; Read upper byte from data port
	;rol.w   #0x8, d7           ; Move to upper byte of d7
	;move.b  #0x40, pad_data_a  ; Write bit 7 to data port
	;move.b  pad_data_a, d7     ; Read lower byte from data port
	;move.b  #0x00, pad_data_a  ; Put data port back to normal

	;rts
	move.l	#pad_data_a, A0			; load data_1 address
	move.l	#joy1State, A1			; point to RAM placeholder for joystate
	move.b	(A0), D7				; read status j1 = 00CBRLDU
	move.b 	#$00, (A0)				; set TH low
	nop								; wait to settle
	move.b  (A0), D5				; read status = 00SA00DU
	rol.b	#2, D5					; SA00DU??
	andi.b	#$C0, D5				; SA000000
	or.b	D5, D7					; D7 = SACBRLDU
	move.b	#$40, (A0)				; set TH high for next pass
	move.w	D7, (A1)				; store to RAM
	rts
