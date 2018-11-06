bits 32

global _unpack_string@12, @walk_list@8, _call_function

section .text


_unpack_string@12:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;	This function takes three params:
;
;  Param 1: A string of unsigned characters, all of which have been left
;  shifted 1 bit
;
;  Param 2: An empty, NULL-terminated character string
;
;  Param 3: A size indicating the number of bytes each string can hold.
;
;  This function simply needs to:
;	1.) Walk the first string, loading each byte
;	2.) Right-shift the value retrieved
;	3.) Store the result in the destination string
;
;	void __stdcall unpack_string(unsigned char* input, char* output, size_t length);
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	mov esi, [esp + 4]     ;store Param 1 (string) into esi
	mov edi, [esp + 8]     ;store Param 2 (empty string) into edi
	mov ecx, [esp + 12]    ;store Param 3 (byte count) into ecx to use as counter

	.move_shift:
	    test esi, edi       ;test for zero
		je .finish          ;if equal (null char reached) go to .finish
		lodsb               ;moves one byte from esi to eax
		shr al, 1           ;shifts al byte right by 1 bit
	    stosb               ;moves shifted byte from eax to edi
	    loop .move_shift    ;repeats .move_shift until ecx counter finishes

    .finish
	    ret 12

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;


struc Node
	.Next	resd  1
	.Data	resd  1
endstruc

@walk_list@8:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;	This function takes 2 parameters:
;	
;	Param 1: A pointer to the beginning of a linked list of nodes (
;   structure definition given above), which is NULL-terminated (e.g., the
;   last Next pointer is NULL).
;
;	Param 2: A needle to search for within the list.
;
;	Walk the list, searching each Node for the needle (in Node.Data), and either:
;	1.) Return the node where you found the value
;	2.) Return NULL if the value cannot be found
;
;   Node* __fastcall walk_list(Node* start, size_t needle);
;
;	HINTS:
;	-Notice the struc Node on line 46
;	-Think back to these Nodes... what are they? 
;	-Take a look at main.cpp and note which is the next node
;	-Remember... the next sequential address you need is given to you... this isn't like itterating through arrays
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
    xor eax, eax         ;zero out
	
	mov edi, [ecx]     ;store Param 2 (list to search through) from ecx (due to fast_call) into edi 

	.compare_values:
	    mov eax, [edi + Node.Data]     ;data from list moved into eax
		cmp edx, eax                   ;compare needle (edx due to fast_call) with data in eax
		je .found                      ;if equal, jump to .found
		mov edi, [edi + Node.Next]     ;move to next node
		cmp edi, 0                     ;compare data in edi with 0 (null)
		je .not_found                  ;if equal, jump to .not_found
		loop .compare_values           ;loop till one of the jumps happen

	.found:
	    mov eax, edi                   ;move edi into eax for returning
	    ret

    .not_found:
	    xor eax, eax                   ;needle not found, zero out eax for return of Null
		ret
	
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;

extern _first_func@0
extern _test_func

_call_function:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This function takes no parameters.
;
; Using the two extern'd in functions (above):
;
;	_first_func@0 -> int __stdcall first_func();
;	_test_func -> int __cdecl test_func(int);
;
;	1.) Call _first_func@0
;	2.) Take the result from the first function call,
;	and pass it as a parameter to _test_func
;	3.) Return the result.
;
;	 int __cdecl call_function();
;	
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
    xor eax, eax             ;zero eax
    call _first_func@0       ;call the first_func@0  ...don't forget the @0.... result is stored in eax

	push eax                 ;push eax to stack
	call _test_func          ;call _test_func
	pop edx                  ;pull result from test_func into edx for return purposes due do cdecl
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;