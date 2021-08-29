# myZ80
Code for my Z80 board


<pre>
to output binary data:

define ORG label at the beginning of file. Usually ORG 0

        ORG 0
beginprog equ $

 put this at the end of your asm file

endprog equ $

        output_bin "myz80_6845init.bin",beginprog,endprog-beginprog    ; The binary file
or
        output_bin "myz80_6845init.bin",$0000,endprog    ; The binary file

then execute
zcl <filename>

this is mentioned in zeus_ex_files.asm example file
</pre>
