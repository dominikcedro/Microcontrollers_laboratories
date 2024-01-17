;
;
; Dominik Cedro
; Task 11
; 10.01.2024

.set press = 96 ; pressure to be stored here
.cseg
.org 0
jmp start

start:
		ldi r16, press
		.set floor = 96
		.set ceeil = 185
		.set dodajnik = 10
		ldi r18, 0xff
		out ddrc, r18
		

cmp_floor: cpi r16, floor
			  brlo mess_under; tutaj insert message border low

cmp_ceil: ldi r17, ceeil
		  cp r17,r16
		  brlo mess_above; if r17 is lower than r16, r16 must be higher than ceeil border show message border high

cmp_ceil1: .set ceeil = 106
		  cpi r16, ceeil
		  brlo mess1 ; if r16 is higher than 96 and lower than 106 than it must be in the first range
cmp_ceil2:
		  .set ceeil = 116
		  cpi r16, ceeil
		  brlo mess2; if r16 is higher than 96 and lower than 116 than it must be in the 2 range
cmp_ceil4:
		  .set ceeil = 126
		  cpi r16, ceeil
		  brlo mess3; if r16 is higher than 96 and lower than 126 than it must be in the 3 range
cmp_ceil5:
		  .set ceeil = 126
		  cpi r16, ceeil
		  brlo mess4; if r16 is higher than 96 and lower than 106 than it must be in the 4 range
cmp_ceil6:
		  .set ceeil = 136
		  cpi r16, ceeil
		  brlo mess5; if r16 is higher than 96 and lower than 106 than it must be in the 5 range
cmp_ceil7:
		  .set ceeil = 146
		  cpi r16, ceeil
		  brlo mess6; if r16 is higher than 96 and lower than 106 than it must be in the 6 range
cmp_ceil8:
		  .set ceeil = 166
		  cpi r16, ceeil
		  brlo mess7; if r16 is higher than 96 and lower than 106 than it must be in the 7 range

; messages 

mess_under: ldi r20, 0b01111111 ;light higher nibble
			
			out portc, r20
			jmp start
mess1:	ldi r20, 0b00111111 ;
			
			out portc, r20
			jmp start
mess2:	ldi r20, 0b10011111 ;
			
			out portc, r20
			jmp start
mess3:ldi r20, 0b11001111 ;
			
			out portc, r20
			jmp start
mess4:	ldi r20, 0b11100111 ;
			out portc, r20
			nop
			jmp start
mess5:	ldi r20, 0b11110011 ;light higher nibble
			
			out portc, r20
			jmp start
mess6:ldi r20, 0b11111001 ;light higher nibble
			
			out portc, r20
			jmp start
mess7:ldi r20, 0b11111100 ;light higher nibble
			
			out portc, r20
			jmp start
mess_above: ldi r20, 0b11111110 ; light lower nibble
			
			out portc, r20
			jmp start
