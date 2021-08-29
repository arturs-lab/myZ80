	ORG	FA00

FA00	jp	FBA5

FA03
	DB	$21 $13 $C2 $11 $12 $FA $01 $2C $01 $ED $B0 $C9 $0F
	DB	$0F $0F $A8 $01 $9F $06 $3D $01 $1E $FB $00 $00 $0F $00 $00 $00
	DB	$10 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $6C $EA
	DB	$61 $EA $54 $EE $49 $EE $3C $F2 $31 $F2 $24 $F6 $19 $F6 $E6 $08
	DB	$07 $06 $05 $06 $07 $08 $09 $0A $0B $0B $0B $0B $0B $0B $0B $0F
	DB	$0E $0D $0C $0B $0A $09 $08 $07 $06 $05 $04 $03 $02 $01 $00 $0F
	DB	$0E $0D $0C $0B $0A $09 $08 $08 $09 $0A $0B $0C $0D $0E $0F $04
	DB	$06 $08 $0A $0B $0C $0D $0E $0F $0E $0D $0C $0B $0A $07 $03 $08
	DB	$0C $0C $0C $0C $0C $0C $0C $0C $0C $0C $0C $0C $0B $09 $08 $0B
	DB	$0B $0B $0B $0B $0B $0B $0B $08 $05 $02 $02 $03 $03 $03 $03 $08
	DB	$0B $0D $0E $0F $0F $0E $0D $0C $0B $0A $09 $09 $09 $09 $09 $0F
	DB	$00 $0F $00 $0F $00 $0F $00 $0F $00 $0F $00 $0F $00 $0F $08 $9F
	DB	$06 $40 $06 $E6 $05 $91 $05 $41 $05 $F6 $04 $AE $04 $6B $04 $2C
	DB	$04 $F0 $03 $B7 $03 $82 $03 $4F $03 $20 $03 $F3 $02 $C8 $02 $A1
	DB	$02 $7B $02 $57 $02 $36 $02 $16 $02 $F8 $01 $DC $01 $C1 $01 $A8
	DB	$01 $90 $01 $79 $01 $64 $01 $50 $01 $3D $01 $2C $01 $1B $01 $0B
	DB	$01 $FC $00 $EE $00 $E0 $00 $D4 $00 $C8 $00 $BD $00 $B2 $00 $A8
	DB	$00 $9F $00 $96 $00 $8D $00 $85 $00 $7E $00 $77 $00 $70 $00 $6A
	DB	$00 $64 $00 $5E $00 $59 $00 $54 $00 $FF $FF $08 $09 $18 $09 $00
	DB	$80 $1C $80 $04 $10 $0C $10 $14 $10 $1C $80 $1E $80 $00 $00 $00
	DB	$00 $00 $00 $00 $00 


FB45	call	FB51
	call	028E
	inc	e
	jr	z,FB45
	jp	FBC7

FB51	di
	ld	hl,FA19
	ld	b,FF
	ld	(hl),b
	inc	hl
	inc	b
	call	FCD9
	ld	hl,FA20
	ld	(hl),b
	inc	hl
	call	FCD9
	ld	hl,FA27
	ld	(hl),b
	inc	hl
	call	FCD9
	inc	hl
	call	FCD9
	ld	hl,FA3A
	call	FBD0
	call	FC9D
	ld	hl,FA2E
	call	FBD0
	ld	a,01
	call	FBF4
	ld	hl,FA32
	call	FBD0
	ld	a,02
	call	FBF4
	ld	hl,FA36
	call	FBD0
	ld	a,03
	call	FBF4
	call	FD15
	call	FDC6
	call	FC72
	ret

FBA5	ld	hl,EA60
	ld	de,FA2E
	ld	bc,03E8
	call	FBBD
	call	FBBD
	call	FBBD
	call	FBBD
	jp	FB45

FBBD	ld	a,l
	ld	(de),a
	inc	de
	ld	a,h
	ld	(de),a
	inc	de
	add	hl,bc
	inc	de
	inc	de
	ret

FBC7	ld	d,07
	ld	e,FF
	call	FDB8
	ei
	ret

FBD0	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	de
FBD4	ld	a,(de)
	cp	3F
	jp	z,FBEB
	ld	b,a
	ld	(hl),d
	dec	hl
	ld	(hl),e
	add	a,a
	ld	e,a
	ld	d,00
	ld	hl,FABF
	add	hl,de
	ld	d,(hl)
	inc	hl
	ld	e,(hl)
	ex	de,hl
	ret

FBEB	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	hl
	dec	hl
	jp	FBD4

FBF4	ld	c,a
	ld	a,b
	cp	36
	jr	nc,FC39
	ld	a,FF
	cp	h
	ret	z
	ld	a,c
	push	hl
	add	a,a
	dec	a
	ld	hl,FA10
	ld	d,00
	ld	e,a
	add	hl,de
	pop	de
	ld	(hl),e
	dec	hl
	ld	(hl),d
	ld	hl,FA24
	ld	d,00
	ld	e,c
	add	hl,de
	dec	hl
	ld	a,(hl)
	dec	hl
	dec	hl
	dec	hl
	ld	(hl),a
	ld	hl,FA0F
	add	hl,de
	dec	hl
	ld	a,(hl)
	ld	hl,FA19
	add	hl,de
	ld	(hl),a
	ld	hl,FA19
	dec	c
	jp	nz,FC2E
	res	0,(hl)
FC2E	dec	c
	jp	nz,FC34
	res	1,(hl)
FC34	dec	c
	ret	nz
	res	2,(hl)
	ret
FC39	ld	a,h
	ld	(FA18),a
	ld	a,l
	and	F0
	cp	00
	jr	z,FC63
	rrca
	rrca
	rrca
	rrca
FC48	ld	hl,FA21
	ld	d,00
	ld	e,c
	add	hl,de
	dec	hl
	ld	(hl),a
	ld	hl,FA19
	dec	c
	jr	nz,FC5A
	res	3,(hl)
	ret
FC5A	dec	c
	jr	nz,FC60
	res	4,(hl)
	ret
FC60	res	5,(hl)
	ret
FC63	ld	a,l
	and	0F
	ld	hl,FA1A
	ld	d,00
	ld	e,c
	add	hl,de
	dec	hl
	ld	(hl),a
	xor	a
	jr	FC48
FC72	ld	a,01
	call	FDD5
	ld	a,02
	call	FDD5
	ld	a,03
	call	FDD5
	call	FDC6
	ld	a,(FA3E)
FC87	ld	b,32
FC89	nop
	djnz	FC89
	inc	a
	jr	nz,FC87
	call	FD95
	ld	hl,FA20
	inc	(hl)
	ld	a,(hl)
	cp	10
	ret	z
	jp	FC72

FC9D	ld	a,b
	and	03
	ld	c,a
	bit	2,b
	jr	nz,FCAB
	bit	3,b
	jp	nz,FCDF
	ret

FCAB	bit	3,b
	jp	nz,FCF5
	ld	a,F0
	and	b
	rrc	a
	rrc	a
	rrc	a
	rrc	a
	ld	b,a
	xor	a
	cp	c
	jr	z,FCCE
	ld	hl,FA0F
	ld	d,00
	ld	e,c
	add	hl,de
	dec	hl
	ld	(hl),b
	ld	b,00
	jp	FD05
FCCE	ld	hl,FA0F
	call	FCD9
	ld	b,00
	jp	FD0F

FCD9	ld	(hl),b
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),b
	ret

FCDF	ld	a,c
	ld	(FB3F),a
	ld	a,F0
	and	b
	rlca
	rlca
	rlca
	bit	4,b
	ld	b,a
	jr	z,FCF1
	xor	7F
	inc	a
FCF1	ld	(FA27),a
	ret
FCF5	bit	4,b
	ret	nz
	ld	a,E0
	and	b
	rlca
	rlc	a
	rlc	a
	ld	b,a
	xor	a
	cp	c
	jr	z,FD0F
FD05	ld	d,00
	ld	e,c
	ld	hl,FA24
	add	hl,de
	dec	hl
	ld	(hl),b
	ret
FD0F	ld	hl,FA24
	jp	FCD9
FD15	ld	hl,FA27
	xor	a
	cp	(hl)
	ret	z
	ld	b,(hl)
	ld	a,(FB3F)
	cp	00
	jr	z,FD43
	ld	ix,FA12
	ld	hl,FA2E
	dec	a
	jp	z,FD5E
	ld	hl,FA32
	inc	ix
	inc	ix
	dec	a
	jp	z,FD5E
	ld	hl,FA36
	inc	ix
	inc	ix
	jp	FD5E
FD43	ld	hl,FA2E
	ld	ix,FA12
	call	FD5E
	inc	ix
	inc	ix
	ld	hl,FA32
	call	FD5E
	inc	ix
	inc	ix
	ld	hl,FA36
FD5E	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	add	a,b
	cp	35
	ret	nc
	ld	d,00
	add	a,a
	ld	e,a
	ld	hl,FABF
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	l,(ix+00)
	ld	h,(ix+01)
	ex	de,hl
	xor	a
	sbc	hl,de
	ld	a,l
	ld	l,h
	ld	h,a
	xor	a
	push	bc
	ld	b,04
FD82	xor	00
	rr	h
	rr	l
	rr	a
	djnz	FD82
	or	h
	ld	(ix+16),a
	ld	(ix+17),l
	pop	bc
	ret
FD95	ld	hl,FA12
	ld	de,FA28
	ld	b,03
FD9D	ld	a,(hl)
	push	hl
	inc	hl
	ld	h,(hl)
	ld	l,a
	ex	de,hl
	ld	a,(hl)
	inc	hl
	push	hl
	ld	h,(hl)
	ld	l,a
	add	hl,de
	jr	nc,FDAC
	inc	hl
FDAC	ld	c,h
	ld	a,l
	pop	de
	inc	de
	pop	hl
	ld	(hl),a
	inc	hl
	ld	(hl),c
	inc	hl
	djnz	FD9D
	ret

FDB8	push	bc
	ld	bc,FFFD
	out	(c),d
	ld	bc,BFFD
	out	(c),e
	pop	bc
	inc	d
	ret

FDC6	ld	hl,FA12
	ld	d,00
	ld	b,0E
FDCD	ld	e,(hl)
	inc	hl
	call	FDB8
	djnz	FDCD
	ret

FDD5	ld	hl,FA1A
	dec	a
	ld	e,a
	ld	d,00
	add	hl,de
	ex	de,hl
	ld	hl,0007
	add	hl,de
	ld	a,(hl)
	cp	00
	ret	z
	push	de
	ld	hl,FA3F
	dec	a
	rla
	rla
	rla
	rla
	ld	d,00
	ld	e,a
	add	hl,de
	ld	a,(FA20)
	ld	e,a
	add	hl,de
	ld	a,(hl)
	pop	hl
	ld	(hl),a
	ret

endprog	equ $

	output_bin "player0889.bin",$FA00,endprog    ; The binary file
