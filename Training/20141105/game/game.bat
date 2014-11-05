@echo off
if "%1"=="" goto loop
copy game%1.in game.in >nul
echo Problem Test
echo Data %1
time<enter
game
time<enter
copy game%1.out game.std
gametest
del game.in
del game.out
del game.std
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
