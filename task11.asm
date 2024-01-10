;
;
; Dominik Cedro
; Task 11
; 10.01.2024

;ranges:
; >96
;96><105 
;106><115
;116><125
;126><135
;136><145
;146><165
;166><185
;185>

.set press = 95 ; pressure to be stored here
.cseg
.org 0
jmp start

start:
		ldi r16, press
		.set floor = 96
		.set ceeil = 185
		.set dodajnik = 10
		out ddrc, r16
		ldi r18, 0b11111111

cmp_floor: cpi r16, floor
			  brlo ; tutaj insert message border low

cmp_ceil: ldi r17, ceil
		  cp r17,r16
		  brlo ; if r17 is lower than r16, r16 must be higher than ceeil border show message border high

cmp_ceil1: .set ceeil = 106
		  cpi r16, ceeil
		  brlo ; if r16 is higher than 96 and lower than 106 than it must be in the first range
cmp_ceil2:
		  .set ceeil = 116
		  cpi r16, ceeil
		  brlo ; if r16 is higher than 96 and lower than 106 than it must be in the 2 range
cmp_ceil3:
		  .set ceeil = 126
		  cpi r16, ceeil
		  brlo ; if r16 is higher than 96 and lower than 106 than it must be in the 3 range
cmp_ceil3:
		  .set ceeil = 126
		  cpi r16, ceeil
		  brlo ; if r16 is higher than 96 and lower than 106 than it must be in the 4 range
cmp_ceil4:
		  .set ceeil = 136
		  cpi r16, ceeil
		  brlo ; if r16 is higher than 96 and lower than 106 than it must be in the 5 range
cmp_ceil3:
		  .set ceeil = 146
		  cpi r16, ceeil
		  brlo ; if r16 is higher than 96 and lower than 106 than it must be in the 6 range
cmp_ceil3:
		  .set ceeil = 166
		  cpi r16, ceeil
		  brlo ; if r16 is higher than 96 and lower than 106 than it must be in the 7 range

; messages 

mess1: out portc, message_border

mess2:
mess3:
mess4:
mess5:
mess6:
mess7:
mess8:
mess9:



