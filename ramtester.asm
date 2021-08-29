ramhi	equ 0
leda	equ 1

	org 0
start	jp begin


	org $100
begin	ld c,$55		; test pattern in C
l0	ld b,$00		; page counter in B, KM681000B needs A17 held high b.c. it is CS2 on it
	ld a,b		; display page counter
l1	out (leda),a	
	out (ramhi),a	; and set page register (a15-A18)
	ld ixh,b
	ld ixl,c
	ld a,c		; get test pattern
	ld hl,$8000		; ram starts at $8000
	ld de,$8001
	ld bc,$7fff
	ld (hl),a		; load test pattern into RAM
	ldir			; fill rest of RAM with it
	ld b,ixh
	ld c,ixl

	ld hl,$8000		; read back
	ld a,h
	and $f0
	or b
	out (leda),a	
l2	ld a,(hl)		; get current RAM value
	cp c			; compare with pattern
	jr nz,fail		; failed compare
	inc hl		; next ram location
	ld a,h
	cp $00		; did HL overflow to $0000?
	jr nz,l2		; no keep going

	inc b			; yes, next RAM page
	ld a,b		; finished?
	cp $10
	jr nz,l1		; no, keep going

	ld a,$ff		; yes, invert test pattern
	xor c
	ld c,a
	cp $55		; did we just test inverted pattern?
	jr nz, l0		; no, test it

; success!
ls	ld a,$aa
	out (leda),a
	ld hl,0
l3	dec hl
	ld a,h
	or a,l
	jr nz,l3
	ld a,$55
	out (leda),a
	ld hl,0
l4	dec hl
	ld a,h
	or a,l
	jr nz,l4
	jr ls

fail	ld hl,0
l8	ld a,$c0
	;ld a,b
	;or a,$30
	out (leda),a
l6	dec hl
	ld a,h
	or a,l
	jr nz,l6
	ld a,$30
	;ld a,b
	;or a,$c0
	out (leda),a
l7	dec hl
	ld a,h
	or a,l
	jr nz,l7
	jr l8

endprog	equ $

	output_bin "ramtester.bin",$0000,endprog    ; The binary file



