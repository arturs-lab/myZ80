
	org 0
	jp start

	org #100
start	ld hl,EA60
l1	ld a,(hl)
	cp a,0jr z,l2
	sub a,35
	ld (hl),a
	inc hl
	jr l1

l2	ld hl,EE48
l3	ld a,(hl)
	cp a,0jr z,l4
	sub a,35
	ld (hl),a
	inc hl
	jr l3

l4	ld hl,F230
l5	ld a,(hl)
	cp a,0jr z,l6
	sub a,35
	ld (hl),a
	inc hl
	jr l5

l6	jr l6

	DB 0

	org $0a60
EA60	DB	"#KXXXNXXKXKPXKXIXKXXXRXXKXKSXRXNXKXRXKXKIXIFXMXKXXXXXXXXX')*,.023'XXX3XX1X1.X1X3X'XXX3XXXX..X1X3X*XXX/XX1X1.X1X3X'XXX3XXXX31X.X*X'XXX3XX1X1.X1X3X'ZXX3XXXX..X1X3X*ZXX/XX1X1.X1X3X'XXX3XXXX31X.X*X'ZXX3XX1X1.X1X3X'ZXX3XXXX..X1X3X*ZXX/XX1X1.X1X3X'XXX3XXXX31X.X*X'ZYX3XZ1X1.X1X3X'ZYX3XZXX..X1X3X*ZYX/XZ1X1.X1X3X'ZYX3XZXX31a.X*X'ZYX3XZ1X1.X1X3X'ZYX3XZXX..X1X3X*ZYX/XZ1X1.X1X3X'ZYX3XZXX31a.X*Xb"

	db 0

	org $0d70
EE48	DB	"XX?XX?BXB?X?DD??==?XX?FXF?X?GGFFBB??FFKF?=?==::A?XXXXXXXXXXXXX^]]X'XYXXXZXX1X.X1X3'XYXXXZXXXX.X1X3*XYXXXZXX1X.X1X3'XYXXXZXaX1a.a*\\?XYaBXZ?[[Da?a=\\?XYaFXZ?[[GaFaB\\?YFaKZZ=[[:aAa?\\ZXYaXXZXXa1a.aX\\?XYaBXZ?[[Da?a=\\?XYaFXZ?[[GaFaB\\?YFaKZZ=[[:aAa?\\ZXYaXXZXXa1a.a*\\'FKaKFZN[[.aMaM\\XFKaKFZN[[MaKaX\\*BGaGBZ1[[.aXa3\\IFKaKFZF[a1a.a*\\XFKaKFZN[[.aMaM\\XFKaKFZN[[MaKaX\\XBGaGBZ1[[.aXaI\\IFKaKFZF[a1a.a*b"

	db 0

	org $1080
F230	DB	"??X??B?B?B?D??D=?????F?F?F?G?FGBF?BF?KF?=?=::AA?A????????``__^XXX\\ZYXX3ZX1XX.X1X3\\ZYXX3ZXXXX.X1X3\\ZYXX/ZX1XX.X1X3\\ZYXX3ZXXX3a1a.a?ZYXB3Z?1?D.?1=3?'YXF3Z?X?G.F1B3?*FYK/?=1=:.A1?3X'YXX3ZXXa3a1a.a?'YXB3Z?1?D.?1=3?'YXF3Z?X?G.F1B3?*FYK/?=1=:.A1?3X'YXX3ZXXa3a1a.a*XKYK3KN1NXNM1M3X'KYK3KNXNM.K1X3XXGYG/GXGIXIX1IXI'KYK3KXIKXKXaXaX'KYK3KN1NXNM1M3X'KYK3KNXNM.K1X3X*GYG/GXGIXIX1I3I'KYK3KXIK3KXaXab"
	DB 0

endprog	equ $

	output_bin "txt2bin.bin",0,endprog    ; 