

;;= SDL_Init
extern SDL_Init
SDL_INIT_VIDEO          EQU 0x00000020
%macro ocSDLInit 1
	sub rsp,32
	mov ecx,%1
	call SDL_Init
	add rsp,32
%endmacro


;;= SDL_CreateWindow
extern SDL_CreateWindow
SDL_WINDOWPOS_UNDEFINED EQU 0x1FFF0000
SDL_WINDOW_SHOWN        EQU 0x00000004
%macro ocSDLCreateWindow 3
	sub rsp,96
	mov rcx,%1            ; windowname
	mov edx,%2            ; ?
	mov r8d,%2            ; ?
	mov r9d,1280          ; windowWidth
	mov dword[rsp+32],720 ; windowHeight
	mov dword[rsp+40],%3  ; ?
	call SDL_CreateWindow
	add rsp,96
%endmacro


;;= SDL_GetWindowSurface
extern SDL_GetWindowSurface
%macro ocSDLGetWindowSurface 1
	sub rsp,32
	mov rcx,%1
	call SDL_GetWindowSurface
	add rsp,32
%endmacro


;;= SDL_MapRGB
extern SDL_MapRGB
%macro ocSDLMapRGB 4
	sub rsp,32
	mov rcx,%1
	mov rdx,%2
	mov r8,%3
	mov r9,%4
	call SDL_MapRGB
	add rsp,32
%endmacro


;;= SDL_FillRect
extern SDL_FillRect
%macro ocSDLFillRect 3
	sub rsp,64
	mov rcx,%1
	mov rdx,%2
	mov r8,%3
	call SDL_FillRect
	add rsp,64
%endmacro


;;= SDL_UpdateWindowSurface
extern SDL_UpdateWindowSurface
%macro ocSDLUpdateWindowSurface 1
	sub rsp,64
	mov rcx,%1
	call SDL_UpdateWindowSurface
	add rsp,64
%endmacro


;;= SDL_PollEvent
extern SDL_PollEvent
SDL_QUIT_CODE   EQU 0x100
%macro ocSDLPollEvent 1
	sub rsp,32
	mov rcx,%1
	call SDL_PollEvent
	add rsp,32
%endmacro


;;= SDL_DestroyWindow
extern SDL_DestroyWindow
%macro ocSDLDestroyWindow 1
	sub rsp,32
	mov rcx,%1
	call SDL_DestroyWindow
	add rsp,32
%endmacro


;;= SDL_Quit
extern SDL_Quit
%macro ocSDLQuit 0
	sub rsp,32
	call SDL_Quit
	add rsp,32
%endmacro


;;= SDL_SetWindowSize
extern SDL_SetWindowSize
%macro ocSetWindowSize 3
	sub rsp,64
	mov rcx,%1
	mov edx,%2
	mov r8d,%3
	call SDL_SetWindowSize
	add rsp,64
%endmacro