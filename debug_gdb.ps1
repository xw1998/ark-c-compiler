gdb -batch -ex "run" -ex "bt 30" -ex "info registers" -ex "x/4i `$pc" -ex "quit" .\c99_armcc5.gen.exe 2>&1 | Select-Object -Last 80
