                ORG FA00

FA00  C3 A5FB	jp	FBA5

FB45  CD 51FB	call	FB51
FB48  CD 8E02	call	028E
FB4B  1C	inc	e
FB4C  28 F7	jr	z,FB45
FB4E  C3 C7FB	jp	FBC7

FB51  F3	di
FB52  21 19FA	ld	hl,FA19
FB55  06 FF	ld	b,FF
FB57  70	ld	(hl),b
FB58  23	inc	hl
FB59  04	inc	b
FB5A  CD D9FC	call	FCD9
FB5D  21 20FA	ld	hl,FA20
FB60  70	ld	(hl),b
FB61  23	inc	hl
FB62  CD D9FC	call	FCD9
FB65  21 27FA	ld	hl,FA27
FB68  70	ld	(hl),b
FB69  23	inc	hl
FB6A  CD D9FC	call	FCD9
FB6D  23	inc	hl
FB6E  CD D9FC	call	FCD9
FB71  21 3AFA	ld	hl,FA3A
FB74  CD D0FB	call	FBD0
FB77  CD 9DFC	call	FC9D
FB7A  21 2EFA	ld	hl,FA2E
FB7D  CD D0FB	call	FBD0
FB80  3E 01	ld	a,01
FB82  CD F4FB	call	FBF4
FB85  21 32FA	ld	hl,FA32
FB88  CD D0FB	call	FBD0
FB8B  3E 02	ld	a,02
FB8D  CD F4FB	call	FBF4
FB90  21 36FA	ld	hl,FA36
FB93  CD D0FB	call	FBD0
FB96  3E 03	ld	a,03
FB98  CD F4FB	call	FBF4
FB9B  CD 15FD	call	FD15
FB9E  CD C6FD	call	FDC6
FBA1  CD 72FC	call	FC72
FBA4  C9	ret

FBA5  21 60EA	ld	hl,EA60
FBA8  11 2EFA	ld	de,FA2E
FBAB  01 E803	ld	bc,03E8
FBAE  CD BDFB	call	FBBD
FBB1  CD BDFB	call	FBBD
FBB4  CD BDFB	call	FBBD
FBB7  CD BDFB	call	FBBD
FBBA  C3 45FB	jp	FB45

FBBD  7D	ld	a,l
FBBE  12	ld	(de),a
FBBF  13	inc	de
FBC0  7C	ld	a,h
FBC1  12	ld	(de),a
FBC2  13	inc	de
FBC3  09	add	hl,bc
FBC4  13	inc	de
FBC5  13	inc	de
FBC6  C9	ret

FBC7  16 07	ld	d,07
FBC9  1E FF	ld	e,FF
FBCB  CD B8FD	call	FDB8
FBCE  FB	ei
FBCF  C9	ret

FBD0  5E	ld	e,(hl)
FBD1  23	inc	hl
FBD2  56	ld	d,(hl)
FBD3  13	inc	de
FBD4  1A	ld	a,(de)
FBD5  FE 3F	cp	3F
FBD7  CA EBFB	jp	z,FBEB
FBDA  47	ld	b,a
FBDB  72	ld	(hl),d
FBDC  2B	dec	hl
FBDD  73	ld	(hl),e
FBDE  87	add	a,a
FBDF  5F	ld	e,a
FBE0  16 00	ld	d,00
FBE2  21 BFFA	ld	hl,FABF
FBE5  19	add	hl,de
FBE6  56	ld	d,(hl)
FBE7  23	inc	hl
FBE8  5E	ld	e,(hl)
FBE9  EB	ex	de,hl
FBEA  C9	ret

FBEB  23	inc	hl
FBEC  5E	ld	e,(hl)
FBED  23	inc	hl
FBEE  56	ld	d,(hl)
FBEF  2B	dec	hl
FBF0  2B	dec	hl
FBF1  C3 D4FB	jp	FBD4

FBF4  4F	ld	c,a
FBF5  78	ld	a,b
FBF6  FE 36	cp	36
FBF8  30 3F	jr	nc,FC39
FBFA  3E FF	ld	a,FF
FBFC  BC	cp	h
FBFD  C8	ret	z
FBFE  79	ld	a,c
FBFF  E5	push	hl
FC00  87	add	a,a
FC01  3D	dec	a
FC02  21 10FA	ld	hl,FA10
FC05  16 00	ld	d,00
FC07  5F	ld	e,a
FC08  19	add	hl,de
FC09  D1	pop	de
FC0A  73	ld	(hl),e
FC0B  2B	dec	hl
FC0C  72	ld	(hl),d
FC0D  21 24FA	ld	hl,FA24
FC10  16 00	ld	d,00
FC12  59	ld	e,c
FC13  19	add	hl,de
FC14  2B	dec	hl
FC15  7E	ld	a,(hl)
FC16  2B	dec	hl
FC17  2B	dec	hl
FC18  2B	dec	hl
FC19  77	ld	(hl),a
FC1A  21 0FFA	ld	hl,FA0F
FC1D  19	add	hl,de
FC1E  2B	dec	hl
FC1F  7E	ld	a,(hl)
FC20  21 19FA	ld	hl,FA19
FC23  19	add	hl,de
FC24  77	ld	(hl),a
FC25  21 19FA	ld	hl,FA19
FC28  0D	dec	c
FC29  C2 2EFC	jp	nz,FC2E
FC2C  CB86	res	0,(hl)
FC2E  0D	dec	c
FC2F  C2 34FC	jp	nz,FC34
FC32  CB8E	res	1,(hl)
FC34  0D	dec	c
FC35  C0	ret	nz
FC36  CB96	res	2,(hl)
FC38  C9	ret
FC39  7C	ld	a,h
FC3A  32 18FA	ld	(FA18),a
FC3D  7D	ld	a,l
FC3E  E6 F0	and	F0
FC40  FE 00	cp	00
FC42  28 1F	jr	z,FC63
FC44  0F	rrca
FC45  0F	rrca
FC46  0F	rrca
FC47  0F	rrca
FC48  21 21FA	ld	hl,FA21
FC4B  16 00	ld	d,00
FC4D  59	ld	e,c
FC4E  19	add	hl,de
FC4F  2B	dec	hl
FC50  77	ld	(hl),a
FC51  21 19FA	ld	hl,FA19
FC54  0D	dec	c
FC55  20 03	jr	nz,FC5A
FC57  CB9E	res	3,(hl)
FC59  C9	ret
FC5A  0D	dec	c
FC5B  20 03	jr	nz,FC60
FC5D  CBA6	res	4,(hl)
FC5F  C9	ret
FC60  CBAE	res	5,(hl)
FC62  C9	ret
FC63  7D	ld	a,l
FC64  E6 0F	and	0F
FC66  21 1AFA	ld	hl,FA1A
FC69  16 00	ld	d,00
FC6B  59	ld	e,c
FC6C  19	add	hl,de
FC6D  2B	dec	hl
FC6E  77	ld	(hl),a
FC6F  AF	xor	a
FC70  18 D6	jr	FC48
FC72  3E 01	ld	a,01
FC74  CD D5FD	call	FDD5
FC77  3E 02	ld	a,02
FC79  CD D5FD	call	FDD5
FC7C  3E 03	ld	a,03
FC7E  CD D5FD	call	FDD5
FC81  CD C6FD	call	FDC6
FC84  3A 3EFA	ld	a,(FA3E)
FC87  06 32	ld	b,32
FC89  00	nop
FC8A  10 FD	djnz	FC89
FC8C  3C	inc	a
FC8D  20 F8	jr	nz,FC87
FC8F  CD 95FD	call	FD95
FC92  21 20FA	ld	hl,FA20
FC95  34	inc	(hl)
FC96  7E	ld	a,(hl)
FC97  FE 10	cp	10
FC99  C8	ret	z
FC9A  C3 72FC	jp	FC72

FC9D  78	ld	a,b
FC9E  E6 03	and	03
FCA0  4F	ld	c,a
FCA1  CB50	bit	2,b
FCA3  20 06	jr	nz,FCAB
FCA5  CB58	bit	3,b
FCA7  C2 DFFC	jp	nz,FCDF
FCAA  C9	ret

FCAB  CB58	bit	3,b
FCAD  C2 F5FC	jp	nz,FCF5
FCB0  3E F0	ld	a,F0
FCB2  A0	and	b
FCB3  CB0F	rrc	a
FCB5  CB0F	rrc	a
FCB7  CB0F	rrc	a
FCB9  CB0F	rrc	a
FCBB  47	ld	b,a
FCBC  AF	xor	a
FCBD  B9	cp	c
FCBE  28 0E	jr	z,FCCE
FCC0  21 0FFA	ld	hl,FA0F
FCC3  16 00	ld	d,00
FCC5  59	ld	e,c
FCC6  19	add	hl,de
FCC7  2B	dec	hl
FCC8  70	ld	(hl),b
FCC9  06 00	ld	b,00
FCCB  C3 05FD	jp	FD05
FCCE  21 0FFA	ld	hl,FA0F
FCD1  CD D9FC	call	FCD9
FCD4  06 00	ld	b,00
FCD6  C3 0FFD	jp	FD0F

FCD9  70	ld	(hl),b
FCDA  23	inc	hl
FCDB  70	ld	(hl),b
FCDC  23	inc	hl
FCDD  70	ld	(hl),b
FCDE  C9	ret

FCDF  79	ld	a,c
FCE0  32 3FFB	ld	(FB3F),a
FCE3  3E F0	ld	a,F0
FCE5  A0	and	b
FCE6  07	rlca
FCE7  07	rlca
FCE8  07	rlca
FCE9  CB60	bit	4,b
FCEB  47	ld	b,a
FCEC  28 03	jr	z,FCF1
FCEE  EE 7F	xor	7F
FCF0  3C	inc	a
FCF1  32 27FA	ld	(FA27),a
FCF4  C9	ret
FCF5  CB60	bit	4,b
FCF7  C0	ret	nz
FCF8  3E E0	ld	a,E0
FCFA  A0	and	b
FCFB  07	rlca
FCFC  CB07	rlc	a
FCFE  CB07	rlc	a
FD00  47	ld	b,a
FD01  AF	xor	a
FD02  B9	cp	c
FD03  28 0A	jr	z,FD0F
FD05  16 00	ld	d,00
FD07  59	ld	e,c
FD08  21 24FA	ld	hl,FA24
FD0B  19	add	hl,de
FD0C  2B	dec	hl
FD0D  70	ld	(hl),b
FD0E  C9	ret
FD0F  21 24FA	ld	hl,FA24
FD12  C3 D9FC	jp	FCD9
FD15  21 27FA	ld	hl,FA27
FD18  AF	xor	a
FD19  BE	cp	(hl)
FD1A  C8	ret	z
FD1B  46	ld	b,(hl)
FD1C  3A 3FFB	ld	a,(FB3F)
FD1F  FE 00	cp	00
FD21  28 20	jr	z,FD43
FD23  DD21 12FA	ld	ix,FA12
FD27  21 2EFA	ld	hl,FA2E
FD2A  3D	dec	a
FD2B  CA 5EFD	jp	z,FD5E
FD2E  21 32FA	ld	hl,FA32
FD31  DD23	inc	ix
FD33  DD23	inc	ix
FD35  3D	dec	a
FD36  CA 5EFD	jp	z,FD5E
FD39  21 36FA	ld	hl,FA36
FD3C  DD23	inc	ix
FD3E  DD23	inc	ix
FD40  C3 5EFD	jp	FD5E
FD43  21 2EFA	ld	hl,FA2E
FD46  DD21 12FA	ld	ix,FA12
FD4A  CD 5EFD	call	FD5E
FD4D  DD23	inc	ix
FD4F  DD23	inc	ix
FD51  21 32FA	ld	hl,FA32
FD54  CD 5EFD	call	FD5E
FD57  DD23	inc	ix
FD59  DD23	inc	ix
FD5B  21 36FA	ld	hl,FA36
FD5E  5E	ld	e,(hl)
FD5F  23	inc	hl
FD60  56	ld	d,(hl)
FD61  1A	ld	a,(de)
FD62  80	add	a,b
FD63  FE 35	cp	35
FD65  D0	ret	nc
FD66  16 00	ld	d,00
FD68  87	add	a,a
FD69  5F	ld	e,a
FD6A  21 BFFA	ld	hl,FABF
FD6D  19	add	hl,de
FD6E  5E	ld	e,(hl)
FD6F  23	inc	hl
FD70  56	ld	d,(hl)
FD71  DD6E 00	ld	l,(ix+00)
FD74  DD66 01	ld	h,(ix+01)
FD77  EB	ex	de,hl
FD78  AF	xor	a
FD79  ED52	sbc	hl,de
FD7B  7D	ld	a,l
FD7C  6C	ld	l,h
FD7D  67	ld	h,a
FD7E  AF	xor	a
FD7F  C5	push	bc
FD80  06 04	ld	b,04
FD82  EE 00	xor	00
FD84  CB1C	rr	h
FD86  CB1D	rr	l
FD88  CB1F	rr	a
FD8A  10 F6	djnz	FD82
FD8C  B4	or	h
FD8D  DD77 16	ld	(ix+16),a
FD90  DD75 17	ld	(ix+17),l
FD93  C1	pop	bc
FD94  C9	ret
FD95  21 12FA	ld	hl,FA12
FD98  11 28FA	ld	de,FA28
FD9B  06 03	ld	b,03
FD9D  7E	ld	a,(hl)
FD9E  E5	push	hl
FD9F  23	inc	hl
FDA0  66	ld	h,(hl)
FDA1  6F	ld	l,a
FDA2  EB	ex	de,hl
FDA3  7E	ld	a,(hl)
FDA4  23	inc	hl
FDA5  E5	push	hl
FDA6  66	ld	h,(hl)
FDA7  6F	ld	l,a
FDA8  19	add	hl,de
FDA9  30 01	jr	nc,FDAC
FDAB  23	inc	hl
FDAC  4C	ld	c,h
FDAD  7D	ld	a,l
FDAE  D1	pop	de
FDAF  13	inc	de
FDB0  E1	pop	hl
FDB1  77	ld	(hl),a
FDB2  23	inc	hl
FDB3  71	ld	(hl),c
FDB4  23	inc	hl
FDB5  10 E6	djnz	FD9D
FDB7  C9	ret

FDB8  C5	push	bc
FDB9  01 FDFF	ld	bc,FFFD
FDBC  ED51	out	(c),d
FDBE  01 FDBF	ld	bc,BFFD
FDC1  ED59	out	(c),e
FDC3  C1	pop	bc
FDC4  14	inc	d
FDC5  C9	ret

FDC6  21 12FA	ld	hl,FA12
FDC9  16 00	ld	d,00
FDCB  06 0E	ld	b,0E
FDCD  5E	ld	e,(hl)
FDCE  23	inc	hl
FDCF  CD B8FD	call	FDB8
FDD2  10 F9	djnz	FDCD
FDD4  C9	ret

FDD5  21 1AFA	ld	hl,FA1A
FDD8  3D	dec	a
FDD9  5F	ld	e,a
FDDA  16 00	ld	d,00
FDDC  19	add	hl,de
FDDD  EB	ex	de,hl
FDDE  21 0700	ld	hl,0007
FDE1  19	add	hl,de
FDE2  7E	ld	a,(hl)
FDE3  FE 00	cp	00
FDE5  C8	ret	z
FDE6  D5	push	de
FDE7  21 3FFA	ld	hl,FA3F
FDEA  3D	dec	a
FDEB  17	rla
FDEC  17	rla
FDED  17	rla
FDEE  17	rla
FDEF  16 00	ld	d,00
FDF1  5F	ld	e,a
FDF2  19	add	hl,de
FDF3  3A 20FA	ld	a,(FA20)
FDF6  5F	ld	e,a
FDF7  19	add	hl,de
FDF8  7E	ld	a,(hl)
FDF9  E1	pop	hl
FDFA  77	ld	(hl),a
FDFB  C9	ret
