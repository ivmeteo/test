rem Скрипт предназначен для архивирования всех измененных файлов 

set FolderToStore=d:\arch\!!toCD!!

del %temp%\file.list

ff.exe -a+a-h -s-a d:\_cabs_\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\books\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\canon\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\cmds\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\Data\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\docs\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\examples\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\games\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\Lib\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\Music\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\Pictures\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\Projects\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\Refs\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\Video\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a "d:\Visual Studio Projects\*.*" >> %temp%\file.list 

ff.exe -a+a-h -s-a "c:\Documents and Settings\ivan\Избранное\*.*" >> %temp%\file.list
ff.exe -a+a-h -s-a "c:\Program Files\Far\FarMenu.Ini" >> %temp%\file.list
ff.exe -a+a-h -s-a "c:\Program Files\ICQ\2003a\*.*" >> %temp%\file.list
ff.exe -a+a-h -s-a "c:\Program Files\Borland\Delphi7\Projects\*.*" >> %temp%\file.list

DATESTR.EXE
call DATESTR.BAT
del DATESTR.BAT
arch %FolderToStore%\%FullDateTimeNow%home.rar @%temp%\file.list
arch %FolderToStore%\%FullDateTimeNow%source.rar d:\source\*.*

del %temp%\file.list

