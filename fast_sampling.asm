# bajtek 1990/07-08
# by bromba

	org 60000

len	equ 16384
pocz	equ 32768

	ld bc,65533
	ld a,7
	out (c),a
	ld bc,49149
	ld a,255
	out (c),a

	di
	ld hl,pocz
	ld bc,65533
	ld a,#08
	out (c),a
	ld b,#bf
	ld de,len
main	ld a,(delay)
wait1	dec a
	jr nz,wait1
	rld
	out (c),a
	rrd
	ld a,(delay)
wait2	dec a
	jr nz,wait2
	rrd
	out (c),a
	rld
	inc hl
	dec de
	ld a,d
	or e
	jr nz,main
	ei
	ret

delay	defb 10
	nop

