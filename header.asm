; ******************************************************************
; 68000 Vector Table
;{******************************************************************
	dc.l   	0x00FFFF00			; Initial stack pointer value
	dc.l   	EntryPoint      	; Start of program
	dc.l   	Exception       	; Bus error
	dc.l   	Exception       	; Address error
	dc.l   	Exception       	; Illegal instruction
	dc.l   	Exception       	; Division by zero
	dc.l   	Exception       	; CHK exception
	dc.l   	Exception       	; TRAPV exception
	dc.l   	Exception       	; Privilege violation
	dc.l   	Exception       	; TRACE exception
	dc.l   	Exception       	; Line-A emulator
	dc.l   	Exception       	; Line-F emulator
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Spurious exception
	dc.l   	Exception       	; IRQ level 1
	dc.l   	Exception    	; IRQ level 2 (external interrupt)
	dc.l   	Exception       	; IRQ level 3
	dc.l   	HBlankInterrupt 	; IRQ level 4 (horizontal retrace interrupt)
	dc.l   	Exception       	; IRQ level 5
	dc.l   	VBlankInterrupt 	; IRQ level 6 (vertical retrace interrupt)
	dc.l   	Exception       	; IRQ level 7
	dc.l   	Exception       	; TRAP #00 exception
	dc.l   	Exception       	; TRAP #01 exception
	dc.l   	Exception       	; TRAP #02 exception
	dc.l   	Exception       	; TRAP #03 exception
	dc.l   	Exception       	; TRAP #04 exception
	dc.l   	Exception       	; TRAP #05 exception
	dc.l   	Exception       	; TRAP #06 exception
	dc.l   	Exception       	; TRAP #07 exception
	dc.l   	Exception       	; TRAP #08 exception
	dc.l   	Exception       	; TRAP #09 exception
	dc.l   	Exception       	; TRAP #10 exception
	dc.l   	Exception       	; TRAP #11 exception
	dc.l   	Exception       	; TRAP #12 exception
	dc.l   	Exception       	; TRAP #13 exception
	dc.l   	Exception       	; TRAP #14 exception
	dc.l   	Exception       	; TRAP #15 exception
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
	dc.l   	Exception       	; Unused (reserved)
;}******************************************************************

; ******************************************************************
; Genesis ROM Info
;{******************************************************************
;	size     012345678901234567890123456789012345678901234567
	dc.b 	"SEGA GENESIS    "									; Console name - 16
	dc.b 	"(C)db   2016.MAR"									; Copyright holder and release date - 16
	dc.b 	"DB FONTS AND ASCII TUTORIAL                     "	; Domestic name - 48
	dc.b 	"DB FONTS AND ASCII                      "	; International name - 48
	dc.b 	"GM INTUTORL-05"									; Version number - 48
	dc.w 	0x1234												; Checksum
	dc.b 	"J               "									; I/O support - 16
	dc.l 	0x00000000											; Start address of ROM
	dc.l 	__end												; End address of ROM
	dc.l 	0x00FF0000											; Start address of RAM
	dc.l 	0x00FFFFFF											; End address of RAM
	dc.l 	0x00000000											; SRAM enabled
	dc.l 	0x00000000											; Unused
	dc.l 	0x00000000											; Start address of SRAM
	dc.l 	0x00000000											; End address of SRAM
	dc.l 	0x00000000											; Unused
	dc.l 	0x00000000											; Unused
	dc.b 	"                                        "			; Notes (unused)
	dc.b 	"JUE             "									; Country codes
;}******************************************************************
