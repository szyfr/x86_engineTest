


;;== resize_window_sdl
;;=   Resizes the window in SDL2.
;;=  Input: NONE
;;=  Size:  205b
resize_window_sdl:
	prepare

	mov r15,[camera_data]
	ocSetWindowSize [window],[r15+camera_data_CAM_WIDTH],[r15+camera_data_CAM_HEIGHT]

	ocSDLGetWindowSurface [window]
	mov [surface],rax

	release
	ret