@echo off
if "%1"=="" goto loop
copy words%1.in words.in >nul
echo Problem Test
echo Data %1
time<enter
words
time<enter
fc words.out words%1.out
del words.in
del words.out
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
