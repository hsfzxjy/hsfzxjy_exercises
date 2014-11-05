@echo off
if "%1"=="" goto loop
copy Pasture%1.in Pasture.in >nul
echo Problem Test
echo Data %1
time<enter
Pasture
time<enter
fc Pasture.out Pasture%1.out
del Pasture.in
del Pasture.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10 11) do call %0 %%i
:end
