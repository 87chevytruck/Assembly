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
    mov rcx, rdx     ;move length into rcx for count
    repne scasb      ;scan rdi for rax
    cmp rcx, 0       ;after scanning, if rcx = 0, it's not found
    jne .found       ;jump to found if rcx != 0

    .not_found:
        mov rax, 0   ;make rax null
        jmp .end     ;jump to end for return

    .found: 
        lea rax, [rdi-1]    ;make rax point to the "location" of rdi - 1

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
xor rax, rax
push rdi
mov rax, rdi
call ex_strlen
xor rcx, rcx
mov rcx, rax
pop rdi
xor rax, rax
mov rax, rsi
repne scasb
jne .not_found

.found:
        lea rax, [rdi-1]
        jmp .end     ;jump to end for return

.not_found:
    mov rax, 0   ;make rax null
    
.end:
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

    .loop_this:
        mov al, byte [rdi]     ;move byte from string 1 into al
        mov ah, byte [rsi]     ;move byte from string 2 into ah
        cmp al, 0              ;check al for null
        je .null               ;jump if null
        cmp ah, 0              ;check ah for null
        je .null               ;jump if null

        cmp al, ah             ;compare al and ah
        ja .string1_greater    ;jump to string1_greater if al is larger value
        jb .string2_greater    ;jump to string2_greater if ah is larger value
        inc rdi                ;increment rdi in prep for loop
        inc rsi                ;increment rsi in prep for loop
        jmp .loop_this         ;loop through above

    .null:
        cmp al, ah             ;compare al and ah
        ja .string1_greater    ;al is not null, but ah is null
        jb .string2_greater    ;ah is not null, but al is null
        je .same               ;both al and ah are null

    .string1_greater:          ;set return value
        mov rax, 1             
        jmp .finish

    .string2_greater:          ;set return value
        mov rax, -1
        jmp .finish

    .same:                     ;set return value
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
    ;rdi = destination
    ;rsi = source
xor rax, rax    ;zero rax
mov r10, rdi    ;move dest buffer to r10
xor rdi, rdi    ;zero rdi for use in ex_strlen
mov rdi, rsi    ;move source into rdi for use in ex_strlen
call ex_strlen  ;get string length, result in rax
xor rcx, rcx    ;zero rcx
mov rcx, rax    ;make rcx strlen for counter
xor rdi, rdi    ;zero rdi
mov rdi, r10    ;move dest buffer back into rdi
rep movsb       ;move byte by byte from rsi to rdi
xor rax, rax    ;zero rax
stosb           ;initialize and store first byte of rax to rdi (zero)
mov rax, r10    ;move dest buffer into rax for return
        
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
    ;rdi = string 1 (hay stack)
    ;rsi = string 2 (needle)
    mov r8, rdi         ;temp move string 1 to r8
    mov r9, rsi         ;temp move string 2 to r9
    push rdi            ;preserves string 1 prior to function call
    push rsi            ;preserves string 2 prior to function call
    xor rdi, rdi        ;clears rdi
    mov rdi, r8         ;sets rdi to string 1
    call ex_strlen      ;get strlen of string 1
    mov r8, rax         ;preserved string 1 length
    xor rax, rax        ;cleared rax
    ;push rsi            ;preserves string 2 prior to function call
    xor rdi, rdi        ;cleared rdi
    pop rsi             ;restore rsi, string 2
    mov rdi, rsi        ;temp move string 2 into rdi
    push rsi            ;preserve string 2
    call ex_strlen      ;get strlen of string 2
    xor rcx, rcx        ;clear rcx
    mov rcx, rax        ;make rcx count (strlen of string 2, needle)
    mov r10, rcx        ;preserves string length of needle
    xor rax, rax
    pop rsi             ;brings back string 2
    pop rdi             ;brings back string 1

    jmp .find_string

    .itterate_strings:
        inc rsi
        inc rdi

    .find_string:
        cmp rdi, rsi        ;compares values in rdi with rsi
        je .matched         ;if equal, jump to label matched
        dec r8
        cmp r8, 0
        je .string_not_found    ;if not equal, jump to label not_matched
        ;jne .itterate_strings
    
    .first_match:
        cmp rcx, r10
        jne .continue_matching
        mov r9, rdi
        jmp .continue_matching

    .matched:
        cmp rcx, r10
        je .first_match
        
    .continue_matching:
        inc rdi             ;increment rdi for testing next char
        inc rsi             ;increment rsi for testing next char
        dec rcx             ;decrement rcx to keep count for size of needle left to check
        cmp rcx, -1
        je .string_found    ;jump to string_found so that rdi can be push into rax for return
        jmp .find_string    ;jump back to find_string and run again

;    .first_match:
;        cmp rcx, r10
;        jne .continue_matching
;        mov r9, rdi
;        jmp .continue_matching

    .string_not_found:
        mov rax, 0          ;make rax null since string was not found
        jmp .return_me

    .string_found:
        mov rax, r9   ;mov the first occurance of string 2 (first element) from rdi into rax, r10 is lenght of string2
    
    .return_me:
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
