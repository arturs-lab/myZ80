mc45	equ $fa
cpld	equ $fc
memmap	equ $fe

	org 0
start	di		; disable interrupts
	ld hl,tab45	; table of init parameters to load into MC6845
	ld b,0	; counter of registers
lp45	ld a,b	; check if counter reached last register
	inc b
	cp a,10
	jr z,outt	; jump out of loop if so
	out (mc45),a	; else send reg address to mc6845
	ld a,(hl)
	inc hl
	out (mc45+1),a	; send reg value to MC6845
	jr lp45

tab45	db 38	; R0 H. Total
	db 32	; R1 H. Displayed
	db 33	; R2 H. Sync Position
	db 2	; R3 H. Sync Width
	db 16	; R4 V. Total
	db 7	; R5 V. Scan Line Adjust
	db 16	; R6 V. Displayed
	db 16	; R7 V. Sync Position
	db 0	; R8 Interlace Mode Register
	db 14	; R9 Max. Scan Line Address
	db 0	; R10 Cursor Start
	db 0	; R11 Cursor End
	db 0	; R12 Start Address (H)
	db 0	; R13 Start Address (L)
	db 0	; R14 Cursor (H)
	db 0	; R15 Cursor (L)
	db 0	; R16 Light Pen (H)
	db 0	; R17 Light Pen (L)

outt	ld b,1
out1	ld a,b
	out (cpld),a

	ld a,$ff
out2	nop
	nop
	nop
	dec a
	jr nz,out2

	inc b
	jr nz,out1

memt	ld a,$1
	out (cpld),a

	ld hl,$8000
	ld de,$8001
	ld bc,$1fff
	ld (hl),0
	ldir

	ld a,$2
	out (cpld),a

	ld hl,$8000
	ld bc,$2000
ty	ld a,0
	cp a,(hl)
	jr nz,tx
	dec bc
	inc hl
	ld a,b
	or a,c
	jr nz,ty

tx	ld a,$4
	out (cpld),a

	ld a,b
	or a,c
	jr z,blink
	ld a,h
	out (cpld),a

	ld b,3
t4	ld de,$ffff
t3	dec de
	ld a,d
	or a,e
	jr nz,t3
	dec b
	jr nz,t4

	ld a,l
	out (cpld),a

	ld b,3
t8	ld de,$ffff
t7	dec de
	ld a,d
	or a,e
	jr nz,t7
	dec b
	jr nz,t8

	ld a,(hl)
	out (cpld),a

	ld b,3
t14	ld de,$ffff
t13	dec de
	ld a,d
	or a,e
	jr nz,t13
	dec b
	jr nz,t14

	inc hl
	ld a,h
	out (cpld),a

	ld b,3
t10	ld de,$ffff
t9	dec de
	ld a,d
	or a,e
	jr nz,t9
	dec b
	jr nz,t10

	ld a,l
	out (cpld),a

	ld b,3
t12	ld de,$ffff
t11	dec de
	ld a,d
	or a,e
	jr nz,t11
	dec b
	jr nz,t12

	ld a,(hl)
	out (cpld),a


cp4	jr cp4

blink ld a,$55
	out (cpld),a

	ld de,$ffff
l1	dec de
	ld a,d
	or a,e
	jr nz,l1

	ld a,$aa
	out (cpld),a

	ld de,$ffff
l2	dec de
	ld a,d
	or a,e
	jr nz,l2

	jr blink


endprog	equ $

	output_bin "myz80_6845init.bin",$0000,endprog    ; The binary file
