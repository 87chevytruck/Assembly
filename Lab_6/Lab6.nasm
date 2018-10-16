; Name:  Ricky Smith
; Title:  Lab 6
; Date:  15 Oct 2018

bits 64

global first_func, second_func, third_func

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSTRUCTIONS
; -Set the flags via by arithmetic operation
; -Then set the flags manually*
; *You will need to comment out the previous solution 


first_func:
    push rbp
    mov rbp, rsp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Set the carry flag.
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;mov al, 220
    ;add al, 111
    pushf
    pop rax
    or rax, 1
    push rax
    popf
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    pop rbp
    ret

second_func:
    push rbp
    mov rbp, rsp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Set the overflow flag.
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;mov al, -129
    ;sub al, -330
    pushf
    pop rax
    or rax, 2048
    push rax
    popf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    pop rbp
    ret

third_func:
    push rbp
    mov rbp, rsp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Set both the carry and overflow
;  flags.
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;mov al, -128
    ;add al, -128
    pushf
    pop rax
    or rax, 2049
    push rax
    popf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    pop rbp
    ret

