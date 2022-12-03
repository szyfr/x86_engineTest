
DATE:=$(shell cmd /C date /T)
DIR:=\target\debug\$(DATE)
OBJ:=target\debug\$(DATE)\gnostic.obj
SRC:=src\Old\main.asm
OUT:=target\debug\$(DATE)\Gnosticism.exe




gnosticism: $(OUT)


$(OUT): $(OBJ)
	GoLink /console /ENTRY:main $(OBJ) kernel32.dll user32.dll gdi32.dll ucrtbase.dll

$(OBJ): $(SRC)
	echo "#define BUILD_TIMESTAMP \"`cmd /c date /t` `cmd /c time /t`\""
	mkdir $(DIR)
	nasm -fwin64 $(SRC) -o $(OBJ)

