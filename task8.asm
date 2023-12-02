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

buttons_push:  in r16, pinb
				mov r17, r16

check_none: ldi r17, 0x00 ; check if r17 is equal to 0x00
			cp r16, r17
			mov r17, r16
			breq group0

check_A: andi r17, maskA ;here if when i apply mask A the sequence is equal to previous itself
		cp r17, r16
		mov r17, r16
		breq groupA

check_B: andi r17, maskB ;here i check when I apply maskB the sequence stays same
		cp r17, r16
		mov r17, r16
		breq groupB

check_both: jmp group12 ; if none of previous conditions were met, I know that both groups are engaged


groupA:  ldi r16, message1 ; i use defined message here and below
		 out portc, r16
		 jmp buttons_push

groupB:   ldi r16, message2
		 out portc, r16
		 jmp buttons_push

group0: ldi r16, message0
		 out portc, r16
		 jmp buttons_push

group12:ldi r16, message12
		 out portc, r16
		 jmp buttons_push
