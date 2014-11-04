@echo off
if "%1"=="" goto loop
copy work%1.in work.in >nul
echo Problem Test
echo Data %1
time<nul
work
time<nul
check
del work.in
pause
goto end
:loop
for %%i in (0 1 2 3 4 5 6 7 8 9) do call %0 %%i
:end
