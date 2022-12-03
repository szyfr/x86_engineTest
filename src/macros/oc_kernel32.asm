

;;= SDL_Init
extern ExitProcess

%macro ocExitProcess 1
	mov ecx,%1
	call ExitProcess
%endmacro