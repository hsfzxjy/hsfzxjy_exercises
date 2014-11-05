@echo off
if "%1"=="" goto loop
copy scan%1.in scan.in >nul
echo Problem Test
echo Data %1
time<enter
scan
time<enter
fc scan.out scan%1.out
del scan.in
del scan.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 0 11) do call %0 %%i
:end
