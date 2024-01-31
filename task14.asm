;task 14

;
;
; Dominik Cedro
; Task 11
; 10.01.2024


.equ stack_b = 0x500
.cseg
.org 0
jmp start


.org 0x100


start:	
		ldi r16, high(stack_b)
		out SPH, r16
		ldi r16, low(stack_b)
		out SPL, r16
		nop
		;1 micro second
		


call verify_button_click

jmp start

verify_button_click:   
			 ldi r17, 0
			 out DDRB, r17
			 ldi r17, 0xff
			 out DDRC, r17

get_button: 
	in r17, pinb

Delay_1sec:                 
    LDI     r19,   1       
Delay1:
    LDI     r20,   210     
Delay2:
    LDI     r21,   250     
Delay3:
    DEC     r21            
    NOP                    
    BRNE    Delay3          

    DEC     r20           
    BRNE    Delay2          

    DEC     r19            
    BRNE    Delay1
	
check: in r18, pinb
	   cp r17, r18
	   brne get_button  
	   inc r22        
RET




