;
; task7.asm
;
; Created: 12/2/2023 7:45:12 AM
; Author : Dominik Cedro
;this is a task prepared for microcontrollers laboratories

jmp start
.org 0x46

start: ldi r16, 0xff
	   out ddrc, r16 ; ddrc is set to one, so pin c becomes OUTPUT
	   ldi r18, 0xff
	   ldi r16, 0
	   out ddrb, r16 ; ddrb is set to 0 so pin B becomes input

loop: in r16, pinb ; read a sequence representing pins
	  rol r16
	  out portc, r16
	  jmp loop

theend: jmp pc
