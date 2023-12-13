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





jmp start
.org 0x46

start: .equ number = 0b1111011
		ldi r16, number
		ldi r20, 0b01100100

loop100: subi r16, 0b01100100 ; 100 in binary
		inc r17
		cp r20, r16
		brlo loop100
