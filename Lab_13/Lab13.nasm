bits 64

; LABS
global ex_strlen, ex_memcpy, ex_memset, ex_memcmp, ex_memchr, ex_strchr, ex_strcmp, ex_strcpy, ex_atoi
global ex_strstr, find_largest, walk_list

; BONUS LABS
global ex_isort, ex_qsort


find_largest:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  This function takes two arguments:
;  - Arg1: A pointer to an array of integers
;  - Arg2: The number of integers in the array
;
;  Find and return the largest element in the array.
;  
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    xor rax, rax
    xor rdx, rdx
    xor rbx, rbx
    dec rsi

    mov edx, [rdi + rsi*4]
    jmp .compare

    .less:
        mov edx, ebx

    .compare:
        dec rsi
        cmp rsi, -1
        je .end
        mov ebx, [rdi + rsi*4]
        cmp edx, ebx
        jg .compare
        jl .less

    .end:
        mov eax, edx
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_strlen:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  size_t strlen(char*);  
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
xor rax, rax
   startloop:                      ;loop to get string length
        xor rdx, rdx               ;zero rdx
        mov dl, byte [rdi+rax]     ;itterates through string located in rdi
        inc rax                    ;increments rax to use as counter
        cmp dl, 0                  ;compares dl with null
        jne startloop              ;if not null keep looping, otherwise continue
        sub rax, 1                 ;subtract 1 from counter
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_memcpy:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  void memcpy(void* dst, void* src, int count);
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;rdi = dst
    ;rsi = src
    ;rdx = int count
    xor rax, rax         ;zero rax
    mov rcx, rdx         ;move rdx into rcx for use as counter
    rep movsb            ;moves byte by byte from rsi to rdi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret


ex_memset:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	void memset(void* buf, unsigned char value, size_t length);
;
;  BEGIN student c sub rcx, 1ode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;rdi = buf
    ;rsi = char value
    ;rdx = length
    xor rax, rax         ;zero rax
    mov rcx, rdx         ;move rdx into rcx for use as counter
    mov rax, rsi         ;mov char value from rsi to rax
    rep stosb            ;stores rax into rdi


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_memchr:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	void* memchr(void* haystack, unsigned char needle, size_t length);
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;rdi = haystack
    ;rsi = needle
    ;rdx = length
    xor rax, rax     ;zero rax
    mov rax, rsi     ;move needle into rax
    mov rcx, rdx     ;move lenght into rcx for count
    repne scasb      ;scan rdi for rax
    cmp rcx, 0       ;after scanning, if rcx = 0, it's not found
    jne .found       ;jump to found if rcx != 0

    .not_found:
        mov rax, 0   ;make rax null
        jmp .end     ;jump to end for return

    .found:
        sub rdx, rcx            ;sub original length with rcx count
        sub rdx, 1              ;sub 1 from rdx to account for elements starting at 0, not 1
        ;add rdx, 1
        ;sub rcx, 1
        mov rax, [rdi + rdx]    ;make rax point to rdi + count


       ;mov rax, [rdi]


    .end:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_memcmp:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	int memcmp(void*, void*, size_t length);
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;rdi = void
    ;rsi = void
    ;rdx = length
    xor rax, rax
    mov rcx, rdx
    rep cmpsb
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_strchr:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;rdi = char string
    ;rsi = int char
;xor rax, rax
;   startloop:                      ;loop to get string length
;        xor rdx, rdx               ;zero rdx
;        mov dl, byte [rdi+rax]     ;itterates through string located in rdi
;        inc rax                    ;increments rax to use as counter
;        cmp dl, 0                  ;compares dl with null
;        jne startloop              ;if not null keep looping, otherwise continue
;        sub rax, 1                 ;subtract 1 from counter
;
;    mov rcx, rax
;    repne scasb
;    cmp rcx, 0       ;after scanning, if rcx = 0, it's not found
;    jne .found       ;jump to found if rcx != 0
;
;    .not_found:
;        mov rax, 0   ;make rax null
;        jmp .end     ;jump to end for return
;
;    .found:
        ;sub rdx, rcx            ;sub original length with rcx count
        ;sub rdx, 1              ;sub 1 from rdx to account for elements starting at 0, not 1
        ;mov rax, [rdi + rdx]    ;make rax point to rdi + count


;        mov rax, byte [rdi]


 ;   .end:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_strcmp:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;rdi = string 1
    ;rsi = string 2
    xor rax, rax
;    get_len:                      ;loop to get string length
;        xor rdx, rdx               ;zero rdx
;        mov dl, byte [rdi+rax]     ;itterates through string located in rdi
;        inc rax                    ;increments rax to use as counter
;        cmp dl, 0                  ;compares dl with null
;        jne get_len              ;if not null keep looping, otherwise continue
;        sub rax, 1                 ;subtract 1 from counter
;    mov rcx, rax
;    xor rax, rax

    .loop_this
        mov al, byte [rdi]
        mov ah, byte [rsi]
        cmp al, 0
        je .null
        cmp ah, 0
        je .null

        cmp al, ah
        ja .string1_greater
        jb .string2_greater
        inc rdi
        inc rsi
        jmp .loop_this

    .null:
        cmp al, ah
        ja .string1_greater
        jb .string2_greater
        je .same



;    repe cmpsb
;    cmp rdi, rsi
;    ja .string1_greater
;    jb .string2_greater
;    je .same

    .string1_greater:
        mov rax, 1
        jmp .finish

    .string2_greater:
        mov rax, -1
        jmp .finish

    .same:
        mov rax, 0

    .finish:
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_strcpy:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  |-- |      |--- |    |\     |    |   |   |-------
;  |   |      |    |    | \    |    |   |   |
;  |---- |    |    |    |  \   |    |   |   |_______
;  |     |    |    |    |   \  |    |   |           |
;  |     |    |    |    |    \ |    |   |           |
;  |____ |    |___ |    |     \|    |___|   ________|
;
;
;        |           |------ |   |------ |     |-------
;        |           |       |   |       |     |_______
;        |           |------ |   |-------- |           |
;        |           |       |   |         |           |
;        |_______    |       |   |_________|   ________|
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


ex_atoi:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret


ex_strstr:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret


struc Node
	.Next	resq	1
	.Data	resq	1
endstruc

 walk_list:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ret


ex_isort:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  insertion_sort.c is provided
;  to give an example implementation.
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret


ex_qsort:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret
