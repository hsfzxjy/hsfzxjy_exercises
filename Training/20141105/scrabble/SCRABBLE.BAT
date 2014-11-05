@echo off
if "%1"=="" goto loop
copy scrabble%1.in scrabble.in >nul
echo Problem Test
echo Data %1
time<enter
scrabble
time<enter
fc scrabble.out scrabble%1.out
del scrabble.in
del scrabble.out
pause
goto end
:loop
for %%i in (1 2 3 4 5) do call %0 %%i
:end
