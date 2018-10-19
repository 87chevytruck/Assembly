bits 64

global first_func, second_func, third_func

first_func:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    Using the rdtsc instruction,
;  1.) Obtain the current timestamp
;  2.) Combine the low 32 bits (from RAX)
;     and the high 32 bits (RDX), and
;     return them.
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    rdtsc            ;gets time stamp, stores upper in rdx and lower in rax
    shl rdx, 32      ;shift rdx (upper result) 32 bits to make room for rax in the lower half
    or rax, rdx      ;bitwise OR on rax and rdx so that rax date can move into lower half of rdx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

second_func:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Using CPUID, get the vendor
;  string, and copy each chunk
;  returned into the buffer
;  passed to your function.
;  The buffer should be the
;  first (and only) argument.
; 
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret


