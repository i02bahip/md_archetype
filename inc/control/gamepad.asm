ReadPads:
	move.l	#pad_data_b, A0			; load data_2 address
	move.b	#$40, (A0)				; set TH high for next pass
	move.l	#ram_joy1State, A1		; point to RAM placeholder for joystate and wait for the bus to synchronize at the same time
	move.b	(A0), D7				; read status j2 = ??CBRLDU
	move.b 	#$00, (A0)				; set TH low
	andi.b	#$3F, D7				; Do D7.b = 00CBRLDU and wait for the bus to synchronize at the same time
	move.b  (A0), D5				; read status  = 00SA00DU
	rol.b	#2, D5					; SA00DU??
	andi.b	#$C0, D5				; SA000000
	or.b	D5, D7					; D7.b = SACBRLDU j2
	;-------------- End of J2 data recollect
	move.l	#pad_data_a, A0			; load data_2 address
	move.b	#$40, (A0)				; set TH high for next pass
	swap	D7						; move j2 to high word in D7 and wait for the bus to synchronize at the same time
	move.b	(A0), D7				; read status j1 = ??CBRLDU	
	move.b 	#$00, (A0)				; set TH low
	andi.b	#$3F, D7				; Do D7.b = 00CBRLDU and wait for the bus to synchronize at the same time
	move.b  (A0), D5				; read status  = 00SA00DU
	rol.b	#2, D5					; SA00DU??
	andi.b	#$C0, D5				; SA000000
	or.b	D5, D7					; D7.b = SACBRLDU j1
	;-------------- End of J1 data recollect
	move.b	#$40, (A0)				; set TH high for next pass
	move.l	D7, (A1)				; store j2 and j1 data to RAM -> (High byte J2) -> SACBRLDU (Low byte J1) -> SACBRLDU
	rts