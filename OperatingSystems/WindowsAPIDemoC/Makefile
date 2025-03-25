CC = x86_64-w64-mingw32-gcc
CFLAGS = -Wall -I"/mingw64/include" -I"/usr/include"
LDFLAGS = -L"/mingw64/lib" -lkernel32 -lgdi32 -luser32

SRC = main.c
OUT = program.exe

all:

	@$(CC) $(SRC) $(CFLAGS) -o $(OUT)
clean:
	@rm *.exe
