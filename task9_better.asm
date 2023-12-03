;
; micro_task9_start.asm
;
; Created: 12/2/2023 9:48:54 PM
; Author : Domin
;


; Replace with your application code
; there is 8 buttons in port B
;
; microcontrolllers_task8_rightone.asm
;
; Created: 12/2/2023 9:08:14 AM
; Author : Dominik Cedro
;

;Prerequisites
; groups - groupA = 0b11110000 ; groupB = 0b00001111
; if group one then message = 0b11110000
; if group two, then message = 0b00001111
; if both groups, then message = 0b11111111
;if neither group, then message = 0b10000000

.equ maskA = 0xf0
.equ maskB = 0x0f

.equ message1 = 0xf0
.equ message2 = 0x0f
.equ message12 = 0xff
.equ message0 = 0x80 ; 0b10000000

start: ldi r16, 0xff
		out ddrc, r16
		ldi r18, 0b11111111
		ldi r16, 0
		out ddrb, r16
		ldi r20, 0 ;storing zero
		ldi r19, 0 ; counter
		ldi r22, 0x01 ; stroing one

;how to check which button is pressed?
check_button: in r16, pinb ; insert pinb input (buttons)
			mov r17, r16 ; this is work register, so r16 is not changed
			cp r17, r20
			breq message_correct

rotate: ror r17 ; roatte, each rotate i add one to counter
		inc r21
			
check_carry: adc r19, r20
			cp r19, r20 ; i check if carry is still zero here i could check if something also is clicked
			breq rotate

check_incorrect: cp r17, r20 ; basically if carry is set the r17 should be zero, if it's not then view message_incorrect
				brne message_incorrect


message_correct: out portc, r21 ; if its not zero, it's a good message
				mov r21, r20
				mov r19, r20 ; i zero these values
				jmp check_button

message_incorrect: ldi r16, 0x80 ; this has to be done
					out portc, r16
					mov r21, r20
					mov r19, r20
					jmp check_button
			
;right shift through carry
;then check wheter carry is set
;counter will count which number to choose
;dont forget it!!!