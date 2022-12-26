


;;== decompress
;;=   Decompresses a file into allocated memory
;;=  Input:  rcx=data
;;=  Output: rax=file
;;=  Size:   87b
decompress:
	prepare

	;; malloc
	mov r15,rcx
	ocmalloc [r15],r14
	mov r12,rax
	mov r13,[r15]
	add r15,8

	;; Decompress
	xor rbx,rbx
	xor r10,r10
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
	inc r10
	cmp r11b,al
	jb .inner

	xor rax,rax
	cmp r10,r13
	jb .loop

	;; Return pointer
	mov rax,r14

	release
	ret