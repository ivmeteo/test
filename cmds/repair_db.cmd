echo %1 - database file name
echo %2 - sweep interval

set sweep=%2
if .%sweep%==. set sweep=20000

set user=sysdba
set password=masterkey
set path=%path%;c:\Progra~1\Yaffil\BIN
set DatabaseFolder=d:\data
set DatabaseFile=%1

del %DatabaseFolder%\%DatabaseFile%.gdk

net stop yaffilsqlserver(ss)
net stop yaffilsqlserver(cs)

del %DatabaseFolder%\%DatabaseFile%.old
ren %DatabaseFolder%\%DatabaseFile%.gdb %DatabaseFile%.old

net start yaffilsqlserver(ss)
net start yaffilsqlserver(cs)

gbak.exe -B -user %user% -password %password% %DatabaseFolder%\%DatabaseFile%.old %DatabaseFolder%\%DatabaseFile%.gbk
gbak.exe -R -P 16384 -user %user% -password %password% %DatabaseFolder%\%DatabaseFile%.gbk %DatabaseFolder%\%DatabaseFile%.gdb
gfix.exe -h %sweep% -user %user% -password %password% %DatabaseFolder%\%DatabaseFile%.gdb