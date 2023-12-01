;
; Microcontrollers_22_11_lab_4.asm
;
; Created: 11/22/2023 8:16:43 AM
; Author : Domin
;this is solution for task 4 from tasks list

 ; my array = [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0xff]
.cseg
.org 0

rjmp start
.org 0x100

array: .db 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0xff

start:
	ldi r30,low(array * 2)
	ldi r31,high(array*2)

	ldi r26, 0x08 ;begg add_low data memory
	ldi r27, 0x01 ;beg add_high data memory 

check: lpm r16, z+ ; bit of the arrayr to reg2
	   mov r17,r16
	   

	   cpi r17,0xff ; check for termination statement
	   breq theend


		asr r16 ; now carry is 1 if odd and 0 if even
		brcc check ; if odd load, if not loop again
		st x+ , r17

		jmp check
		


theend: st x , r16
	    jmp pc




			
			
