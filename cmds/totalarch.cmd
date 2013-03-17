d:
cd d:\arch
DATESTR.EXE
call DATESTR.BAT
del DATESTR.BAT
call archb source
call archb Projects
rem call archb favorites
call archb cmds
call archb docs
rem call archb mail
call archb refs
call archb examples
call archb Pictures 0
call archb Data 
call archb Canon 0
rem call archb "Mobile Phone Manager"

del %temp%\file.list
arch imports_%FullDateNow%.rar "c:\Program Files\Borland\Delphi7\Imports\*.*"
arch Inetpub_%FullDateNow%.rar C:\Inetpub\*.*
del FarUserMenu.reg
RegExport HKEY_CURRENT_USER\Software\Far\UserMenu FarUserMenu.reg
del WinRoute.reg
RegExport HKEY_LOCAL_MACHINE\Software\TinySoftware\WinRoute WinRoute.reg

WinShutdowner.exe 
