@echo off
cls
echo --File name:     %~n0
echo --File created:  
for /f "tokens=1,2" %%a in ('dir Z03-02.bat /a-d /o-d /T:C') do @echo %%a %%b | find ":"
echo --File path:     %~dpnx0 
:: or type %~f0 for full file name
pause
