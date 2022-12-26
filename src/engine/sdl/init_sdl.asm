


;;== init_sdl
;;=   Initializes sdl.
;;=  Input: NONE
;;=  Size:  205b
init_sdl:
	prepare

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
	ocSDLMapRGB [rax+8],0x00,0x00,0x00
	
	; SDL_FillRect
	ocSDLFillRect [surface],0,rax

	; SDL_UpdateWindowSurface
	ocSDLUpdateWindowSurface [window]

	release
	ret