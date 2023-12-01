;
; Microcontrollers_29_11_task5.asm
;
; Created: 11/29/2023 9:56:25 AM
; Author : Dominik Cedro

;this is solution to task 5 from list of tasks



  
; my array = [0b00001101, 0b00001110, 0b00001111, 0b00001100, 0xff]
;0b00001101, 	D
;0b00001110,	E
;0b00001111,	F
;0b00001100, 	C
;0B11111111,	FF
.cseg
.org 0

rjmp start
.org 0x100

array: .db 0b00001101, 0b00001110, 0b00001111, 0b00001100, 0b11111111

start:
	ldi r30,low(array * 2) ;begg add_low program memory
	ldi r31,high(array*2) ;begg add_low program memory
	ldi r26, 0x08 ;begg add_low data memory
	ldi r27, 0x01 ;beg add_high data memory 

check_termination: lpm r17, z+
				   cpi r17,0xff ; check for termination statement
				   breq theend
	               
check_no_0b01: mov r18, r17 ; general - check wheter the last two bits are not 0b01, if yes, do nothing go back
				andi r18, 0b00000011
				cpi r18, 0b00000001
				breq check_termination 

check_no_0b10: mov r18, r17 ; general - check wheter the last two bits are not 0b10, if yes, compliment high nibble
				andi r18, 0b00000011
				cpi r18, 0b00000010
				brne check_no_0b11 ; done

compliment_nibble:	mov r18, r17 
					ldi r16, 0b11110000
					eor r18, r16
					jmp check_termination ; done
				

check_no_0b11: mov r18, r17 ; general - check wheter the last two bits are not 0b11, if yes, set high nibble to 1s
				andi r18, 0b00000011
				cpi r18, 0b00000011	
				brne check_no_0b00

set1_nibble: mov r18, r17
			ori r18, 0b11110000 

check_no_0b00: ;something			

theend: jmp pc



			
			
