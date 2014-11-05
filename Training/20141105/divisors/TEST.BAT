@echo off
if "%1"=="" goto loop
copy divisors%1.in divisors.in >nul
echo Problem Test
echo Data %1
time<nul
divisors
time<nul
fc divisors.out divisors%1.out
del divisors.in
del divisors.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
