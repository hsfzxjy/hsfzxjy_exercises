@echo off
if "%1"=="" goto loop
copy wireless%1.in wireless.in >nul
echo Problem Test
echo Data %1
time<nul
wireless
time<nul
fc wireless.out wireless%1.ans
del wireless.in
del wireless.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
