set user=sysdba
set password=masterkey
set path=%path%;c:\Progra~1\Yaffil\BIN
set ArchFld=D:\temp\test
set DBserver=127.0.0.1

del %ArchFld%\textbase.gdk

gbak.exe -B -user %user% -password %password% %DBserver%:d:\data\textbase.gdb %ArchFld%\textbase.gbk

gbak.exe -R -p16384 -user %user% -password %password% %ArchFld%\textbase.gbk %DBserver%:d:\data\textbase.gdb
