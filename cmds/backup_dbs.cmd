set user=sysdba
set password=masterkey
set ArchVolume=x:
set Database=infoserver
set ArchFld=%ArchVolume%\%Database%
set DBServer=192.168.8.232

call settings.cmd
cd %ArchVolume%\
md %ArchFld%

net use x: /d
net use x: \\root\arch arch061117 /USER:lcgms\ibxarchivator

DateToStrWin.exe 0
call DateToStrWin.bat
set FullDateNow=%dayofweekeng%
del DateToStrWin.bat

del %ArchFld%\%FullDateNow%.gbk
gbak.exe -B -user %user% -password %password% %DBServer%:d:\data\%Database%.gdb %ArchFld%\%FullDateNow%.gbk

del %ArchFld%\%FullDateNow%_is.rar
call arch %ArchFld%\%FullDateNow%_is.rar d:\data\is\*.*

del %ArchFld%\%FullDateNow%_cmds.rar
call arch %ArchFld%\%FullDateNow%_cmds.rar D:\cmds\*.*

del %ArchFld%\%FullDateNow%_web.rar
call arch %ArchFld%\%FullDateNow%_web.rar C:\Inetpub\*.*

del %ArchFld%\%FullDateNow%_ISC4.*
copy c:\Progra~1\Yaffil\ISC4.* %ArchFld%\%FullDateNow%_ISC4.*

del %ArchFld%\%FullDateNow%_IvUDF.dll
copy c:\Progra~1\Yaffil\UDF\IvUDF.dll %ArchFld%\%FullDateNow%_IvUDF.dll

net use x: /d
