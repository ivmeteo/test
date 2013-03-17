@echo off
rem -----------------------------------------------------------------------
echo устанавливаю переменные
rem -----------------------------------------------------------------------
set SSUSER=Ivan

set BuildConstName=BuildNumber

set PATH=d:\source\win32;%PATH%
set SSDIR=d:\source
set RootWorkingFolder=d:\projects\

set pasver=VersionConsts.pas
set cppver=defs.h
set BuildUnitName=.
if exist %pasver% set BuildUnitName=%pasver%
if exist %cppver% set BuildUnitName=%cppver%

if not %BuildUnitName%==. goto cont
echo BuildUnitFile not exists
goto finish
 
:cont
rem -----------------------------------------------------------------------
echo определяю папку SourceSafe
rem -----------------------------------------------------------------------
cd > %temp%\cur_folder.cmd
rsf %temp%\cur_folder.cmd %RootWorkingFolder% "set PRJROOT=$/" \ /
rem rsf %temp%\cur_folder.cmd \ /
call %temp%\cur_folder.cmd
del %temp%\cur_folder.cmd

rem -----------------------------------------------------------------------
echo беру файл %BuildUnitName% из SourceSafe, изменяю и кладу назад
rem -----------------------------------------------------------------------
ss checkout "%PRJROOT%/%BuildUnitName%" -o-
rem if errorlevel 1 goto error

IncConst %BuildUnitName% %BuildConstName%
call IncConst.cmd
del IncConst.cmd

ss checkin "%PRJROOT%" -c- -o-
if errorlevel 1 goto error

rem -----------------------------------------------------------------------
echo устанавливаю метку на проект
rem -----------------------------------------------------------------------
set Label=Build %BuildNumber%
ss label %PRJROOT% "-l%Label%" -V -I-
if errorlevel 1 goto error

set Label=Version %VersionNumber%.%ReleaseNumber%
ss history %PRJROOT% -l > %temp%\history.txt
find "%Label%" %temp%\history.txt
if not errorlevel = 1 goto continue
ss label %PRJROOT% "-l%Label%" -V -I-

rem -----------------------------------------------------------------------
echo беру весь проект
rem -----------------------------------------------------------------------
:continue
rem ss checkout "%PRJROOT%" -o-
goto finish

:error
echo error=%errorlevel%

:finish
del %temp%\history.txt
echo on