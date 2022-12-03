


;;== init_sdl
;;=   Initializes sdl.
;;=  Input: NONE
;;=  Size:  205b
init_sdl:
	push rbp
	mov rbp,rsp

	; SDL_Init
	ocSDLInit SDL_INIT_VIDEO
	test eax,eax
	js main.exit

	; SDL_CreateWindow
	ocSDLCreateWindow WindowName,SDL_WINDOWPOS_UNDEFINED,SDL_WINDOW_SHOWN
	test rax,rax
	jz main.exit
	mov [window],rax
	
	; SDL_GetWindowSurface
	ocSDLGetWindowSurface rax
	mov [surface],rax

	; SDL_MapRGB
	ocSDLMapRGB [rax+8],0xFF,0xFF,0xFF
	
	; SDL_FillRect
	ocSDLFillRect [surface],0,rax

	; SDL_UpdateWindowSurface
	ocSDLUpdateWindowSurface [window]

	mov rsp,rbp
	pop rbp
	ret