AYSEL		EQU	$FF00
AYDTA		EQU	$FF01

UART		EQU	$08

;MUSIC1	EQU	$4000
;MUSIC2	EQU	$43E8
;MUSIC3	EQU	$47D0
;XTRA		EQU	$4BB8
;XTRAEND	EQU	XTRA + 385
;PLAYER	EQU	$4FA0

MUSIC1	EQU	$EA60
MUSIC2	EQU	$EE48
MUSIC3	EQU	$F230
XTRA		EQU	$F618
XTRAEND	EQU	XTRA + 385
PLAYER	EQU	$FA00

mc45		equ $f8
turbo		equ $fa
cpld		equ $fc
cpld2		equ $fd
memmap	equ $fe

	ORG	0
	jp $100

	ORG $100
	ld sp,$6000
	ld a,$06		; (SYSCLK MHz/2/(value+1))
	out (turbo),a

; first let's make sure that we're talking to 16550 ok
	ld c,UART+7		; 16550 scratchpad register
	ld b,$0f
l1	out (c),b		; write to scratchpad register
	in a,(c)		; read back scratchpad
	push af		; save for later
	sla a			; shift to high nibble
	sla a
	sla a
	sla a
	or b			; add what was written
	out (cpld),a	; display
	pop af		; get what was read
	cp b			; compare to what was written
	jr z,l2		; skip if matches
	di
	halt			; didn't match, halt
l2	call delay		; give user time to read output
	djnz l1		; continue testing
	xor a			; done testing
	out (cpld),a	; clear display

init_uart	ld a,$80
	out (cpld),a	; indicate current state
	out (UART+3),a	; line control register
; https://docs.google.com/spreadsheets/d/1w3_G4yWRaHU6rBbSv83Q78V-CtOL8RAmRrh2SIaaUqM/edit?usp=sharing
	ld a,12		; baudrate divisor LSB
	out (UART+0),a
	ld a,0		; MSB
	out (UART+1),a
	ld a,3
	out (UART+3),a	; switch to data mode

l7	call delay		; give user time to read output

	ld HL,HLO
main_loop	ld a,$40
	out (cpld),a	; indicate current state
	in a,(UART+5)	; line status register
	bit 5,a			; Transmitter holding register
	jr z,main_loop

;	call delay		; give user time to read output

	ld a,$20
	out (cpld),a	; indicate current state

	ld a,(HL)
	cp $00
	jr z,l7
	inc hl
	out (UART),a		; data out

;	call delay		; give user time to read output

	jr main_loop

delay	ld hl,$ffff		; delay loop
l6	dec hl		; count delay
	ld a,h
	or a,l
	jr nz,l6		; repeat till 0
	ret

HLO	DB "Hello World!",$0d,$0a,$0

endprog	equ $

	output_bin "serial.bin",0,endprog    ; 