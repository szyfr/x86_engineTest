

;;= malloc
extern malloc

%macro ocmalloc 1
	sub rsp,32
	mov rcx,%1
	call malloc
	add rsp,32
%endmacro