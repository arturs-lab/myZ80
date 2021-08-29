                ORG FA00

FA00	jp	FBA5

FB45	call	FB51
FB48	call	028E
FB4B	inc	e
FB4C	jr	z,FB45
FB4E	jp	FBC7

FB51	di
FB52	ld	hl,FA19
FB55	ld	b,FF
FB57	ld	(hl),b
FB58	inc	hl
FB59	inc	b
FB5A	call	FCD9
FB5D	ld	hl,FA20
FB60	ld	(hl),b
FB61	inc	hl
FB62	call	FCD9
FB65	ld	hl,FA27
FB68	ld	(hl),b
FB69	inc	hl
FB6A	call	FCD9
FB6D	inc	hl
FB6E	call	FCD9
FB71	ld	hl,FA3A
FB74	call	FBD0
FB77	call	FC9D
FB7A	ld	hl,FA2E
FB7D	call	FBD0
FB80	ld	a,01
FB82	call	FBF4
FB85	ld	hl,FA32
FB88	call	FBD0
FB8B	ld	a,02
FB8D	call	FBF4
FB90	ld	hl,FA36
FB93	call	FBD0
FB96	ld	a,03
FB98	call	FBF4
FB9B	call	FD15
FB9E	call	FDC6
FBA1	call	FC72
FBA4	ret

FBA5	ld	hl,EA60
FBA8	ld	de,FA2E
FBAB	ld	bc,03E8
FBAE	call	FBBD
FBB1	call	FBBD
FBB4	call	FBBD
FBB7	call	FBBD
FBBA	jp	FB45

FBBD	ld	a,l
FBBE	ld	(de),a
FBBF	inc	de
FBC0	ld	a,h
FBC1	ld	(de),a
FBC2	inc	de
FBC3	add	hl,bc
FBC4	inc	de
FBC5	inc	de
FBC6	ret

FBC7	ld	d,07
FBC9	ld	e,FF
FBCB	call	FDB8
FBCE	ei
FBCF	ret

FBD0	ld	e,(hl)
FBD1	inc	hl
FBD2	ld	d,(hl)
FBD3	inc	de
FBD4	ld	a,(de)
FBD5	cp	3F
FBD7	jp	z,FBEB
FBDA	ld	b,a
FBDB	ld	(hl),d
FBDC	dec	hl
FBDD	ld	(hl),e
FBDE	add	a,a
FBDF	ld	e,a
FBE0	ld	d,00
FBE2	ld	hl,FABF
FBE5	add	hl,de
FBE6	ld	d,(hl)
FBE7	inc	hl
FBE8	ld	e,(hl)
FBE9	ex	de,hl
FBEA	ret

FBEB	inc	hl
FBEC	ld	e,(hl)
FBED	inc	hl
FBEE	ld	d,(hl)
FBEF	dec	hl
FBF0	dec	hl
FBF1	jp	FBD4

FBF4	ld	c,a
FBF5	ld	a,b
FBF6	cp	36
FBF8	jr	nc,FC39
FBFA	ld	a,FF
FBFC	cp	h
FBFD	ret	z
FBFE	ld	a,c
FBFF	push	hl
FC00	add	a,a
FC01	dec	a
FC02	ld	hl,FA10
FC05	ld	d,00
FC07	ld	e,a
FC08	add	hl,de
FC09	pop	de
FC0A	ld	(hl),e
FC0B	dec	hl
FC0C	ld	(hl),d
FC0D	ld	hl,FA24
FC10	ld	d,00
FC12	ld	e,c
FC13	add	hl,de
FC14	dec	hl
FC15	ld	a,(hl)
FC16	dec	hl
FC17	dec	hl
FC18	dec	hl
FC19	ld	(hl),a
FC1A	ld	hl,FA0F
FC1D	add	hl,de
FC1E	dec	hl
FC1F	ld	a,(hl)
FC20	ld	hl,FA19
FC23	add	hl,de
FC24	ld	(hl),a
FC25	ld	hl,FA19
FC28	dec	c
FC29	jp	nz,FC2E
FC2C	res	0,(hl)
FC2E	dec	c
FC2F	jp	nz,FC34
FC32	res	1,(hl)
FC34	dec	c
FC35	ret	nz
FC36	res	2,(hl)
FC38	ret
FC39	ld	a,h
FC3A	ld	(FA18),a
FC3D	ld	a,l
FC3E	and	F0
FC40	cp	00
FC42	jr	z,FC63
FC44	rrca
FC45	rrca
FC46	rrca
FC47	rrca
FC48	ld	hl,FA21
FC4B	ld	d,00
FC4D	ld	e,c
FC4E	add	hl,de
FC4F	dec	hl
FC50	ld	(hl),a
FC51	ld	hl,FA19
FC54	dec	c
FC55	jr	nz,FC5A
FC57	res	3,(hl)
FC59	ret
FC5A	dec	c
FC5B	jr	nz,FC60
FC5D	res	4,(hl)
FC5F	ret
FC60	res	5,(hl)
FC62	ret
FC63	ld	a,l
FC64	and	0F
FC66	ld	hl,FA1A
FC69	ld	d,00
FC6B	ld	e,c
FC6C	add	hl,de
FC6D	dec	hl
FC6E	ld	(hl),a
FC6F	xor	a
FC70	jr	FC48
FC72	ld	a,01
FC74	call	FDD5
FC77	ld	a,02
FC79	call	FDD5
FC7C	ld	a,03
FC7E	call	FDD5
FC81	call	FDC6
FC84	ld	a,(FA3E)
FC87	ld	b,32
FC89	nop
FC8A	djnz	FC89
FC8C	inc	a
FC8D	jr	nz,FC87
FC8F	call	FD95
FC92	ld	hl,FA20
FC95	inc	(hl)
FC96	ld	a,(hl)
FC97	cp	10
FC99	ret	z
FC9A	jp	FC72

FC9D	ld	a,b
FC9E	and	03
FCA0	ld	c,a
FCA1	bit	2,b
FCA3	jr	nz,FCAB
FCA5	bit	3,b
FCA7	jp	nz,FCDF
FCAA	ret

FCAB	bit	3,b
FCAD	jp	nz,FCF5
FCB0	ld	a,F0
FCB2	and	b
FCB3	rrc	a
FCB5	rrc	a
FCB7	rrc	a
FCB9	rrc	a
FCBB	ld	b,a
FCBC	xor	a
FCBD	cp	c
FCBE	jr	z,FCCE
FCC0	ld	hl,FA0F
FCC3	ld	d,00
FCC5	ld	e,c
FCC6	add	hl,de
FCC7	dec	hl
FCC8	ld	(hl),b
FCC9	ld	b,00
FCCB	jp	FD05
FCCE	ld	hl,FA0F
FCD1	call	FCD9
FCD4	ld	b,00
FCD6	jp	FD0F

FCD9	ld	(hl),b
FCDA	inc	hl
FCDB	ld	(hl),b
FCDC	inc	hl
FCDD	ld	(hl),b
FCDE	ret

FCDF	ld	a,c
FCE0	ld	(FB3F),a
FCE3	ld	a,F0
FCE5	and	b
FCE6	rlca
FCE7	rlca
FCE8	rlca
FCE9	bit	4,b
FCEB	ld	b,a
FCEC	jr	z,FCF1
FCEE	xor	7F
FCF0	inc	a
FCF1	ld	(FA27),a
FCF4	ret
FCF5	bit	4,b
FCF7	ret	nz
FCF8	ld	a,E0
FCFA	and	b
FCFB	rlca
FCFC	rlc	a
FCFE	rlc	a
FD00	ld	b,a
FD01	xor	a
FD02	cp	c
FD03	jr	z,FD0F
FD05	ld	d,00
FD07	ld	e,c
FD08	ld	hl,FA24
FD0B	add	hl,de
FD0C	dec	hl
FD0D	ld	(hl),b
FD0E	ret
FD0F	ld	hl,FA24
FD12	jp	FCD9
FD15	ld	hl,FA27
FD18	xor	a
FD19	cp	(hl)
FD1A	ret	z
FD1B	ld	b,(hl)
FD1C	ld	a,(FB3F)
FD1F	cp	00
FD21	jr	z,FD43
FD23	ld	ix,FA12
FD27	ld	hl,FA2E
FD2A	dec	a
FD2B	jp	z,FD5E
FD2E	ld	hl,FA32
FD31	inc	ix
FD33	inc	ix
FD35	dec	a
FD36	jp	z,FD5E
FD39	ld	hl,FA36
FD3C	inc	ix
FD3E	inc	ix
FD40	jp	FD5E
FD43	ld	hl,FA2E
FD46	ld	ix,FA12
FD4A	call	FD5E
FD4D	inc	ix
FD4F	inc	ix
FD51	ld	hl,FA32
FD54	call	FD5E
FD57	inc	ix
FD59	inc	ix
FD5B	ld	hl,FA36
FD5E	ld	e,(hl)
FD5F	inc	hl
FD60	ld	d,(hl)
FD61	ld	a,(de)
FD62	add	a,b
FD63	cp	35
FD65	ret	nc
FD66	ld	d,00
FD68	add	a,a
FD69	ld	e,a
FD6A	ld	hl,FABF
FD6D	add	hl,de
FD6E	ld	e,(hl)
FD6F	inc	hl
FD70	ld	d,(hl)
FD71	ld	l,(ix+00)
FD74	ld	h,(ix+01)
FD77	ex	de,hl
FD78	xor	a
FD79	sbc	hl,de
FD7B	ld	a,l
FD7C	ld	l,h
FD7D	ld	h,a
FD7E	xor	a
FD7F	push	bc
FD80	ld	b,04
FD82	xor	00
FD84	rr	h
FD86	rr	l
FD88	rr	a
FD8A	djnz	FD82
FD8C	or	h
FD8D	ld	(ix+16),a
FD90	ld	(ix+17),l
FD93	pop	bc
FD94	ret
FD95	ld	hl,FA12
FD98	ld	de,FA28
FD9B	ld	b,03
FD9D	ld	a,(hl)
FD9E	push	hl
FD9F	inc	hl
FDA0	ld	h,(hl)
FDA1	ld	l,a
FDA2	ex	de,hl
FDA3	ld	a,(hl)
FDA4	inc	hl
FDA5	push	hl
FDA6	ld	h,(hl)
FDA7	ld	l,a
FDA8	add	hl,de
FDA9	jr	nc,FDAC
FDAB	inc	hl
FDAC	ld	c,h
FDAD	ld	a,l
FDAE	pop	de
FDAF	inc	de
FDB0	pop	hl
FDB1	ld	(hl),a
FDB2	inc	hl
FDB3	ld	(hl),c
FDB4	inc	hl
FDB5	djnz	FD9D
FDB7	ret

FDB8	push	bc
FDB9	ld	bc,FFFD
FDBC	out	(c),d
FDBE	ld	bc,BFFD
FDC1	out	(c),e
FDC3	pop	bc
FDC4	inc	d
FDC5	ret

FDC6	ld	hl,FA12
FDC9	ld	d,00
FDCB	ld	b,0E
FDCD	ld	e,(hl)
FDCE	inc	hl
FDCF	call	FDB8
FDD2	djnz	FDCD
FDD4	ret

FDD5	ld	hl,FA1A
FDD8	dec	a
FDD9	ld	e,a
FDDA	ld	d,00
FDDC	add	hl,de
FDDD	ex	de,hl
FDDE	ld	hl,0007
FDE1	add	hl,de
FDE2	ld	a,(hl)
FDE3	cp	00
FDE5	ret	z
FDE6	push	de
FDE7	ld	hl,FA3F
FDEA	dec	a
FDEB	rla
FDEC	rla
FDED	rla
FDEE	rla
FDEF	ld	d,00
FDF1	ld	e,a
FDF2	add	hl,de
FDF3	ld	a,(FA20)
FDF6	ld	e,a
FDF7	add	hl,de
FDF8	ld	a,(hl)
FDF9	pop	hl
FDFA	ld	(hl),a
FDFB	ret
