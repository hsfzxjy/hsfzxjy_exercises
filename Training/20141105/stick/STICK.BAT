@echo off
if "%1"=="" goto loop
copy stick%1.in stick.in >nul
echo Problem Test
echo Data %1
time<enter
stick
time<enter
fc stick.out stick%1.out
del stick.in
del stick.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
