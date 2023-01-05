

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
	call init_camera
	call init_graphics
	call resize_window_sdl

	; Set running = true
	mov byte[running],1

	; Compression testing
;	mov rcx,blank_tile
;	call decompress
;	mov [test_comp],rax
;	call init_graphics
	xor rcx,rcx
	xor rdx,rdx
	xor r8,r8
	call create_sprite
	mov rcx,[graphics_data]
	mov rcx,[rcx+graphics_data_TILEARRAY]
	mov [rcx],rax

.loop:
	ocSDLPollEvent event

	mov rdx,0
	mov ecx,[event]
	cmp ecx,SDL_QUIT_CODE
	mov rcx,1
	cmove ecx,edx
	mov [running],cl

	; Draw
	mov rcx,0x10
	mov rdx,0x10
	mov r8,[test_comp]
;	mov r8,[graphics_data]
;	mov r8,[r8+graphics_data_TILEARRAY]
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
%include "src/engine/functions.asm"

;;= Data Includes
test_tile:	incbin "data/testTile.bin"
blank_tile:	incbin "data/blankTile.bin"
palette:	incbin "data/palette.bin"

;;= Variables
WindowName : db "Hecate",0

section .bss
%include "src/engine/variables.asm"


test_comp : resq 1
test_comp_len : resq 1
test_comp_col : resb 40

running   : resb 1

