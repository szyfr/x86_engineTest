

;;= Structure Includes
%include "src/macros/oc_sdl2.asm"
%include "src/macros/oc_kernel32.asm"


;;= Header
global main
section .text


;;= Main
main:
	sub rsp,8

	call init_sdl
	
	; Set running = true
	mov byte[running],1

.loop:
	; SDL_PollEvent
	ocSDLPollEvent event

	mov rdx,0
	mov ecx,[event]
	cmp ecx,SDL_QUIT_CODE
	mov rcx,1
	cmove ecx,edx
	mov [running],cl

	push 0x00000000
	push 2
	push 2
	call draw_pixel

	push test_image
	push 20
	push 20
	call draw_sprite

	sub rsp,32
	mov rcx,[window]
	call SDL_UpdateWindowSurface
	add rsp,32

	mov cl,[running]
	cmp cl,1
	je .loop

.exit:
	; SDL_DestroyWindow
	ocSDLDestroyWindow [window]
	; SDL_Quit
	ocSDLQuit
	; ExitProcess
	ocExitProcess 0


;;= Function Includes
%include "src/engine/sdl/init_sdl.asm"
%include "src/engine/screen/draw_pixel.asm"
%include "src/engine/screen/draw_sprite.asm"


;;= Variables
WindowWidth       EQU 1080
WindowHeight      EQU  720
WindowName      : db "Gnosis",0
%include "src/engine/screen/testimage.asm"

section .bss
;; TODO: move
window  : resq 1
surface : resq 1
event   : resb 52
running : resb 1