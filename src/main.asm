

;;= Structure Includes
%include "src/macros/general.asm"
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

	call init_camera
	call resize_window_sdl

	; Compression testing
	mov rcx,test_tile
;	mov rcx,test_image_compressed
	call decompress
;	mov rcx,rax
;	call decompress_image
	mov [test_comp],rax

.loop:
	ocSDLPollEvent event

	mov rdx,0
	mov ecx,[event]
	cmp ecx,SDL_QUIT_CODE
	mov rcx,1
	cmove ecx,edx
	mov [running],cl

	; Draw
	mov rcx,0x0
	mov rdx,0x0
	mov r8,[test_comp]
	call draw_sprite
	mov rcx,0x10
	mov rdx,0x10
	mov r8,[test_comp]
	call draw_sprite
	mov rcx,0x20
	mov rdx,0x10
	mov r8,[test_comp]
	call draw_sprite

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
%include "src/engine/functions.asm"

;;= Data Includes
test_tile: incbin "data/testTile.bin"

;;= Variables
WindowWidth       EQU 1080
WindowHeight      EQU  720
WindowName : db "Gnosis",0
%include "src/engine/screen/testimage.asm"

section .bss
;; TODO: move
window    : resq 1
surface   : resq 1

%include "src/engine/variables.asm"


test_comp : resq 1
test_comp_len : resq 1
test_comp_col : resb 40

event     : resb 0x67
running   : resb 1

