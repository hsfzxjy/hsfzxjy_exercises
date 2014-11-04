@echo off
if "%1"=="" goto loop
copy machine%1.in machine.in >nul
echo Problem Test
echo Data %1
time<nul
machine
time<nul
fc machine.out machine%1.out
pause
del machine.in
del machine.out
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
