@echo off
if "%1"=="" goto loop
copy lignja%1.in lignja.in >nul
echo Problem Test
echo Data %1
time<enter
lignja
time<enter
fc lignja.out lignja%1.out
del lignja.in
del lignja.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
