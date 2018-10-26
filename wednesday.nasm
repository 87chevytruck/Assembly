;  Ricky Smith    ;
;  Wednesday Lab  ;
;  25 Oct 2018    ;
;;;;;;;;;;;;;;;;;;;

bits 32

global _sum_array@8, _find_largest

section .text


_sum_array@8:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This method takes two parameters:
;
;	Param 1: A pointer to a buffer of integers (4 bytes/each).
;
;	Param 2: A number indicating the number of elements in the buffer.
;
;	You must:
;	1.) Walk through the buffer, and sum together all of the elements
;	2.) Return the result
;
;	int __stdcall sum_array(int* buffer, int size);
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
xor eax, eax                    ;zero eax
xor ecx, ecx					;zero ecx
xor edx, edx					;zero edx
mov ecx, [esp + 8]				;param 2, number of elements in buffer
mov edx, [esp + 4]				;param 1, buffer of intergers
sub ecx, 1						;subtract 1 from ecx (count) to account for initial element move
mov eax, [edx]					;initial element move of value at edx to eax
.loop_sum:						;label for looping
	add eax, [edx + ecx*4]		;add value located in edx to eax, each loop will itterate 4 bytes usince ecx as count
	loop .loop_sum				;loops until ecx is zero

	ret 8						;return 8 for cleanup
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;


_find_largest:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This function takes two
;	parameters:
;
;	Param 1: A pointer to a buffer of integers (4 bytes/each)
;
;	Param 2: A number indicating the number of elements in the
;	buffer.
;
;	Your task is to:
;	1.) Walk through the buffer, locating the largest element
;	2.) Return it as the result.	
;
;	int __cdecl find_largest(unsigned long* buffer, int size)
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
	xor eax, eax						;zero reg
	xor edx, edx						;zero reg
	xor ebx, ebx						;zero reg

	mov edi, [esp + 4]					;move param 1 into edi
	mov esi, [esp + 8]					;move param 2 into esi

    dec esi								;adjust count by 1

    mov edx, [edi + esi*4]				;move value in edi to edx
    jmp .compare						;jump to compare

    .less:
        mov edx, ebx

    .compare:							;label for compare
        dec esi							;decrement esi (count) by 1 for next integer move
        cmp esi, -1						;compare count to -1 (allows proram to continue with count at zero)
        je .end							;if count is -1, jump to end, otherwise continue
        mov ebx, [edi + esi*4]			;move next value in edi to ebx
        cmp edx, ebx					;compare edx and ebx
        jl .less						;if edx is smaller, jump to .less (moves larger value from ebx into edx, then continues into compare again)
		jmp .compare					;if edx is larger than or equal to ebx, jump to compare (creates a loop)
    
	.end:
        mov eax, edx					;largest number is left in edx, and is moved into eax for return

	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;