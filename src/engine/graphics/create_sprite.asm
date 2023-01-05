


;;== create_sprite
;;=   
;;=  Input:  rcx=low
;;=			 rdx=mid
;;=			 r8 =hig
;;=  Output: rax=spriteptr
;;=  Destr:  
;;=  Size:   b
create_sprite:
	prepare

	push rcx
	push rdx
	push r8

	;; malloc space for sprite
	ocmalloc sprite_SIZE,rax

	pop r8
	pop rdx
	pop rcx
	push rax

	mov qword[rax+sprite_POS_X],0
	mov qword[rax+sprite_POS_Y],0
	
.check_low:
	cmp rcx,0
	jne .decompress_low
	pop r15
	mov r14,[graphics_data]
	mov rcx,[r14+graphics_data_BLANKTILE]
	mov [r15+sprite_DATA_LOW],rcx
	push r15
	jmp .check_mid
.decompress_low:
	call decompress
	pop r15
	mov [r15+sprite_DATA_LOW],rax
	push r15

.check_mid:
	cmp rdx,0
	jne .decompress_mid
	pop r15
	mov r14,[graphics_data]
	mov rdx,[r14+graphics_data_BLANKTILE]
	mov [r15+sprite_DATA_MID],rdx
	push r15
	jmp .check_hig
.decompress_mid:
	call decompress
	pop r15
	mov [r15+sprite_DATA_MID],rax
	push r15

.check_hig:
	cmp r8,0
	jne .decompress_hig
	pop r15
	mov r14,[graphics_data]
	mov r8,[r14+graphics_data_BLANKTILE]
	mov [r15+sprite_DATA_MID],r8
	push r15
	jmp .exit
.decompress_hig:
	call decompress
	pop r15
	mov [r15+sprite_DATA_MID],rax
	push r15

.exit:
	pop rax

	release
	ret