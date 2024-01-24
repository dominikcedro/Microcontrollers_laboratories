;
; Task12.asm
;
; Created: 1/24/2024 9:57:02 AM
; Author : Domin
; Bubble sort algorythm




;define
.equ stack_bottom = 500
.equ arr_point = 0x0100

.cseg
.org 0
jmp start

.org 0x100
array: .db 3, 2, 1, 0xff

start:
		;define stack pointer
		ldi r26, low(stack_bottom)
		out SPL, r26
		ldi r26, high(stack_bottom)
		out SPH, r26

		;program memory array pointer
		ldi r30,low(array * 2) ;begg add_low program memory
		ldi r31,high(array * 2) ;begg add_low program memory

		call create_array

		;
bubble_start:
		ldi xl, low(arr_point)
		ldi xh, high(arr_point) ; lacks termination check
bubble_loop:
		cp r18, r19
		breq bubble_end
		ld r16, x+
		ld r17, x
		cpi r17,0xff
		breq finish_bubble_cycle
		cpi r16, 0xff
		breq finish_bubble_cycle
		cp r17, r16
		brlo swap_values
		inc r18 ; count the lenght, if no swaps are made, then finish subroutine
		jmp bubble_loop

swap_values:
		  dec xl
		  st x+, r17
		  st x, r16
		  jmp bubble_loop

finish_bubble_cycle:
		jmp bubble_start
bubble_end:
		jmp pc


.org 200

create_array: ; creates array by moving array values from program memory to data memory
			  ; ends execution when encountered 0xff value in the array
			  ; this value is also loaded to data memory as a last element
			  ldi xl, low(arr_point)
		      ldi xh, high(arr_point)
add_from_array:
				inc r19
				lpm r16, z+
				st x+, r16
				cpi r16, 0xff
				breq end_of_array
				jmp add_from_array
end_of_array:
ret

			
