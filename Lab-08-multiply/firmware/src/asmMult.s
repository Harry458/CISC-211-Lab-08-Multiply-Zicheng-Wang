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
    
    LDR R2, =a_Multiplicand
    LDR R3, =b_Multiplier
    LDR R4, =rng_Error
    LDR R5, =a_Sign
    LDR R6, =b_Sign
    LDR R7, =prod_Is_Neg
    LDR R8, =a_Abs
    LDR R9, =b_Abs
    LDR R10, =init_Product
    LDR R11, =final_Product
    MOV R12, #0
    STR R12, [R2]
    STR R12, [R3]
    STR R12, [R4]
    STR R12, [R5]
    STR R12, [R6]
    STR R12, [R7]
    STR R12, [R8]
    STR R12, [R9]
    STR R12, [R10]
    STR R12, [R11]   
    
    STR R0, [R2]
    STR R1, [R3]
    
    AND R2, R0, #10000000
    CMP R2, #10000000
    BEQ negative_case
    positive_case:
	AND R2, R0, #7FFF0000
	CMP R2, #00000000
	BNE set_rng_error
	B out
    negative_case:
	AND R2, R0, #FFFF8000
	CMP R2, #FFFF8000
	BNE set_rng_error
    out:
    
    
    
    /*STEP 5-8 ?*/
    
    
    
    
    
    
    
    set_rng_error:
	STR R0,[R12]
	MOV R12, #1
	STR R4, [R12]
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
           




