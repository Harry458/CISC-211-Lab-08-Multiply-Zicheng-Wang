/*** asmMult.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global a_Multiplicand,b_Multiplier,rng_Error,a_Sign,b_Sign,prod_Is_Neg,a_Abs,b_Abs,init_Product,final_Product
.type a_Multiplicand,%gnu_unique_object
.type b_Multiplier,%gnu_unique_object
.type rng_Error,%gnu_unique_object
.type a_Sign,%gnu_unique_object
.type b_Sign,%gnu_unique_object
.type prod_Is_Neg,%gnu_unique_object
.type a_Abs,%gnu_unique_object
.type b_Abs,%gnu_unique_object
.type init_Product,%gnu_unique_object
.type final_Product,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmMult gets called, you must set
 * them to 0 at the start of your code!
 */
a_Multiplicand:  .word     0  
b_Multiplier:    .word     0  
rng_Error:       .word     0  
a_Sign:          .word     0  
b_Sign:          .word     0 
prod_Is_Neg:     .word     0  
a_Abs:           .word     0  
b_Abs:           .word     0 
init_Product:    .word     0
final_Product:   .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmMult
function description:
     output = asmMult ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmMult
.type asmMult,%function
asmMult:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmMult.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 8 Multiply
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    
    LDR r2, =a_Multiplicand
    LDR r3, =b_Multiplier
    LDR r4, =rng_Error
    LDR r5, =a_Sign
    LDR r6, =b_Sign
    MOV r7, 0
    STR r7,[r2]
    STR r7,[r3]
    STR r7,[r4]
    STR r7,[r5]
    STR r7,[r6]
    
    STR r0, [R2]
    STR r1, [R3]
    
    LDR r7, = -32768
    CMP r0,r7
    BLT out_of_rang
    CMP r1,r7
    BLT out_of_rang
    
    LDR r7, = 32767
    CMP r0,r7
    BGT out_of_rang
    CMP r1,r7
    BGT out_of_rang
    
    LSR r7,r0, 31
    LSR r8,r1, 31
    
    LDR r9, =prod_Is_Neg
    MOV r11, 0
    STR r11,[r9]
    
    STR r7,[r5]
    STR r8,[r6]
    CMP r0,0
    BEQ skip_Line
    CMP r1,0
    BEQ skip_Line
    TEQ r7,r8 
    BNE get_negative_answer
    continue:
 
    LDR r2, =a_Abs
    LDR r3, =b_Abs

    CMP r7,1
    BEQ neg_abs_A
    STR r0,[r2]
    MOV r2,r0
    continue2:
    CMP r8,1
    BEQ neg_abs_B
    STR r1,[r3]
    MOV r3,r1
    continue3:
    LDR r10 , =init_Product
    LDR r12 , =final_Product
    MOV r11, 0
    STR r11,[r10]
    STR r11,[r12]
    do:
	CMP r3,0
	BEQ can_not_Multiplication
	TST r3,0 
	BEQ proudct_increase
	continue4:
	LSR r3,r3,1
	LSL r2,r2,1	
	B do
	
    skip_Line:
	B continue
    get_negative_answer:
	
	MOV r11, 1
	STR r11,[r9]
	B continue
    
    out_of_rang:
	MOV r7,1
	STR r7,[r4]
	MOV r0,0
	
    neg_abs_A:
	SUB r0,r0,1
	MVN r7,r0
	STR r7,[r2]
	MOV r2,r7
	B continue2
	
    neg_abs_B:
	SUB r1,r1,1
	MVN r8,r1
	STR r8,[r3]
	B continue3
    
    proudct_increase:
	ADD r11,r11,r2
	STR r11,[r10]
	B continue4
	
    can_not_Multiplication:
	LDR r11,[r9]
	CMP r11,1
	BEQ change_To_negative
	B final_step
	
    change_To_negative:
    
	LDR r11,[r10]
	MVN r11,r11
	ADD r11,r11,1
	STR r11,[r12]
    final_step:
	MOV r0,r11
	B done
	
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmMult return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




