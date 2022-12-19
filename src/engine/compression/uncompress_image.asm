


;;== uncompress_image
;;=   Uncompresses an image file
;;=  Input: r13=data
;;=  Size: b
uncompress_image:
	push rbp
	mov rbp,rsp


	;; Calculate space reqs
	xor rax,rax
	mov cl,[r13+0]
	mov al,[r13+1]
	mul cl
	;; malloc space
	mov [test_comp_len],eax
	ocmalloc eax
	mov [test_comp],rax
	

	;; Calculate space for colors
	xor rax,rax
	mov cl,4
	mov al,[r13+2]
	mul cl
	;; Copy total
	mov r14,r13
	mov r15,rax

	;; Move colors
	;;; - al  : color
	;;; - rbx : count
	;;; - r14 : colorptr
	;;; - r15 : colortotal
	xor rbx,rbx
	mov rdx,test_comp_col
	add r14,3
.loop_color:
	mov al,[r14+rbx]
	mov [rdx+rbx],al
	inc rbx
	cmp rbx,r15
	jne .loop_color

	;; Uncompress
	;;; - rbx : counter
	;;; - r9d : length
	;;; - r12 : 4
	;;; - r13 : arrayptr
	;;; - r14 : colorsptr
	;;; - r15 : outputptr
	xor rbx,rbx
	mov r9d,[test_comp_len]
	mov r12,4
	mov r13,r14
	add r13,r15
	mov r15,[test_comp]
.loop_copy:
	xor rax,rax
	mov al,[r13+rbx]
	mul r12
	mov eax,[r14+rax]
	mov r8d,eax
	mov rax,rbx
	mul r12
	mov dword[r15+rax],r8d

	inc rbx
	cmp ebx,r9d
	jne .loop_copy


	mov rsp,rbp
	pop rbp
	ret