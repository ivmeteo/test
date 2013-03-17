@echo off
rem -----------------------------------------------------------------------
echo устанавливаю переменные
rem -----------------------------------------------------------------------
set SSUSER=Ivan

set PATH=d:\source\win32;%PATH%
set SSDIR=d:\source
set RootWorkingFolder=d:\projects\

 
rem -----------------------------------------------------------------------
echo определяю папку SourceSafe
rem -----------------------------------------------------------------------
cd > %temp%\cur_folder.cmd
rsf %temp%\cur_folder.cmd %RootWorkingFolder% "set PRJROOT=$/" \ /
rem rsf %temp%\cur_folder.cmd \ /
call %temp%\cur_folder.cmd
del %temp%\cur_folder.cmd

rem -----------------------------------------------------------------------
echo беру весь проект
rem -----------------------------------------------------------------------
ss checkin "%PRJROOT%" -o-
rem if errorlevel 1 goto error

:error
echo error=%errorlevel%

:finish
echo on