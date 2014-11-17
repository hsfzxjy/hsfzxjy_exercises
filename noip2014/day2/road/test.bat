@echo off
if "%1"=="" goto loop
copy road%1.in road.in >nul
echo Problem Test
echo Data %1
time<nul
road_
time<nul
fc road.out road%1.ans
del road.in
del road.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
