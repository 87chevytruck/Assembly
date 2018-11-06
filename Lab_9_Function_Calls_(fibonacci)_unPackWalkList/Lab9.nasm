;  Ricky Smith
;  Lab 9
;  18 Oct 2018

bits 64

global first_func, second_func, third_func

extern printf
mystr  db "Success!", 0xa, 0x00

first_func:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  The function printf has been
;  externed in (above). Call it,
;  passing mystr (also defined
;  above), as its only argument.
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    xor rax, rax
    mov edi, mystr
    call printf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

extern strlen

second_func:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Your function will be called
;  with two arguments: a function
;  pointer (the first parameter),
;  and a string (the second). The
;  function pointer takes two
;  arguments: a string, and a length.
;  You will need to call strlen
;  (above), passing in the string,
;  and pass the results to the
;  function pointer (along with the
;  string). Return the string you get
;  back from the function. 
;
;  This lab requires a lot of instructions
;
;  It may be wise to seperate the instructions
;  into logical sections. 
;
;  -Very first thing you need to do is figure out calling convention
;  -You will first need to ensure you preserve values
;  -Then you will need to get the string length of the string provided via argument
;  -After which, you need to pass the string and string length to the 
;   function pointer and then call the function pointer.
;  
;  HINTS: 
;  - Preserve values, you will def need to preserve function pointer for call
;  - Some arguments will need to be preserved/reassigned to different registers
;    in order to be passed/called later. 
;
; 
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    xor rax, rax  ;zero rax
    
    mov r9, rsi ;preserve original rsi data
    mov r8, rdi ;preserve original rdi data

    mov rdi, rsi  ;mov rsi into rdi so the string is in rdi
    call strlen  ;run strlen against string in rdi
    
    mov rsi, rax  ;rax has return from strlen, move that to rsi
    mov rdi, r9  ;r9 has the string, move that to rdi
    call r8  ;call r8, the original rdi (function_ptr)
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

third_func:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Calculate the Nth fibonacci
;  number (where N is the value
;  passed to your method as the
;  only parameter).
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov rcx, rdi  ;move rdi (N number) to rcx for loop counter
    mov rax, 0  ;start rax at 0
    mov r9, 1  ;start first "variable" at 1

    .continue:
        xor r8, r8  ;zero r8 each loop
        add r8, rax  ;add rax to r8 each loop
        add r8, r9  ;add r9 to r8 each loop
        mov rax, r9  ;make rax equal to r9 each loop
        mov r9, r8  ;make r9 equal to r8 each loop
        loop .continue  ;creats loop through .continue label until rcx counter runs out
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret


