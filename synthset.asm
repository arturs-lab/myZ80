# bajtek 1990/07-08
# synthset by bromba

ayreg	equ 65533
aydta	equ 49149

	org 60000

	di
	ld bc,ayreg
	ld a,9
	out (c),a
	ld bc,aydta
glosno	ld a,14
	out (c),a
	ld bc,ayreg
	ld a,3
	out (c),a
	ld bc,aydta
	ld a,0
	out (c),a
	ld bc,ayreg
	ld a,2
	out (c),a
	ld bc,aydta
	ld a,0
	out (c),a

poczat	ld hl,00000
dlugos	ld de,00000
	ld b,8
delay1	ld c,13
loop1	dec c
	jr nz,loop1
	rlc (hl)
	jr c,nope
	push bc
	ld bc,ayreg
	ld a,7
	out (c),a
	ld bc,aydta
	ld a,%11111101
	out (c),a
	jr next
nope	push bc
	ld bc,ayreg
	ld a,7
	out (c),a
	ld bc,aydta
	ld a,255
	out (c),a
next	pop bc
	djnz delay1
	inc hl
	dec de
	ld b,8
delay2	ld c,11
	ld a,d
	or e
	jr nz,loop1
	ei
	ret

end	nop
