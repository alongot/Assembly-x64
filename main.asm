; This program tests the selection sort function in the functions64.inc library
; and prints the number of swaps and the sorted array.

%include "./functions64.inc"
extern selectsort

SECTION .data
	openPrompt	db	"Welcome to my Program!", 0h
	closePrompt	db	"Program ending, have a nice day!", 0h
	msg1		db "The array was already sorted or the size was incorrect", 0h
	msg2 	    db "The total swaps done during the sort is: ", 0h
	msg3		db "Array after sorting: ", 0h
	msg4		db "Array before sorting: ", 0h
	arr1 		dq 	100h, 56h, 72h, 99h, 56h, 5h, 39h, 2h, 456h, 324h, 11h, 100h, 0h, -2h
					.LENGTHOF equ ($- arr1)/8
SECTION .bss

SECTION     .text
	global      _start
 
_start:
	; Print the opening prompt
    push	openPrompt
    call	PrintString
    call	Printendl
    
	; Set up the arguments for the selection sort function and call it
	mov rdi, arr1
	mov rsi, arr1.LENGTHOF   
	call selectsort
	
	; If the number of swaps is 0, print the error message and exit
	cmp rax, 0h
	je zero	
	
	; Print the sorted array
    mov r10, 0     ; Reset the loop counter
	push msg3
	call PrintString
	
print_loop2:
    ; Compare the loop counter and the array length
    cmp r10, rsi   
    ; If the loop counter is greater than or equal to the array length, jump to print_done2
    jge print_done2  
    
    ; Push the current element of the array onto the stack and print it as a hexadecimal value
    push qword [arr1 + r10*8]  
    call Print64bitNumDecimal   
    call PrintSpace
    
    ; Increment the loop counter and jump back to the beginning of the loop
    inc r10      
    loop print_loop2  

print_done2:
    ; Print a newline character
    call Printendl	
	
	; Print the number of swaps done during the sort
	push msg2
	call PrintString
	push rax
	call Print64bitSNumDecimal
	call Printendl
	
	; Jump to the exit label
	push	closePrompt
    call	PrintString
    call	Printendl
	jmp Exit
	


zero:
	; Print the error message if the number of swaps is 0
	push msg1
	call PrintString
	call Printendl
	
	; Jump to the exit label
	
	jmp Exit
	
    nop
; Set up the registers for exit and poke the kernel
Exit:
	mov		rax, 60					; 60 = system exit
	mov		rdi, 0					; 0 = return code
	syscall							; Poke the kernel
