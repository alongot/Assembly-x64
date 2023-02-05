bits 64
%include "./functions64.inc"

global selectsort       ; Makes it available to access

section .text

;Sudo c++ code
; n = length(A)
; for i = 0 to n - 1
;	minIndex = i
;	for j = i + 1 to n - 1
;	if A[j] < A[minIndex]
;		minIndex = j
;		swap A[i] and A[minIndex]
selectsort:
    push    rbx
    push    rcx
    push	rsi
    push 	rdi
    
    cmp     rsi, 0          	 	; Check if the size of the array is 0 or negative
    jle     exit              		; If rsi <= 0 then jump to exit
    mov     r13, 0            		; Initialize swap counter to 0
    mov	    r10, 0            		; i = 0
    
  ;Loop to replicate a basic for loop from i = 0   
  first_loop:                       ; 
    cmp     r10, rsi                ;Compare the length
    jnb     exit                	;If length is bigger end program
    mov     r12, [rdi + (r10 * 8)]  ;Move the element
    mov     rbx, r10                ;Make the element = i
    mov     r11, r10                ;Make j equal i
  
  ;Loop to replicate a basic for loop from j = 0   
  second_loop:                      ; 
    inc     r11                     ; Inc j
    cmp     r11, rsi                ; Compare the length     
    jnb     swaps			        ; Jump to swaps
    cmp     r12, [rdi + (r11 * 8)]  ; Move the element
    jng     second_loop             ; If it is less than than element go to the next element
    mov     r12, [rdi + (r11 * 8)]  ; Element equal to j
    mov     rbx, r11                ; I equal to J
    loop    second_loop
  
  ;Loop to swap elements
  swaps:                   
    mov     rcx, [rdi + (r10 * 8)]  ; Use rcx to store variable
    cmp     rcx, r12                ; Compare value in the list
    je      skip_swap               ; If they are similar then lets skip the swap
    mov     [rdi + (rbx * 8)], rcx  ; Put value into rcx
    mov     [rdi + (r10 * 8)], r12  ; Value at i equal to minmmum value 
    inc     r13                     ; Increment swap counter
  skip_swap:
    inc     r10                     ; i++
    loop    first_loop				;
    
  exit:
    mov     rax, 0                  ; Return 0 in rax if the size of the array is 0 or negative
    jmp     end
  end:
	mov     rax, r13                ; Return the number of swaps in rax
    pop     rcx
    pop		rsi
    pop 	rdi
    pop     rbx
    ret
