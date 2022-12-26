


;;= Prepare stack
%macro prepare 0
	push rbp
	mov rbp,rsp
%endmacro

;;= Release stack
%macro release 0
	mov rsp,rbp
	pop rbp
%endmacro