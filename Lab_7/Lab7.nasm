;  Name:  Ricky Smith
;  Title:  Lab 7
;  Date:  16 Oct 2018

bits 64

global first_func, second_func, third_func

first_func:
    push rbp
    mov rbp, rsp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Two values have been provided,
;  with the first stored in RDI,
;  and the second in RSI. If the 
;  first is greater than the second,
;  set RAX equal to 1, if the second
;  is greater than the first, set
;  RAX equal to -1. If they are
;  both equal, set RAX to 0.
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .compare:
        cmp rdi, rsi
        ;jg .above <- Not needed because the label .above will simply run after jl and je
        jl .below
        je .same

    .above:
        mov rax, 1
        jmp .finish
    
    .below:
        mov rax, -1
        jmp .finish

    .same:
        mov rax, 0

    .finish:

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    pop rbp
    ret

second_func:
    push rbp
    mov rbp, rsp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   You have been provided with
;  a pointer to the start of an
;  array of numbers in RDI, and
;  the number of elements in the
;  array in RSI. Loop through the
;  array, adding all the numbers
;  together, and store the result
;  in RAX.
;
;  HINT:
;  NASM increments arrays by bytes, not bits
;  - ints are generally 4 bytes in size
;
;  Two ways to increment pointer:
;  1: Add 4 to pointer directly
;  2: Use incrementer and work within reference directly ex. 
;     add reg, [regb + regc*4]
;  Feel free to look this up more!
;  
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov rcx, rsi
    xor rax, rax

    .continue:
        add ax, [rdi + rcx * 4]  ;xor rcx, rcx

    .continue:
        add ax, [rdi + rax]
        loop .continue
        ;add ax, [rdi]
        inc rax
        loop .continue
    add ax, [rdi]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    pop rbp
    ret

third_func:
    push rbp
    mov rbp, rsp
    xor rax, rax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Find the length of the
;  provided, NULL-terminated 
;  string (a pointer to the 
;  beginning of which is 
;  currently stored in RDI),
;  and store the result in RAX.
;
;  BEGIN student code
;
;  HINT: 
;  Just like with second_func, except now we are dealing with chars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    xor rax, rax  ;zero rax
    xor dl, dl  ;zero dl

    .start_cmp:
    cmp dl, [rdi + rax]  ;compares dl with rdi + rax (rax is 0 at start)

    je .finish  ;if equal, end program

    inc rax  ;increment rax by 1
    jmp .start_cmp  ;rerun .start_cmp (makes a loop untio je .finish is triggered)

    .finish:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    pop rbp
    ret


