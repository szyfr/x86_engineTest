


;;== decompress
;;=   Decompresses a file into allocated memory
;;=  Input:  rcx=data
;;=  Output: rax=file
;;=  Size:   b
decompress:
	push rbp
	mov rbp,rsp
	

	;; malloc
	mov r15,rcx
	ocmalloc [r15]
	mov r14,rax
	mov r12,rax
	mov r13,[r15]
	add r15,8

	;; Decompress
	xor rbx,rbx
.loop:
	mov al,[r15+rbx]
	inc rbx
	mov cl,[r15+rbx]
	inc rbx

	xor r11,r11
.inner:
	mov [r12],cl
	inc r11
	inc r12
	cmp r11b,al
	jb .inner

;	add r12b,al
	xor rax,rax
	cmp rbx,r13
	jb .loop

	;; Return pointer
	mov rax,r14


	mov rsp,rbp
	pop rbp
	ret