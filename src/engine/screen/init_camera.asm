


;;== init_camera
;;=   Initializes the camera system
;;=  Input: =
;;=  Destr: 
;;=  Size:  b
init_camera:
	prepare

	ocmalloc camera_data_SIZE,[camera_data]

	mov qword[rax+camera_data_CAM_X],camera_data_CAM_X_BASE
	mov qword[rax+camera_data_CAM_Y],camera_data_CAM_Y_BASE
	mov dword[rax+camera_data_CAM_WIDTH], 1920
	mov dword[rax+camera_data_CAM_HEIGHT],1080
;	mov dword[rax+camera_data_CAM_WIDTH],camera_data_CAM_WIDTH_BASE
;	mov dword[rax+camera_data_CAM_HEIGHT],camera_data_CAM_HEIGHT_BASE
	mov dword[rax+camera_data_SCALE],camera_data_SCALE_BASE

	mov dword[rax+camera_data_SPRITE_ARRAY],0
	mov dword[rax+camera_data_SPRITE_ARRAY_LEN],0

	release
	ret