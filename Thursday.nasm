;  Ricky Smith
;  Thursday Lab
;  26 Oct 2018
;;;;;;;;;;;;;;;;


bits 32

global _fibonacci@4, _walk_list_map@8


section .text


_fibonacci@4:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This method takes a single parameter:
;	
;	Param 1: The fibonacci number to calculate (e.g., "5" would indicate
;	to calculate and return the 5th fibonacci number).
;
;	int __stdcall fibonacci(int n);	
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ecx, [esp+4]		;move param 1 into ecx
	mov eax, 0				;make eax 0 for start
	mov edi, 1				;start at 1

	.fib_it:
		xor esi, esi		;clear esi
		add esi, eax
		add esi, edi
		mov eax, edi
		mov edi, esi
		loop .fib_it

	ret 4
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;


struc Node
	.Next	resd  1
	.Data	resd  1
endstruc


_walk_list_map@8:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This method takes two parameters:
;
;	Param 1: A pointer to the beginning of a linked list of nodes (structure
;	definition above)
;
;	Param 2: A function pointer
;
;	Your task:
;	1.) Walk the list of nodes
;	2.) For each node, call the function pointer provided
;	as parameter 2, giving it as input the Data from the node.
;
;	void __stdcall walk_list_map(Node* n, void(*)(size_t));
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
xor eax, eax			;zero out
xor edi, edi			;zero out
xor ecx, ecx			;zero out
xor edx, edx			;zero out
mov edi, [esp + 4]			;param 1, list
mov edx, [esp + 8]			;param 2, function pointer


	.run_functions:
	    mov esi, [edi + Node.Data]      ;data from list moved into esi
		push esi						;push esi for use in function call
		call edx						;call edx (function poitner)
		pop eax							;pop result into eax
		mov edi, [edi + Node.Next]      ;move to next node
		cmp edi, 0                      ;compare data in edi with 0 (null)
		je .struct_end                  ;if equal, jump to .struct_end as there's no more data to process
		loop .run_functions             ;loop till struct data is null

    .struct_end:
		ret 8							;return with 8 for cleanup
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;