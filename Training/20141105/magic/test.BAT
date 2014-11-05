@echo off
if "%1"=="" goto loop
copy magic%1.in magic.in >nul
echo Problem Test
echo Data %1
time<enter
magic
time<enter
fc magic.out magic%1.out
del magic.in
del magic.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
