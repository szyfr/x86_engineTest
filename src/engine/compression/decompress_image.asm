


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
	mov rcx,4
	mul rcx
	add rax,2

	;; Malloc space
	ocmalloc rax
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
	mov r12,4
	mov r11,palette
.loop:
	xor rax,rax
	mov al,[r15+rbx]  ; Copy byte from data
	mul r12           ; Multiply by 4
	mov ecx,[r11+rax] ; Copy color from palette
	mov rax,rbx
	mul r12
	mov [r14+rax],ecx ; Copy color into memory

	inc rbx
	cmp rbx,r13
	jb .loop

	;; Free old data
	ocfree r15

	;; Return memory location
	sub r14,2
	mov rax,r14
	
	mov rsp,rbp
	pop rbp
	ret

;;;== decompress_image
;;;=   Old step 2 decompression algorithm
;decompress_image:
;	push rbp
;	mov rbp,rsp
;
;
;	;; Calculate space reqs
;	xor rax,rax
;	mov al,[r13+1]
;	mul byte[r13+0]
;	;; malloc space
;	mov [test_comp_len],rax
;	mov rcx,4
;	mul rcx
;	ocmalloc rax
;	mov [test_comp],rax
;	
;
;	;; Calculate space for colors
;	xor rax,rax
;	mov cl,4
;	mov al,[r13+2]
;	mul cl
;	;; Copy total
;	mov r14,r13
;	mov r15,rax
;
;	;; Move colors
;	;;; - al  : color
;	;;; - rbx : count
;	;;; - r14 : colorptr
;	;;; - r15 : colortotal
;	xor rbx,rbx
;	mov rdx,test_comp_col
;	add r14,3
;.loop_color:
;	mov al,[r14+rbx]
;	mov [rdx+rbx],al
;	inc rbx
;	cmp rbx,r15
;	jne .loop_color
;
;	;; Uncompress
;	;;; - rbx : counter
;	;;; - r9d : length
;	;;; - r12 : 4
;	;;; - r13 : arrayptr
;	;;; - r14 : colorsptr
;	;;; - r15 : outputptr
;	xor rbx,rbx
;	mov r9,[test_comp_len]
;	mov r12,4
;	mov r13,r14
;	add r13,r15
;	mov r15,[test_comp]
;.loop_copy:
;	xor rax,rax
;	mov al,[r13+rbx]
;	mul r12
;	mov ecx,[r14+rax]
;	mov rax,rbx
;	mul r12
;	mov [r15+rax],ecx
;
;	inc rbx
;	cmp rbx,r9
;	jb .loop_copy
;
;
;	mov rsp,rbp
;	pop rbp
;	ret