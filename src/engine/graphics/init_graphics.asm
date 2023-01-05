


;;== init_graphics
;;=   
;;=  Input: =
;;=  Destr: 
;;=  Size:  b
init_graphics:
	prepare

	; malloc graphics_data
	ocmalloc graphics_data_SIZE,[graphics_data]

	; malloc tile array
	ocmalloc NUM_TILES,rax
	mov rcx,[graphics_data]
	mov [rcx+graphics_data_TILEARRAY],rax

	; zero out map
	mov rcx,[graphics_data]
	mov qword[rcx+graphics_data_MAPARRAY],0
	mov qword[rcx+graphics_data_MAPARRAY_LEN],0

	; decompress blank tile
	mov rcx,blank_tile
	call decompress
	mov rcx,[graphics_data]
	mov [rcx+graphics_data_BLANKTILE],rax
	

	release
	ret