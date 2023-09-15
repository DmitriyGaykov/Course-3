echo off
cls
echo --File name:     %~n0
echo --File created:  %~t0
echo --File size:     %~z0 bytes
echo --File path:     %~dpnx0 
:: or type %~f0 for full file name
pause