


;;== create_sprite
;;=   
;;=  Input: =
;;=  Destr: 
;;=  Size:  b
create_sprite:
	prepare

	ocmalloc sprite_SIZE,rax
	push rax
	
	mov rcx,blank_tile
	call decompress
	pop r15
	mov [r15+sprite_DATA_MID],rax
	mov [r15+sprite_DATA_HIG],rax
	push r15

	mov rcx,test_tile
	call decompress
	pop r15
	mov [r15+sprite_DATA_LOW],rax


	release
	ret