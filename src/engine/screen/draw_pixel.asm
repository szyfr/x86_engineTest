


;;== draw_pixel
;;=   Draw a pixel on the 270x180 screen
;;=  Input: x16=x
;;=         x24=y
;;=         x32=color
;;=  Size: 138b
draw_pixel:
	pop r12

	; Calculate position in array
	; r9 = (x*16) + width(y*16)
	mov r10,16
	mov rcx,WindowWidth  ; TODO Options
	pop rax
	mul rcx
	mul r10
	mov r11,rax
	pop rax
	mul r10
	add rax,r11
	mov r9,rax

	; Get array member
	mov rdx,[surface]
	add rdx,32
	mov rcx,[rdx]
	add rcx,r9

	pop rdx

	; Set pixel
	mov dword[rcx],edx
	mov dword[rcx+4],edx
	mov dword[rcx+8],edx
	mov dword[rcx+12],edx
	mov dword[rcx+(WindowWidth*4)],edx
	mov dword[rcx+(WindowWidth*4)+4],edx
	mov dword[rcx+(WindowWidth*4)+8],edx
	mov dword[rcx+(WindowWidth*4)+12],edx
	mov dword[rcx+(WindowWidth*8)],edx
	mov dword[rcx+(WindowWidth*8)+4],edx
	mov dword[rcx+(WindowWidth*8)+8],edx
	mov dword[rcx+(WindowWidth*8)+12],edx
	mov dword[rcx+(WindowWidth*12)],edx
	mov dword[rcx+(WindowWidth*12)+4],edx
	mov dword[rcx+(WindowWidth*12)+8],edx
	mov dword[rcx+(WindowWidth*12)+12],edx

	push r12
	ret