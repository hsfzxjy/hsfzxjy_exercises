@echo off
if "%1"=="" goto loop
copy age%1.in age.in >nul
echo Problem Test
echo Data %1
time<nul
age
time<nul
fc age.out age%1.out
del age.in
del age.out
pause
goto end
:loop
for %%i in (0 1 2 3 4 5 6 7 8 9 10 11 12) do call %0 %%i
:end
