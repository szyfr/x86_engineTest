

;;= malloc
extern malloc

%macro ocmalloc 1
;	sub rsp,32
	mov rcx,%1
	call malloc
;	add rsp,32
%endmacro


;;= free
extern free

%macro ocfree 1
;	sub rsp,32
	mov rcx,%1
	call free
;	add rsp,32
%endmacro