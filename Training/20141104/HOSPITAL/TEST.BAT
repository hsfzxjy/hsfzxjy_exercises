@echo off
if "%1"=="" goto loop
copy hospita%1.in hospital.in >nul
echo Problem Test
echo Data %1
time<nul
hospital
time<nul
fc hospital.out hospita%1.out
del hospital.in
del hospital.out
pause
goto end
:loop
for %%i in (1 2 3 4 5) do call %0 %%i
:end
