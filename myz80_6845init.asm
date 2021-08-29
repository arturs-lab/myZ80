turbo	equ $f8
mc45	equ $fa
cpld	equ $fc
memmap	equ $fe

	org 0
start	jp $100

	org $100
	di		; disable interrupts
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
	ld sp,$5000	; init SP to top of ram now that RAM passed test

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
swit	ld a,($0 << 5 ) + $10	; memmap address 2, value 10 - ram page 0 in slot 0 - ROM
	out (memmap),a
	ld a,($2 << 5 ) + $2	; memmap address 2, value 2 - ram page 2 in slot 2
	out (memmap),a
	ld a,$1			; enable turbo mode
	out (turbo),a

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

delay	ld b,3
del1	ld de,$ffff
del2	dec de
	ld a,d
	or a,e
	jr nz,del2
	dec b
	jr nz,del1

	ret

; just a pattern to mark end of code
	db $55
	db $aa

endprog	equ $

	output_bin "myz80_6845init.bin",$0000,endprog    ; The binary file
