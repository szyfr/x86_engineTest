


;;== decompress_image
;;=   Decompresses an image file
;;=  Input: r13=data
;;=  Size: 175b
;; TODO Re-write this to be clearer, make better use of registers, have output location for malloc'd data.
decompress_image:
	push rbp
	mov rbp,rsp


	;; Calculate space reqs
	xor rax,rax
	mov al,[r13+1]
	mul byte[r13+0]
	;; malloc space
	mov [test_comp_len],rax
	mov rcx,4
	mul rcx
	ocmalloc rax
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
	mov r9,[test_comp_len]
	mov r12,4
	mov r13,r14
	add r13,r15
	mov r15,[test_comp]
.loop_copy:
	xor rax,rax
	mov al,[r13+rbx]
	mul r12
	mov ecx,[r14+rax]
	mov rax,rbx
	mul r12
	mov [r15+rax],ecx

	inc rbx
	cmp rbx,r9
	jb .loop_copy


	push r10
	mov rsp,rbp
	pop rbp
	ret