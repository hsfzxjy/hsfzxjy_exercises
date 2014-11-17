@echo off
if "%1"=="" goto loop
copy bird%1.in bird.in >nul
echo Problem Test
echo Data %1
time<nul
bird
time<nul
fc bird.out bird%1.ans
del bird.in
del bird.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 16 17 18 19 20) do call %0 %%i
:end
