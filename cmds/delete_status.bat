@echo off

echo Эта программа удаляет все полученные и переданные факсы
echo   если хотите продолжить нажмите любую клавишу 
echo   иначе закройте это окно
pause


c:
cd "C:\Program Files\WinFax\Data" 
DATESTR.EXE 
call DATESTR.BAT 
md D:\archives\winfax\%FullDateTimeNow%
copy *.fx* D:\archives\winfax\%FullDateTimeNow%
copy Status*.* D:\archives\winfax\%FullDateTimeNow%
del *.fx*
del Status*.*
del *.tmp