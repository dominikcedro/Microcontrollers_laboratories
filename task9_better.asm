;
; micro_task9.asm
; Created: 12/2/2023 9:48:54 PM
; Author : Dominik
; edit -- 13.12.2023

; later change the layout of loops and turn it into subroutine

start: ldi r16, 0xff
		out ddrc, r16
		ldi r18, 0b11111111
		ldi r16, 0
		out ddrb, r16

check_button: in r16, pinb 
			com r16
			mov r17, r16 
			cp r17, r20
			breq message_correct

rotate: lsr r17 
		inc r21
			
check_carry: adc r19, r20
			cp r19, r20 
			breq rotate

check_incorrect: cp r17, r20 
				brne message_incorrect


message_correct: com r21
				out portc, r21 
				mov r21, r20
				mov r19, r20 
				jmp check_button

message_incorrect: ldi r16, 0b01111111 
					out portc, r16
					mov r21, r20
					mov r19, r20
					jmp check_button
			
