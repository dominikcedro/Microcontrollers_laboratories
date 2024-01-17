;
;
; Dominik Cedro
; Task 11
; 10.01.2024

.set press = 96 ; pressure to be stored here
.equ stack_b = 0x500
.cseg
.org 0
jmp start


.org 0x100
array_press: .db     0x6A, 0, 0xAF, 0, 0xC0, 0, 0x7F0, 0, 0xB2, 0, 0xA4, 0, 0x9D, 0, 0xBE, 0

start:	
		ldi r16, high(stack_b)
		out SPH, r16
		ldi r16, low(stack_b)
		out SPL, r16
		ldi r30,low(array_press * 2) ;begg add_low program memory
		ldi r31,high(array_press*2) ;begg add_low program memory
call check_button
; now r17 is the number in binary
multiply_bin: lsl r17

loop_find_element: dec r17
					dec r17
					lpm r16, z+
				   
				   cpi r17, 0
				   brne loop_find_element
ldi r16, press		
call check_show
jmp pc

.org 0x200
check_button:; this subroutine check which button is clicked and returns
			 ; either r16- answer (binary num of this button)
			 ; or error message 0xff
			 ;
			 ;ARGS: button push on PINB
			 ;RETURNS: r17-binary num of button
			ldi r18,0x00
			out ddrb, r18
			in r17, pinb 
			com r17
ret


.org 0x300

check_show:; this subroutine checks the value of r16
			; it has prepared ceeilings and floor (borders)
			; apropriate value is shown in LEDs on portC
			;ARGS: r16 - value of pressure
			;RETURNS: message on PORTC
			.set floor = 96
			.set ceeil = 185
			ldi r18, 0xff
			out ddrc, r18
					

cmp_floor: cpi r16, floor
		   brlo mess_under; tutaj insert message border low

cmp_ceil: ldi r17, ceeil
		  cp r17,r16
		  brlo mess_above; if r17 is lower than r16, r16 must be higher than ceeil border show message border high

cmp_ceil1: .set ceeil = 106
		  cpi r16, ceeil
		  brlo mess1 ; if r16 is higher than 96 and lower than 106 than it must be in the first range
cmp_ceil2:
		  .set ceeil = 116
		  cpi r16, ceeil
		  brlo mess2; if r16 is higher than 96 and lower than 116 than it must be in the 2 range
cmp_ceil4:
		  .set ceeil = 126
		  cpi r16, ceeil
		  brlo mess3; if r16 is higher than 96 and lower than 126 than it must be in the 3 range
cmp_ceil5:
		  .set ceeil = 126
		  cpi r16, ceeil
		  brlo mess4; if r16 is higher than 96 and lower than 106 than it must be in the 4 range
cmp_ceil6:
		  .set ceeil = 136
		  cpi r16, ceeil
		  brlo mess5; if r16 is higher than 96 and lower than 106 than it must be in the 5 range
cmp_ceil7:
		  .set ceeil = 146
		  cpi r16, ceeil
		  brlo mess6; if r16 is higher than 96 and lower than 106 than it must be in the 6 range
cmp_ceil8:
		  .set ceeil = 166
		  cpi r16, ceeil
		  brlo mess7; if r16 is higher than 96 and lower than 106 than it must be in the 7 range

; messages 

mess_under: ldi r20, 0b01111111 ;message when under the range
			out portc, r20
			jmp finish

mess1:	ldi r20, 0b00111111 ;
			out portc, r20
			jmp finish

mess2:	ldi r20, 0b10011111 ;
			out portc, r20
			jmp finish

mess3:ldi r20, 0b11001111 ;
			out portc, r20
			jmp finish

mess4:	ldi r20, 0b11100111 ;
			out portc, r20
			jmp finish

mess5:	ldi r20, 0b11110011 ;
			out portc, r20
			jmp finish

mess6:ldi r20, 0b11111001 ;
			out portc, r20
			jmp finish

mess7:ldi r20, 0b11111100 ;
			out portc, r20
			jmp finish

mess_above: ldi r20, 0b11111110 ; message when over the range
			out portc, r20
			jmp finish

finish:
ret
