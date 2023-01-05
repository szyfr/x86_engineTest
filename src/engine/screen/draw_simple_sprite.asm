


;;== draw_simple_sprite
;;=   Draw a simple sprite on the 270x180 screen
;;=  Input: rcx=x
;;=         rdx=y
;;=         r8 =data
;;=  Destr: rax,rcx,rdx,r11,r12,r13,14,15
;;=  Size: 94b
draw_simple_sprite:
	prepare

	; Save variables
	mov r11,rcx
	mov r12,rdx
	mov r13,r8
	xor r14,r14
	mov r14b,[r13]

	; Calculate size
	xor rax,rax
	xor r15,r15
	mov al,[r13]
	inc r13
	mov r15b,[r13]
	imul r15,rax

	inc r13

	xor rbx,rbx
.loop:
	; Grab color
	xor r8,r8
	mov r8b,[r13+rbx]
	; Calculate position
	; x = x + count/8
	; y = y + count%8
	xor rdx,rdx
	mov rax,rbx
	div r14
	mov rcx,rdx
	add rcx,r11
	mov rdx,rax
	add rdx,r12
	call draw_pixel

	inc rbx
	cmp rbx,r15
	jb .loop

	release
	ret