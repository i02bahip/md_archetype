    include 'header.asm'

EntryPoint:
;---- CHECK THE RESET BUTTONS
    tst.w 0x00A10008  ; Test mystery reset (expansion port reset?)
    bne Main          ; Branch if Not Equal (to zero) - to Main
    tst.w 0x00A1000C  ; Test reset button
    bne Main          ; Branch if Not Equal (to zero) - to Main

;---- CLEAR THE RAM	
    move.l #0x00000000, d0     ; Place a 0 into d0, ready to copy to each longword of RAM
    move.l #0x00000000, a0     ; Starting from address 0x0, clearing backwards
    move.l #0x00003FFF, d1     ; Clearing 64k's worth of longwords (minus 1, for the loop to be correct)
.Clear:
    move.l d0, -(a0)           ; Decrement the address by 1 longword, before moving the zero from d0 to it
    dbra d1, .Clear            ; Decrement d0, repeat until depleted

;---- TRADE MARK SECURITY SIGNATURE
    move.b 0x00A10001, d0      ; Move Megadrive hardware version to d0
    andi.b #0x0F, d0           ; The version is stored in last four bits, so mask it with 0F
    beq Skip                  ; If version is equal to 0, skip TMSS signature
    move.l #'SEGA', 0x00A14000 ; Move the string "SEGA" to 0xA14000
Skip:

HBlankInterrupt:
VBlankInterrupt:
    rte   ; Return from Exception
Exception:
   	stop 	#0x2700
    
Main:
	jmp __main
__main:
	include 'mainProgram.asm'
__end    ; Very last line, end of ROM address