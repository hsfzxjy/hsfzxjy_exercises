@echo off
if "%1"=="" goto loop
copy servers%1.in servers.in >nul
echo Problem Test
echo Data %1
time<nul
servers
time<nul
fc servers.out servers%1.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9) do call %0 %%i
:end
