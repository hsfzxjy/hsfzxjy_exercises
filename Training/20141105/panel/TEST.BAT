@echo off
if "%1"=="" goto loop
copy panel%1.in panel.in >nul
echo Problem Test
echo Data %1
panel>panel.out
fc panel.out panel%1.out
del panel.in
del panel.out
pause
goto end
:loop
for %%i in (1 2 3 4 5) do call %0 %%i
:end
