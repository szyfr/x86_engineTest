

;;= Structure Includes
%include "src/macros/oc_sdl2.asm"
%include "src/macros/oc_kernel32.asm"
%include "src/macros/oc_mscrt.asm"


;;= Header
global main
section .text


;;= Main
main:
	sub rsp,8

	call init_sdl
	
	; Set running = true
	mov byte[running],1

	; Compression testing
	mov r13,test_image_2
	call decompress_image

.loop:
	; SDL_PollEvent
	ocSDLPollEvent event

	mov rdx,0
	mov ecx,[event]
	cmp ecx,SDL_QUIT_CODE
	mov rcx,1
	cmove ecx,edx
	mov [running],cl

;	push 0x00000000
;	push 2
;	push 2
;	call draw_pixel

	mov rcx,[test_comp]
	push rcx
;	push test_comp
;	push test_image
	push 20
	push 20
	call draw_sprite

;	push test_image
;	push 40
;	push 40
;	call draw_sprite

	sub rsp,32
	mov rcx,[window]
	call SDL_UpdateWindowSurface
	add rsp,32

	mov cl,[running]
	cmp cl,1
	je .loop

.exit:
	ocSDLDestroyWindow [window]
	ocSDLQuit
	ocExitProcess 0


;;= Function Includes
%include "src/engine/sdl/init_sdl.asm"
%include "src/engine/screen/draw_pixel.asm"
%include "src/engine/screen/draw_sprite.asm"
%include "src/engine/compression/decompress_image.asm"


;;= Variables
WindowWidth       EQU 1080
WindowHeight      EQU  720
WindowName      : db "Gnosis",0
number_four     : db 4
%include "src/engine/screen/testimage.asm"

section .bss
;; TODO: move
window    : resq 1
surface   : resq 1

test_comp : resq 1
test_comp_len : resq 1
test_comp_col : resb 40

event     : resb 0x67
running   : resb 1

