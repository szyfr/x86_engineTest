


;;== decompress_image
;;=   Decompresses an image file and returns it in allocated memory.
;;=  Input:  rcx=data
;;=  Output: rax=image
;;=  Size:   150b
decompress_image:
	push rbp
	mov rbp,rsp
	
	;; Calculate size
	xor rax,rax
	mov al,[rcx]
	mul byte[rcx+1]
	mov r13,rax
	mov r15,rcx
	imul rax,4
	add rax,2

	;; Malloc space
	mov rcx,rax
	call malloc
	mov r14,rax

	;; Copy width and height to first spaces of memory
	mov rcx,[r15+0]
	mov [r14+0],rcx
	mov rcx,[r15+1]
	mov [r14+1],rcx
	add r14,2

	;; Decompress
	xor rbx,rbx
	add r15,2
	mov r11,palette
.loop:
	xor rax,rax
	mov al,[r15+rbx]  ; Copy byte from data
	imul rax,4        ; Multiply by 4
	mov ecx,[r11+rax] ; Copy color from palette
	mov rax,rbx
	imul rax,4
	mov [r14+rax],ecx ; Copy color into memory

	inc rbx
	cmp rbx,r13
	jb .loop

	;; Free old data
	mov rcx,r15
	sub rcx,2
	sub rsp,32
	call free
	add rsp,32

	;; Return memory location
	sub r14,2
	mov rax,r14
	
	mov rsp,rbp
	pop rbp
	ret