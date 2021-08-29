mc45	equ $f8
turbo	equ $fa
cpld	equ $fc
cpld2	equ $fd
memmap	equ $fe

	org 0
start	jp $100

	org $38
irq	di
	ex af,af'
	exx
	ld a,($6004)
	xor a,$f0
	ld ($6004),a
	out (cpld),a

	ld bc,($6006)	; get offset
	ld hl,$2000		; add it to VBUF start addr
	add hl,bc
	push hl
	pop de
	ld hl,$4000		; add it to VBUF start addr
	add hl,bc
	push hl
	ld hl,$100		; add $100 to offset count - point to next offset
	add hl,bc
	ld a,$16		; check if end of VBUF
	cp a,h
	jr nz,cont1		; no
	ld hl,$4000
	inc (hl)
	ld hl,0
cont1	ld ($6006),hl
	pop hl		; get calculated offset
	ld bc,$20		; transfer $20 bytes
	ldir

/*
	ld hl,($6000)
	ld de,($6002)
	ld bc,$1a0
	ldir
	ld a,$35
	cp a,d
	jr nz,irq1
	ld de,$2000
	ld hl,$4000
	inc (hl)
irq1	ld ($6000),hl
	ld ($6002),de
*/

	exx
	ex af,af'
	ei
	reti

	org $100
	di		; disable interrupts
	ld hl,tab45	; table of init parameters to load into MC6845
	ld b,0	; counter of registers
lp45	ld a,b	; check if counter reached last register
	inc b
	cp a,14
	jr z,outt	; jump out of loop if so
;	jr z,swit	; jump out of loop if so
	out (mc45),a	; else send reg address to mc6845
	ld a,(hl)
	inc hl
	out (mc45+1),a	; send reg value to MC6845
	jr lp45

/*
tab45	db 38	; R0 H. Total
	db 32	; R1 H. Displayed
	db 33	; R2 H. Sync Position
	db 2	; R3 H. Sync Width
	db 22	; R4 V. Total
	db 14	; R5 V. Scan Line Adjust
	db 22	; R6 V. Displayed
	db 22	; R7 V. Sync Position
	db 0	; R8 Interlace Mode Register
	db 21	; R9 Max. Scan Line Address
	db 0	; R10 Cursor Start
	db 0	; R11 Cursor End
	db 0	; R12 Start Address (H)
	db 0	; R13 Start Address (L)
	db 0	; R14 Cursor (H)
	db 0	; R15 Cursor (L)
	db 0	; R16 Light Pen (H)
	db 0	; R17 Light Pen (L)
*/
tab45	db 39	; R0 H. Total
	db 32	; R1 H. Displayed
	db 33	; R2 H. Sync Position
	db 4	; R3 H. Sync Width
	db 31	; R4 V. Total
	db 9	; R5 V. Scan Line Adjust
	db 30	; R6 V. Displayed
	db 30	; R7 V. Sync Position
	db 0	; R8 Interlace Mode Register
	db 15	; R9 Max. Scan Line Address
	db 0	; R10 Cursor Start
	db 0	; R11 Cursor End
	db 0	; R12 Start Address (H)
	db 0	; R13 Start Address (L)
	db 0	; R14 Cursor (H)
	db 0	; R15 Cursor (L)
	db 0	; R16 Light Pen (H)
	db 0	; R17 Light Pen (L)



outt	ld b,1	; count and show on display to show that outport works
out1	ld a,b
	out (cpld),a

	ld a,$ff	; do a little delay while counting so it's easier to see
out2	nop
	nop
	nop
	dec a
	jr nz,out2

	inc b
	jr nz,out1


memt	ld a,$1	; indicate phase 1
	out (cpld),a

	ld hl,$4000	; fill $4000 - $5FFF with 0s
	ld de,$4001
	ld bc,$1fff
	ld (hl),0
	ldir

	ld a,$2	; indicate phase 2
	out (cpld),a

	ld a,($2 << 5 ) + $3	; memmap address 2, value 3
	out (memmap),a

	ld hl,$4000	; fill $4000 - $5FFF with 1s
	ld de,$4001
	ld bc,$1fff
	ld (hl),1
	ldir

;	ld a,($2 << 5 ) + $4	; memmap address 2, value 4
;	out (memmap),a

;	ld hl,$4000	; fill $4000 - $5FFF with $aa
;	ld de,$4001
;	ld bc,$1fff
;	ld (hl),$aa
;	ldir

	ld a,$4	; indicate phase 3
	out (cpld),a

	ld a,($2 << 5 ) + $3	; memmap address 2, value 3
	out (memmap),a

	ld hl,$4000		; check if 1s are still in bank 3 and didnt get overwritten
	ld d,1
; routine below repeats 4 times
; tempting to put it in subroutine
; but since we don't know if RAM is good
; we can't
	ld bc,$2000
ta	ld a,d
	cp a,(hl)
	jr nz,tfail
	dec bc
	inc hl
	ld a,b
	or a,c
	jr nz,ta

	ld a,$8	; indicate phase 4
	out (cpld),a

	ld a,($2 << 5 ) + $2	; memmap address 2, value 2
	out (memmap),a

	ld hl,$4000		; check if 0s are still in bank 2 and didnt get overwritten
	ld d,0
	ld bc,$2000
tb	ld a,d
	cp a,(hl)
	jr nz,tfail
	dec bc
	inc hl
	ld a,b
	or a,c
	jr nz,tb

	ld a,$10	; indicate phase 5
	out (cpld),a

	ld hl,$6000		; bank 3 is also mapped to $6000 - 7FFF, see if 1s are there
	ld d,1
	ld bc,$2000
tc	ld a,d
	cp a,(hl)
	jr nz,tfail
	dec bc
	inc hl
	ld a,b
	or a,c
	jr nz,tc

	ld a,$20	; indicate phase 6
	out (cpld),a

;	ld hl,$8000		; bank 4 is also mapped to $8000 - 9FFF, see if $aa are there
;	ld d,$aa
;	ld bc,$2000
;td	ld a,d
;	cp a,(hl)
;	jr nz,tfail
;	dec bc
;	inc hl
;	ld a,b
;	or a,c
;	jr nz,td

	jp memre
;	jp blink

; we land here if RAM test failed
tfail	ld a,h	; show H on output port and wait a bit so user can read it
	out (cpld),a

; delay. tempting to put it in subroutine but since RAM just failed test we can't
	ld b,3
d2	ld de,$ffff
d1	dec de
	ld a,d
	or a,e
	jr nz,d1
	dec b
	jr nz,d2

	ld a,l	; show L on output port and wait a bit so user can read it
	out (cpld),a

; delay
	ld b,3
d4	ld de,$ffff
d3	dec de
	ld a,d
	or a,e
	jr nz,d3
	dec b
	jr nz,d4

	ld a,(hl)	; show (HL) on output port and wait a bit so user can read it
	out (cpld),a

; delay
	ld b,3
d6	ld de,$ffff
d5	dec de
	ld a,d
	or a,e
	jr nz,d5
	dec b
	jr nz,d6

	inc hl	; point to next byte and also show it 
	ld a,h
	out (cpld),a

; delay
	ld b,3
d8	ld de,$ffff
d7	dec de
	ld a,d
	or a,e
	jr nz,d7
	dec b
	jr nz,d8

	ld a,l
	out (cpld),a

; delay
	ld b,3
d10	ld de,$ffff
d9	dec de
	ld a,d
	or a,e
	jr nz,d9
	dec b
	jr nz,d10

	ld a,(hl)
	out (cpld),a

cp2	jr cp2


; RAM is good
; memory remap.
memre	ld a,($2 << 5 ) + $10	; memmap address 2, value 10 - ram page 0 in slot 2
	out (memmap),a
	ld sp,$6000	; init SP to top of ram now that RAM passed test

; Copy ROM to page 0 of RAM
	ld hl,$0000
	ld de,$4000
	ld bc,$1000
	ldir

; verify
	ld hl,$0000
	ld de,$4000
	ld bc,$1000
mm2	ld a,(de)
	cp a,(hl)
	jr nz,mm1
	inc de
	inc hl
	dec bc
	ld a,b
	or a,c
	jr nz,mm2
	jp swit

; compare failed
mm1	ld a,h	; show H on output port and wait a bit so user can read it
	out (cpld),a

	call delay

	ld a,l	; show L on output port and wait a bit so user can read it
	out (cpld),a

	call delay

	ld a,(hl)	; show (HL) on output port and wait a bit so user can read it
	out (cpld),a

	call delay

	inc hl	; point to next byte and also show it 
	ld a,d
	out (cpld),a

	call delay

	ld a,e
	out (cpld),a

	call delay

	ld a,(de)
	out (cpld),a

ep2	jr ep2


; switch in RAM for ROM
swit	ld a,($0 << 5 ) + $10	; memmap address 0, value 10 - ram page 0 in slot 0 - ROM
	out (memmap),a
	ld a,($2 << 5 ) + $2	; memmap address 2, value 2 - ram page 2 in slot 2
	out (memmap),a
	ld sp,$6000	; init SP to top of ram now that RAM passed test
	ld a,$1			; enable turbo mode
	out (turbo),a
	ld hl,$4000
	ld de,$2000
	ld ($6000),hl
	ld ($6002),de
	ld hl,$0		; initialize offset count
	ld ($6006),hl
	xor a
	ld ($4000),a	; seed first display byte
	ld a,$f0
	ld ($6004),a

	im 1				; now can enable interrupts and refresh VRAM
	ei

here	ld hl,$4000
	ld de,$4001
	ld bc,$1600
	ldir
	
	jr here

; at this point code is running from RAM and can be altered
; alter code in RAM
	ld a,$c0	; instead of $50
	ld (b5+1),a
	ld a,$30	; instead of $a0
	ld (ba+1),a

; first make sure memory maps are reset to default
blink ld a,($2 << 5 ) + $2	; memmap address 2, value 2
	out (memmap),a
	ld sp,$5000	; init SP to top of ram now that RAM passed test
/*
; test LCD output
	call inlcd	; init LCD
	call MvCrs
	call MvCrs

	ld HL,HELO
	call LOut

inf	jr inf	; stay in loop forever

HELO	db "Hello!"
	db 0
*/

bli1	in a,(cpld)	; read input port. keep lower nibble and output on outport
	and a,$0f
b5	or a,$50	; this gets altered to $c0 since we're running from RAM
	out (cpld),a

	ld b,1	; little delay
	call del1

	in a,(cpld)	; read input port. keep lower nibble and output on outport
	and a,$0f
ba	or a,$a0	; this gets altered to $30 since we're running from RAM
	out (cpld),a


	ld b,1	; little delay
	call del1

	jr bli1

testb	ld bc,$2000
ty	ld a,d
	cp a,(hl)
	jr nz,tz
	dec bc
	inc hl
	ld a,b
	or a,c
	jr nz,ty

	ret		; at this point a contains 0

tz	ld a,$ff	; return non-zero on fail
	ret

; short delay
sdel	ld a,$ff
sd2	nop
	nop
	nop
	nop
	dec a
	jr nz,sd2
	ret

delay	ld b,3
del1	ld de,$ffff
del2	dec de
	ld a,d
	or a,e
	jr nz,del2
	dec b
	jr nz,del1

	ret

; Constants for LCD
LCD_MOVE_CURS  equ     $E7  ; set acc.7 to send move command.
LCD_MASK       equ     $f0  ; set high nybble to be inputs
LCD_ENAB       equ     $02  ; lcd enable bit
LCD_ENAB1      equ     $fd
LCD_READ       equ     $f4  ; lcd read/write bit
LCD_READ1      equ     $fb
LCD_DATA       equ     $08  ; lcd data/status bit
LCD_DATA1      equ     $f7
MODE_8_BIT     equ     $30  ; set lcd for 8 bit mode
MODE_4_BIT     equ     $20  ; set lcd for 4 bit mode
FUNCTION_MODE  equ     $20  ; set lcd for 4 bit, 5x7, 1 line
DISP_MODE      equ     $0F  ; set lcd for disp on, cursor on
SHIFT_DISP_R   equ     $1c  ; shift display right
SHIFT_DISP_L   equ     $18  ; shift display left
SHIFT_CRSR_R   equ     $14  ; shift cursor right
SHIFT_CRSR_L   equ     $10  ; shift cursor left
LCD_SH_DISP    equ     $07  ; display entry mode shift display
LCD_SH_CRSR    equ     $06  ; display entry mode shift cursor
LCD_HOME       equ     $02  ; move cursor home
LCD_CLR        equ     $01  ; clear lcd
delay1         equ     $01  ; LCD write delay
delay2         equ     $ff  ; display delay

;
; output bit assignment:
;
; 7 - DB7, LCD status
; 6 - DB6
; 5 - DB5
; 4 - DB4
; 3 - RS register select
; 2 - R/W read / write
; 1 - E enable
; 0 - IR output
;
;
; the first 4 commands are nibbles only in the msn of the immediate bytes
; first the lcd is put in 8 bit mode, and then into 4 bit mode
; during the sending of the first 4 nibbles, a delay is placed after each one.
; (you can't check the busy flag during this initial startup.)
inlcd	ld a,MODE_8_BIT       ;init 8 bit mode, for starters
	call WrLN
	ld b,delay1
	call del1
	ld a,MODE_8_BIT       ;init 8 bit mode, again
	call WrLN
	ld b,delay1
	call del1
	ld a,MODE_4_BIT       ;now init 4 bit mode
	call WrLN
	ld b,delay1
	call del1
;
	ld a,FUNCTION_MODE    ;setup 4bit mode, 5x7 char, 2 lines
	call WrLS
	ld a,DISP_MODE        ;set display mode
	call WrLS
	ld a,LCD_CLR          ;clear the lcd
	call WrLS
	ld a,LCD_SH_CRSR      ;set entry mode to shift cursor
	call WrLS
	ret

;
; **************************************************************************
; print null terminated string pointed to by HL
; **************************************************************************
LOut1	inc HL	; point to next char
	call WrLD	; output char in W
LOut	ld a,(HL)	; fetch data to be printed
	or a,a	; check if 0
	jr nz,LOut1	; jump to output procedure if not
	ret		; exit if it is

; **************************************************************************
; send cursor home
; **************************************************************************
LHome	ld a,LCD_HOME        ; send cursor home
	jr WrLS

; **************************************************************************
; clear the lcd
; **************************************************************************
LClr	ld a,LCD_CLR          ;clear lcd
	jr WrLS



; **************************************************************************
; move cursor as specified in A:
; D3 D2
; 0  0  shift cursor left
; 0  1  shift cursor right
; 1  0  shift display left
; 1  1  shift display right
; **************************************************************************
MvCrs	or a,LCD_MOVE_CURS

; **************************************************************************
; write lcd status byte, (first wait to see if lcd is ready for a command).
; **************************************************************************
WrLS	push af		; store data for later
	ld b,delay1
	call del1		; wait until lcd is ready
	pop af			; get data from stack
	push af		; and save it for next step
	and a,LCD_DATA1       ; setup to write a command to the lcd
	call WrLN     ; write the nibble
                                ; now do lsn
	pop af
	sla a            ; get char back and swap nybbles
	sla a
	sla a
	sla a
	and a,LCD_DATA1       ; setup to write a command to the lcd
; just jump to it to save the call and ret
	jr WrLN 
;	call WrLN     ; write the nibble
;	ret

;
; **************************************************************************
; write lcd data byte, put ascii data to be written in the acc
; **************************************************************************
WrLD	push af
	or a,LCD_DATA        ; set write data bit
	call WrLN     ; write the nibble
                                ; now do lsn
	pop af
	sla a		; get char back and swap nybbles
	sla a
	sla a
	sla a
	or a,LCD_DATA	; set write data bit
; just continue down instead of calling subroutine
;        call    WrLN     ; write the nibble
;        ret

;
; **************************************************************************
; write a nibble to the lcd, namely the msn
; you must setup LCD_DATA, for either data(1) or command(0) before calling
; also need the dptr set up to lcd_write before calling.
; the nibble is in the msn of the accumulator, the lsn is for lcd control bits
; **************************************************************************
WrLN	and a,LCD_READ1	; Set WRITE (W/R low)
	and a,LCD_ENAB1	; make sure that ENABLE is off
	out (cpld),a	; output data to lcd
	or a,LCD_ENAB	; enable lcd
	out (cpld),a	; output data to lcd
	and a,LCD_ENAB1	; disable lcd
	out (cpld),a
	ret
	
; just a pattern to mark end of code
	db $55
	db $aa

endprog	equ $

	output_bin "myz80_6845init.bin",$0000,endprog    ; The binary file

