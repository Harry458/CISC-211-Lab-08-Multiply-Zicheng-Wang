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
    
    LDR r2, =a_Multiplicand     /*Load the address of a_Multiplicand into r2*/  
LDR r3, =b_Multiplier       /*Load the address of b_Multiplier into r3*/  
LDR r4, =rng_Error          /*Load the address of rng_Error into r4*/  
LDR r5, =a_Sign             /*Load the address of a_Sign into r5*/  
LDR r6, =b_Sign             /*Load the address of b_Sign into r6*/  
MOV r7, 0                   /*Set r7 to 0*/  
STR r7, [r2]                /*Store the value of r7 at the address in r2 (a_Multiplicand)*/  
STR r7, [r3]                /*Store the value of r7 at the address in r3 (b_Multiplier)*/  
STR r7, [r4]                /*Store the value of r7 at the address in r4 (rng_Error)*/  
STR r7, [r5]                /*Store the value of r7 at the address in r5 (a_Sign)*/  
STR r7, [r6]                /*Store the value of r7 at the address in r6 (b_Sign)*/  

STR r0, [r2]                /*Store the value of r0 at the address in r2*/  
STR r1, [r3]                /*Store the value of r1 at the address in r3*/  

LDR r7, = -32768            /*Load the value -32768 into r7*/  
CMP r0, r7                  /*Compare r0 and r7*/  
BLT out_of_rang             /*Branch if less than (out of range)*/  
CMP r1, r7                  /* Compare r1 and r7*/ 
BLT out_of_rang             /*Branch if less than (out of range)*/  

LDR r7, = 32767             /* Load the value 32767 into r7*/ 
CMP r0, r7                  /*Compare r0 and r7*/  
BGT out_of_rang             /*Branch if greater than (out of range)*/  
CMP r1, r7                  /*Compare r1 and r7*/  
BGT out_of_rang             /*Branch if greater than (out of range)*/  

LSR r7, r0, 31              /* Logical shift right of r0, result in r7*/ 
LSR r8, r1, 31              /*Logical shift right of r1, result in r8*/  

LDR r9, =prod_Is_Neg        /* Load the address of prod_Is_Neg into r9*/ 
MOV r11, 0                  /*Set r11 to 0*/  
STR r11, [r9]               /*Store the value of r11 at the address in r9 (prod_Is_Neg)*/  

STR r7, [r5]                /*Store the value of r7 at the address in r5 (a_Sign)*/  
STR r8, [r6]                /*Store the value of r8 at the address in r6 (b_Sign)*/  
CMP r0, 0                   /*Compare r0 to 0*/  
BEQ skip_Line               /*Branch if equal to 0 (skip Line)*/  
CMP r1, 0                   /*Compare r1 to 0*/  
BEQ skip_Line               /* Branch if equal to 0 (skip Line)*/ 
TEQ r7, r8                  /*Test equivalence of r7 and r8*/  
BNE get_negative_answer     /*Branch if not equal (get negative answer)*/  
continue:

LDR r2, =a_Abs              /*Load the address of a_Abs into r2*/  
LDR r3, =b_Abs              /*Load the address of b_Abs into r3*/  

CMP r7, 1                   /* Compare r7 to 1*/ 
BEQ neg_abs_A               /*Branch if equal to 1 (negate a_Abs)*/  
STR r0, [r2]                /*Store the value of r0 at the address in r2 (a_Abs)*/  
MOV r2, r0                  /*Move the value of r0 to r2*/  
continue2:

CMP r8, 1                   /* Compare r8 to 1*/ 
BEQ neg_abs_B               /*Branch if equal to 1 (negate b_Abs)*/  
STR r1, [r3]                /*Store the value of r1 at the address in r3 (b_Abs)*/  
MOV r3, r1                  /*Move the value of r1 to r3*/  
continue3:

LDR r10, =init_Product      /*Load the address of init_Product into r10*/  
LDR r12, =final_Product     /*Load the address of final_Product into r12*/  
MOV r11, 0                  /*Set r11 to 0*/  
STR r11, [r10]              /*Store the value of r11 at the address in r10 (init_Product)*/  
STR r11, [r12]              /*Store the value of r11 at the address in r12 (final_Product)*/  
do:

CMP r3, 0                   /*Compare r3 to 0*/  
BEQ can_not_Multiplication  /*Branch if equal to 0 (cannot perform multiplication)*/  
TST r3, 1                   /*Test the least significant bit of r3*/  
BNE proudct_increase        /*Branch if the bit is clear (increase product)*/  
continue4:

LSR r3, r3, 1               /* Logical shift right of r3 by 1*/ 
LSL r2, r2, 1               /*Logical shift left of r2 by 1*/  
B do                        /* Branch back to the beginning of the loop*/ 

skip_Line:
B continue                   /* Branch to continue*/ 

get_negative_answer:

MOV r11, 1                  /* Set r11 to 1*/ 
STR r11, [r9]               /*Store the value of r11 at the address in r9 (prod_Is_Neg)*/  
B continue                   /*Branch to continue*/  

out_of_rang:

MOV r7, 1                   /*Set r7 to 1*/  
STR r7, [r4]                /*Store the value of r7 at the address in r4 (rng_Error)*/  
MOV r0, 0                   /*Set r0 to 0*/  

neg_abs_A:

SUB r0, r0, 1               /*Subtract 1 from r0*/  
MVN r7, r0                  /*Bitwise NOT of r0, result in r7*/  
STR r7, [r2]                /*Store the value of r7 at the address in r2 (a_Abs)*/  
MOV r2, r7                  /*Move the value of r7 to r2*/  
B continue2                 /*Branch to continue2*/  

neg_abs_B:

SUB r1, r1, 1               /*Subtract 1 from r1*/  
MVN r8, r1                  /*Bitwise NOT of r1, result in r8*/  
STR r8, [r3]                /*Store the value of r8 at the address in r3 (b_Abs)*/ 
MOV r3, r8                  /*Move the value of r8 to r3*/  
B continue3                 /*Branch to continue3*/  


    proudct_increase:
	ADD r11, r11, r2       /*Add r2 to r11 (product accumulation)*/ 
	STR r11, [r10]         /*Store the value of r11 at the address in r10 (init_Product)*/  
	B continue4             /*Branch to continue4*/  

    can_not_Multiplication:
	LDR r6, [r9]           /* Load the value from the address in r9 (prod_Is_Neg) into r6*/ 
	CMP r6, 1               /*Compare r6 to 1*/  
	BEQ change_To_negative  /*Branch if equal to 1 (change to negative)*/  
	B final_step             /*Branch to final_step*/  

    change_To_negative:

	LDR r11, [r10]          /*Load the value from the address in r10 (init_Product) into r11*/  
	MVN r11, r11            /*Bitwise NOT of r11 (change to negative)*/  
	ADD r11, r11, 1         /*Add 1 to r11*/  


    final_step:
    	STR r11, [r12]          /*Store the value of r11 at the address in r12 (final_Product)*/  
	MOV r0, r11              /*Move the value of r11 to r0*/  
	B done                    /*Branch to done*/ 
	
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
           




