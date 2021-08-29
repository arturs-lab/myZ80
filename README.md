# myZ80
Code for my Z80 board


to output binary data put this at the end of your asm file<br>
endprog	equ $<br>
	output_bin "myz80_6845init.bin",$0000,endprog    ; The binary file<br>
this is mentioned in zeus_ex_files.asm example file<br>
