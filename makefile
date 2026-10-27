.SUFFIXES:

!INCLUDE tools\nmake\setup.mak

all: bin\tribo-cli.exe
	@echo Built $@: $**

bin\tribo-cli.exe: src\cli\*.c
	if not exist "tmp\src\cli" mkdir "tmp\src\cli"
	$(CC) /c $(CFLAGS) $? /Fo"tmp\src\cli\\" /Fa"tmp\src\cli\\"
	if not exist "$(@D)" mkdir "$(@D)"
	$(CC) $(LDFLAGS) $(patsubst %.c, tmp/%.obj, $**) /link $(LINKFLAGS) /PDB:$(@R).pdb /OUT:$@

clean:
	if exist "bin" rmdir /s /q "bin"
	if exist "tmp" rmdir /s /q "tmp"

rebuild: clean
	$(MAKE) $(MAKEFLAGS)
