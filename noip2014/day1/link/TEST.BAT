@echo off
if "%1"=="" goto loop
copy link%1.in link.in >nul
echo Problem Test
echo Data %1
time<nul
link
time<nul
fc link.out link%1.ans
del link.in
del link.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
