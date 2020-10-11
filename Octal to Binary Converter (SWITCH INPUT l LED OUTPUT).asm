START:	;|clears all the registers
	MOV R0, #00H 		;|load 00h to r0
	MOV R1, #00H		;|load 00h to r1
	MOV R2, #00H		;|load 00h to r2
	MOV R3, #00H		;|load 00h to r3
	MOV R4, #00H		;|load 00h to r4
	MOV R5, #00H		;|load 00h to r5
	MOV R6, #00H		;|load 00h to r6
	MOV R7, #00H		;|load 00h to r7

DELAY:	;|apply delay for input time
	MOV R0, #20H
	DJNZ R0, $

SCANSWITCHES:	;|scans each switch for a value of zero(pressed switch), if found moves to its corresponding function
	JNB P2.0, ZERO	 	;|if sw0 is found to be pressed, move to ZERO
	JNB P2.1, ONE		;|if sw1 is found to be pressed, move to ONE
	JNB P2.2, TWO 		;|if sw2 is found to be pressed, move to TWO
	JNB P2.3, THREE 	;|if sw3 is found to be pressed, move to THREE
	JNB P2.4, FOUR 		;|if sw4 is found to be pressed, move to FOUR
	JNB P2.5, FIVE 		;|if sw5 is found to be pressed, move to FIVE
	JNB P2.6, SIX 		;|if sw6 is found to be pressed, move to SIX
	JNB P2.7, SEVEN 	;|if sw7 is found to be pressed, move to SEVEN
	CALL START			;|if none of the switches are pressed, loop to START

;|each general-purpose register is used as a representation of an octal number.
ZERO:MOV R0, #01	;|if sw0 is pressed, move 1 to R0 (representing input D0)
CALL OCT2BIN 		;|jump to OCT2BIN

ONE:MOV R1, #01 	;|if sw1 is pressed, move 1 to R1 (representing input D1)
CALL OCT2BIN 		;|jump to OCT2BIN

TWO:MOV R2, #01 	;|if sw2 is pressed, move 1 to R2 (representing input D2)
CALL OCT2BIN 		;|jump to OCT2BIN

THREE:MOV R3, #01 	;|if sw3 is pressed, move 1 to R3 (representing input D3)
CALL OCT2BIN 		;|jump to OCT2BIN

FOUR:MOV R4, #01 	;|if sw4 is pressed, move 1 to R4 (representing input D4)
CALL OCT2BIN 		;|jump to OCT2BIN

FIVE:MOV R5, #01 	;|if sw5 is pressed, move 1 to R5 (representing input D5)
CALL OCT2BIN 		;|jump to OCT2BIN

SIX:MOV R6, #01 	;|if sw6 is pressed, move 1 to R6 (representing input D6)
CALL OCT2BIN 		;|jump to OCT2BIN

SEVEN:MOV R7, #01 ;|if sw7 is pressed, move 1 to R7 (representing input D7)
CALL OCT2BIN 		;|jump to OCT2BIN


OCT2BIN:
;|this is a representation of the first OR gate, creating bit1
	MOV A, R1	 		;|loads the content of r1 to A
	ORL A, R3			;|operates the logical OR on A and r3
	ORL A, R5			;|operates the logical OR on A and r5
	ORL A, R7			;|operates the logical OR on A and r7
	MOV P1, A			;|loads the content of A to B (used as a temporary storage)

;|this is a representation of the second OR gate creating bit 2
	MOV A, R2			;|loads the content of r2 to A
	ORL A, R3			;|operates the logical OR on A and r3
	ORL A, R6			;|operates the logical OR on A and r6
	ORL A, R7			;|operates the logical OR on A and r7
	MOV B, #02			;|loads decimal 2 to B
	MUL AB				;|multiplies A to B to make it into bit 2
	MOV B, P1			;|load P1 to B
	ADD A, B			;|adds the contents of A and B
	MOV P1, A			;|loads the content of A to the LED (used as a temporary storage)

;|this is a repesentation of the third OR gate, creating bit 3
	MOV A, R4			;|loads the content of r4 to A
	ORL A, R5			;|operates the logical OR on A and r5
	ORL A, R6			;|operates the logical OR on A and r6
	ORL A, R7			;|operates the logical OR on A and r7
	MOV B, #04			;|loads decimal 2 to B
	MUL AB				;|multiplies A to B to make it into bit 2
	MOV B, P1			;|load P1 to B
	ADD A, B			;|adds the contents of A and B
	MOV P1, A			;|loads the content of A to the LED (used as a temporary storage)

	CPL A				;|complements the content of A, since the LED port complements the input it receives
	MOV P1, A			;|loads the A to the LED port
	CALL START			;|loop back to START
