


;; TODO move
camera_data_SIZE		equ 16
camera_data_CAMX		equ 0
	camera_data_CAMX_BASE	equ 0
camera_data_CAMY		equ 8
	camera_data_CAMY_BASE	equ 0
%define param(a,b) ((a)+(b))


;;== init_camera
;;=   Initializes the camera system
;;=  Input: =
;;=  Destr: 
;;=  Size:  b
init_camera:
	prepare

	ocmalloc camera_data_SIZE,[camera_data]

	mov qword[rax+camera_data_CAMX],camera_data_CAMX_BASE
	mov qword[rax+camera_data_CAMY],camera_data_CAMY_BASE

	;; TODO Camera stuff

	release
	ret