set listfile=%temp%\file.list
del %listfile%

del DateToStrWin.bat 
DateToStrWin.exe 0
call DateToStrWin.bat 

ff.exe -a+a-h -s-a g:\meteo\g%year%\m%month\d%day%\kh01*.dat > %listfile%
ff.exe -a+a-h -s-a 1\*.cmd >> %listfile%
call filesize.cmd %listfile%

rem echo %errorlevel%
if %errorlevel%==0 goto nochanges

echo changes avail

:nochanges
