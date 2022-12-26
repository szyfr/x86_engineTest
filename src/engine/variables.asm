


;;= Camera data
camera_data : resq 1

camera_data_CAM_X				equ 0  ; i8
camera_data_CAM_Y				equ 8  ; i8
camera_data_CAM_WIDTH			equ 16 ; u4
camera_data_CAM_HEIGHT			equ 20 ; u4
camera_data_SPRITE_ARRAY		equ 24 ; &8
camera_data_SPRITE_ARRAY_LEN	equ 32 ; u8
camera_data_SIZE				equ 0x28

camera_data_CAM_X_BASE			equ 0
camera_data_CAM_Y_BASE			equ 0
camera_data_CAM_WIDTH_BASE		equ 1280
camera_data_CAM_HEIGHT_BASE		equ 720


;;= Sprite data
sprite_POS_X 	equ 0  ; u4
sprite_POS_Y 	equ 4  ; u4
sprite_SIZE_X	equ 8  ; i8
sprite_SIZE_Y	equ 16 ; i8
sprite_DATA  	equ 24 ; &8
sprite_SIZE  	equ 0x20

;;= Options data



;;= Macros
%define param(a,b) ((a)+(b))