;
; Microcontrollers_29_11_task5.asm
;
; Created: 11/29/2023 9:56:25 AM
; Author : Dominik Cedro

; my array = [0b00001101, 0b00001110, 0b00001111, 0b00001100, 0xff]
;0b00001101, 	D turn to 0b00001101 D
;0b00001110,	E turn to 0b11111101 Fe
;0b00001111,	F turn to 0b11111111 FF
;0b10101100, 	AC turn to 0b00001100 C
;0B11111111,	FF end				FF
.cseg
.org 0

rjmp start
.org 0x100

array: .db 0b00001101, 0b00001110, 0b00001111, 0b10101100, 0b11111111

start:
	ldi r30,low(array * 2) ;begg add_low program memory
	ldi r31,high(array*2) ;begg add_low program memory
	ldi r26, 0x00 ;begg add_low data memory
	ldi r27, 0x01 ;beg add_high data memory 
	ldi r28, 0x16
	ldi r29, 0x01
	jmp check_termination

check_ff: cpi r18,0xff ; check for termination statement
		breq check_termination
		st x+, r18
		st y+, r17

check_termination: lpm r17, z+
				   cpi r17,0xff ; check for termination statement
				   breq theend
	               
check_no_0b01: mov r18, r17 ; general - check wheter the last two bits are not 0b01, if yes, do nothing go back
				andi r18, 0b00000011
				cpi r18, 0b00000001
				mov r18,r17
				breq check_ff

check_no_0b10: mov r18, r17 ; general - check wheter the last two bits are not 0b10, if yes, compliment high nibble
				andi r18, 0b00000011
				cpi r18, 0b00000010
				brne check_no_0b11 ; done

compliment_nibble:	mov r18, r17 
					ldi r16, 0b11110000
					eor r18, r16
					jmp check_ff ; done
				

check_no_0b11: mov r18, r17 ; general - check wheter the last two bits are not 0b11, if yes, set high nibble to 1s
				andi r18, 0b00000011
				cpi r18, 0b00000011	
				brne check_no_0b00

set1_nibble: mov r18, r17
			ori r18, 0b11110000
			jmp check_ff 

check_no_0b00: mov r18, r17; general - check wheter the last two bits are not 0b11, if yes, set high nibble to 0s			
				andi r18, 0b00000011
				cpi r18, 0b00000000
				brne check_ff

set0_nibble: mov r18, r17
			andi r18, 0b00001111
			jmp check_ff

theend: ldi r19, 0xff
		st x+, r19
		jmp pc



			
			
