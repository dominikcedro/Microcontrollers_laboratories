;
; task7.asm
;
; Created: 12/2/2023 7:45:12 AM
; Author : Dominik Cedro
;this is a task prepared for microcontrollers laboratories

.equ stack_bottom=0x500
.set number = 100

.cseg
.org 0
jmp start

.org 0x100 ; start program adress

start:	
	ldi r23,low(stack_bottom)
	out SPL,r23
	ldi r23,high(stack_bottom)
	out SPH,r23
	
	call s_routine
	
	call test_routine
	jmp pc	

.org 0x200 ; subroutine adress

s_routine: ; this routine recieves a number stored in hex/binary
		   ; and returns this number in BCD format in three regs
		   ; r17-hundreds, r18-tens, r19-unities
		ldi r16, number
		ldi r20, 0b01100100 ; 100 in binary
		ldi r21, 0b1010
		ldi r22,0b0001

loop100: cpi r16, 0
		breq end
		cp r16, r20
		brlo loop10
		sub r16, r20 ; 100 in binary
		inc r17
		cp r16, r20
		brsh loop100

loop10: cpi r16, 0
		breq end
		cp r16, r21
		brlo loop1
		sub r16,r21
		inc r18
		cp r16, r21
		brsh loop10

loop1: cpi r16, 0
		breq end
		sub r16, r22
		inc r19
		cp r16,r22
		brsh loop1

end:
ret


.org 300

test_routine: ; this s_routine check the original routine
			  ; if it's successful then r25 = 0x03
			  ;if it's not then r25 < 0x03
		.set number = 0xFF
		.set unities = 0x05
		.set tens = 0x05
		.set hundreds = 0x02

check_hundreds:
		cpi r17, hundreds
		brne failure
		inc r25

check_tens:
		cpi r18, tens
		brne failure
		inc r25

check_unities:
		cpi r19, unities
		brne failure
		inc r25

failure: 


ret
