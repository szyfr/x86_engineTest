


;;== draw_sprite
;;=   Draw a 8x8 sprite on the 270x180 screen
;;=  Input: x16=x
;;=         x24=y
;;=         x32=data
;;=  Size: b
draw_sprite:
	pop r12

	pop r13 ; x
	pop r14 ; y
	pop r15 ; data

	push r12

	mov rbx,0
	add r15,2
.loop:
	xor rcx,rcx
	mov ecx,[r15]
	push rcx
	add r15,4

	xor rdx,rdx
	mov rax,rbx
	mov rcx,32
	div rcx
	push rdx
	push rax

	call draw_pixel

	inc rbx

	cmp rbx,1024 ;1024
	jne .loop

	
	ret
