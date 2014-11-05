@echo off
if "%1"=="" goto loop
copy blast%1.in blast.in >nul
echo Problem Test
echo Data %1
time<enter
blast
time<enter
fc blast.out blast%1.out
del blast.in
del blast.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
