@echo off
if "%1"=="" goto loop
copy speed%1.in speed.in >nul
echo Problem Test
echo Data %1
echo >speed.out
time<nul
speed <speed.in >speed.out
time<nul
fc speed.out speed%1.out
del speed.in
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
