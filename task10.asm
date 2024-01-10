;
; task7.asm
;
; Created: 12/2/2023 7:45:12 AM
; Author : Dominik Cedro
;this is a task prepared for microcontrollers laboratories

;idea is
; i have a number that has 3 digits
;i create three loops: 100s, 10s, 1s
; loop100: subtract from original number 100
;increment r17 which is 100s register
; check if it is smaller than 100
; if is not, loop again

; the same for the other two digits, then i will have binary form in registers r17 (100), r18(10), r19(1s)


.equ stack_bottom=0x500
.set number = 0xDF

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
	ldi r25, 0x69
	call test_routine
	jmp pc



			
	
	;after calling routine registers r17-r19 should change 

.org 0x200 ; subroutine adress

s_routine:
		ldi r16, number
		ldi r20, 0b01100100 ; 100 in binary
		ldi r21, 0b1010
		ldi r22,0b0001

loop100: sub r16, r20 ; 100 in binary
		inc r17
		cp r16, r20
		brsh loop100

loop10: sub r16,r21
		inc r18
		cp r16, r21
		brsh loop10

loop1: sub r16, r22
		inc r19
		cp r16,r22
		brsh loop1
ret


.org 300

test_routine: ; this s_routine check the original routine
			  ; if it's successful then r25 = 0x11
			  ;if it's not then r25 = 0xff
		.set number = 0xDF
		.set unities = 0x03
		.set tens = 0x02
		.set hundreds = 0x02
		cpi r17, hundreds
		brne failure

check_tens:
		cpi r18, tens
		brne failure

check_unities:
		cpi r19, unities
		brne failure

success:
		ldi r25,0x11

failure:
		ldi r25, 0xff

ret


		; now i will have numbers of 100s in r17, 10s in r18, 1s in r19
