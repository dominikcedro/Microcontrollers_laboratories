;
; task7.asm
;
; Created: 12/2/2023 7:45:12 AM
; Author : Dominik Cedro
;this is a task prepared for microcontrollers laboratories

jmp start
.org 0x46

start: .equ mask_nibble = 0x0f
		.equ bit7 = 0b01111111
		.equ bit6 = 0b10111111
		.equ bit5 = 0b11011111
		.equ bit4 = 0b11101111
		.equ empty = 0xff
		.equ inccrt_msg = 0b10011001
		ldi r16, 0xff
	   out ddrc, r16 ; ddrc is set to one, so pin c becomes OUTPUT
	   ldi r18, 0xff
	   ldi r16, 0x00
	   out ddrb, r16 ; ddrb is set to 0 so pin B becomes input

loop: in r16, pinb ; read a sequence representing pins
	 mov r17, r16
	 ori r17, mask_nibble
	 cpi r17, bit7
	 breq message_bit7
	 cpi r17, bit6
	 breq message_bit6
	 cpi r17,bit5
	 breq message_bit5
	 cpi r17, bit4
	 breq message_bit4
	 cpi r17, empty
	 breq message_empty


incorrect_msg: ldi r17,inccrt_msg
				out portc,r17
				jmp loop

message_empty: ldi r17, 0x7f
				out portc, r17
				jmp loop

message_bit7:ldi r17, mask_bit7
			 out portc, r17
			 jmp loop
message_bit6:ldi r17, mask_bit6
			 out portc, r17
			 jmp loop
message_bit5:ldi r17, mask_bit5
			 out portc, r17
			 jmp loop
message_bit4:ldi r17, mask_bit4
			 out portc, r17
			 jmp loop
