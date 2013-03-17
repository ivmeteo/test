rem Скрипт предназначен для архивирования всех измененных файлов 

set FolderToStore=d:\Temp\!!tohome!!
md %FolderToStore%

ff.exe -a+a-h -s-a d:\cmds\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\Projects\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a C:\Apache2\conf\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\docs\*.* >> %temp%\file.list

del %temp%\FarUserMenu.reg
RegExport HKEY_CURRENT_USER\Software\Far\UserMenu %temp%\FarUserMenu.reg
RegExport HKEY_CURRENT_USER\Software\RAdmin\v2.0 %temp%\RAdminSettings.reg
RegExport HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions %temp%\PuTTYSettings.reg
echo %temp%\FarUserMenu.reg >> %temp%\file.list

rsf.exe %temp%\file.list vssver.scc " "

DATESTR.EXE
call DATESTR.BAT
del DATESTR.BAT
call arch %FolderToStore%\%FullDateTimeNow%work.rar @%temp%\file.list

del %temp%\file.list

