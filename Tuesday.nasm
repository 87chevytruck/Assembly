;;;;;;;;;;;;;;;;;;;;
;  Ricky Smith
;  Lab Tuesday
;  22 Oct 2018
;;;;;;;;;;;;;;;;;;;;

bits 32

global _copy_string, _get_cpu_string@4, _set_flags

section .text


_copy_string:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This method takes 3 params:
;
;	Param 1: An empty buffer
;
;	Param 2: A NULL-terminated string
;
;	Given these two inputs, 
;	1.) Find the length of the string provided in
;	param 2
;	2.) Copy the string from param 2, to the empty buffer
;	provided in param 1.
;
;	void __cdecl copy_string(char* dest, char* src);
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;

    
	xor eax, eax
	mov edi, [esp + 4]             ;param1 empty buffer
	mov ecx, [esp + 8]             ;param2 null-terminated string

   startloop:                      ;loop to get string length
	    xor edx, edx               ;zero edx
		mov dl, byte [ecx+eax]     ;itterates through ecx (string)
		inc eax                    ;increments eax to use as counter

		cmp dl, 0                  ;compares dl with null
		jne startloop              ;if not null keep looping, otherwise continue


		mov ecx, eax               ;move eax to ecx for counter
		add ecx, 1                 ;add 1 to counter to account for  null character

	
	copyString:                    ;move string into empty buffer
	    mov esi, [esp + 8]         ;move string into esi
		rep movsb                  ;moves from esi to edi byte by byte, repeat till counter ends
		mov eax, edi               ;move edi into eax for returning
		
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;

_get_cpu_string@4:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This function takes 1 param:
;
;	Param 1: A zero'd character buffer, containing
;	13 elements.
;
;	The following steps must be performed:
;	1.) Call CPUID and get the vendor string
;	2.) Copy from ASCII bytes returned into the buffer
;	provided.
;	
;	void __stdcall get_cpu_string(char* buf);
;
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
    xor eax, eax      ;zero eax
	mov edi, [esp + 4]
    CPUID             ;call cpuid, values stored in ebx, edx, & ecx
    mov eax, ebx      ;move ebx to eax
    stosd             ;store eax into edi (edi is where buffer is located due to first arg)
    mov eax, edx      ;move edx to eax
    stosd             ;store eax into edi (edi is where buffer is located due to first arg)
    mov eax, ecx      ;move ecx to eax
    stosd             ;store eax into edi (edi is where buffer is located due to first arg)
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
