@echo off
if "%1"=="" goto loop
copy dom%1.in dom.in >nul
echo Problem Test
echo Data %1
time<enter
dom
time<enter
fc dom.out dom%1.out
del dom.in
del dom.out
pause
goto end
:loop
for %%i in (0 1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
