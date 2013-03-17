rem Скрипт предназначен для архивирования всех измененных файлов 

set FolderToStore=d:\Temp\!!towork!!
md %FolderToStore%

ff.exe -a+a-h -s-a d:\cmds\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\Projects\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a C:\Inetpub\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a C:\shttps\www\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\source\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\refs\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\examples\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\docs\*.* >> %temp%\file.list
ff.exe -a+a-h -s-a d:\data\imagebase3.gdb >> %temp%\file.list

del %temp%\FarUserMenu.reg
RegExport HKEY_CURRENT_USER\Software\Far\UserMenu %temp%\FarUserMenu.reg
echo %temp%\FarUserMenu.reg >> %temp%\file.list

rsf.exe %temp%\file.list vssver.scc " "

DATESTR.EXE
call DATESTR.BAT
del DATESTR.BAT
arch %FolderToStore%\%FullDateTimeNow%home.rar @%temp%\file.list

del %temp%\file.list

