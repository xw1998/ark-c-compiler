@echo off
cd /d "d:\工作\git_project\ark c compiler"
set SRC=src
set BE=%SRC%\backend
set OUT=bootstrap_x86
set FLAGS=-target x86_64 -S -I include

echo Regenerating all .x86.s files...

arkcc.exe %FLAGS% %SRC%\ast.c -o %OUT%\ast.x86.s
if errorlevel 1 echo FAILED: ast && exit /b 1

arkcc.exe %FLAGS% %BE%\arm\backend_arm.c -o %OUT%\backend_arm.x86.s
if errorlevel 1 echo FAILED: backend_arm && exit /b 1

arkcc.exe %FLAGS% %BE%\c\backend_c.c -o %OUT%\backend_c.x86.s
if errorlevel 1 echo FAILED: backend_c && exit /b 1

arkcc.exe %FLAGS% %BE%\riscv32\backend_riscv32.c -o %OUT%\backend_riscv32.x86.s
if errorlevel 1 echo FAILED: backend_riscv32 && exit /b 1

arkcc.exe %FLAGS% %BE%\x86_64\backend_x86_64.c -o %OUT%\backend_x86_64.x86.s
if errorlevel 1 echo FAILED: backend_x86_64 && exit /b 1

arkcc.exe %FLAGS% %SRC%\codegen_common.c -o %OUT%\codegen_common.x86.s
if errorlevel 1 echo FAILED: codegen_common && exit /b 1

arkcc.exe %FLAGS% %SRC%\compiler.c -o %OUT%\compiler.x86.s
if errorlevel 1 echo FAILED: compiler && exit /b 1

arkcc.exe %FLAGS% %SRC%\config.c -o %OUT%\config.x86.s
if errorlevel 1 echo FAILED: config && exit /b 1

arkcc.exe %FLAGS% %SRC%\cpu.c -o %OUT%\cpu.x86.s
if errorlevel 1 echo FAILED: cpu && exit /b 1

arkcc.exe %FLAGS% %SRC%\ir.c -o %OUT%\ir.x86.s
if errorlevel 1 echo FAILED: ir && exit /b 1

arkcc.exe %FLAGS% %SRC%\irgen.c -o %OUT%\irgen.x86.s
if errorlevel 1 echo FAILED: irgen && exit /b 1

arkcc.exe %FLAGS% %SRC%\lexer.c -o %OUT%\lexer.x86.s
if errorlevel 1 echo FAILED: lexer && exit /b 1

arkcc.exe %FLAGS% -Dmain=arkcc_real_main %SRC%\main.c -o %OUT%\main.x86.s
if errorlevel 1 echo FAILED: main && exit /b 1

arkcc.exe %FLAGS% %SRC%\memory.c -o %OUT%\memory.x86.s
if errorlevel 1 echo FAILED: memory && exit /b 1

arkcc.exe %FLAGS% %SRC%\opt.c -o %OUT%\opt.x86.s
if errorlevel 1 echo FAILED: opt && exit /b 1

arkcc.exe %FLAGS% %SRC%\parser.c -o %OUT%\parser.x86.s
if errorlevel 1 echo FAILED: parser && exit /b 1

arkcc.exe %FLAGS% %SRC%\preproc.c -o %OUT%\preproc.x86.s
if errorlevel 1 echo FAILED: preproc && exit /b 1

arkcc.exe %FLAGS% %BE%\registry.c -o %OUT%\registry.x86.s
if errorlevel 1 echo FAILED: registry && exit /b 1

arkcc.exe %FLAGS% %SRC%\scatter.c -o %OUT%\scatter.x86.s
if errorlevel 1 echo FAILED: scatter && exit /b 1

arkcc.exe %FLAGS% %SRC%\sema.c -o %OUT%\sema.x86.s
if errorlevel 1 echo FAILED: sema && exit /b 1

arkcc.exe %FLAGS% %SRC%\symtab.c -o %OUT%\symtab.x86.s
if errorlevel 1 echo FAILED: symtab && exit /b 1

arkcc.exe %FLAGS% %SRC%\type.c -o %OUT%\type.x86.s
if errorlevel 1 echo FAILED: type && exit /b 1

arkcc.exe %FLAGS% port\host\flash_fs_host.c -o %OUT%\flash_fs_host.x86.s
if errorlevel 1 echo FAILED: flash_fs_host && exit /b 1

arkcc.exe %FLAGS% port\host\platform_host.c -o %OUT%\platform_host.x86.s
if errorlevel 1 echo FAILED: platform_host && exit /b 1

echo All .x86.s files regenerated.
