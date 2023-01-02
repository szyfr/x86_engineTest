


;;== draw_pixel
;;=   Draw a pixel on the 270x180 screen
;;=  Input: rcx=x
;;=         rdx=y
;;=         r8b=color
;;=  Destr: rax,rcx,rdx,r8,r9,r10
;;=  Size:  136b
draw_pixel:
	prepare

	; Calculate position
	; position = (x*scale) + screenwidth(y*scale)
	mov r9,[camera_data]
	imul ecx,[r9+camera_data_SCALE]
	imul edx,[r9+camera_data_SCALE]
	imul edx,[r9+camera_data_CAM_WIDTH]
	add rcx,rdx

	; Get position in array
	mov rdx,[surface]
	add rdx,32
	mov rdx,[rdx]
	add rdx,rcx

	; Get color
	mov rcx,palette
	imul r8,4
	add rcx,r8
	mov ecx,[rcx]

	; Get multiplier
	xor r10,r10
	mov r10d,[r9+camera_data_CAM_WIDTH]
	imul r10,4

	; Paint surface
	mov dword[rdx+00],ecx
	mov dword[rdx+04],ecx
	mov dword[rdx+08],ecx
	mov dword[rdx+12],ecx
	add rdx,r10
	mov dword[rdx+00],ecx
	mov dword[rdx+04],ecx
	mov dword[rdx+08],ecx
	mov dword[rdx+12],ecx
	add rdx,r10
	mov dword[rdx+00],ecx
	mov dword[rdx+04],ecx
	mov dword[rdx+08],ecx
	mov dword[rdx+12],ecx
	add rdx,r10
	mov dword[rdx+00],ecx
	mov dword[rdx+04],ecx
	mov dword[rdx+08],ecx
	mov dword[rdx+12],ecx

	release
	ret