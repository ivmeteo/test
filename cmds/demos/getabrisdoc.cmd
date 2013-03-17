@echo off
rem if .%1 == . %0 -

e:
cd e:\Docs\ExclusivePerm\Jdanov\

set PATH=\\Storage\AviaSoft\SourSafe\Win32;%PATH%
set SSDIR=\\Storage\AviaSoft\SourSafe
rem set SSUSER=gnilovskoy
rem set SSPWD=xxxxx

set PRJROOT=$/Abris

ss checkin "%PRJROOT%/doc/user/Руководство по экcплуатации АБРИС(книга1).doc" -c- -o-
if errorlevel 1 goto finish
ss checkin "%PRJROOT%/doc/user/Руководство по эксплуатации АБРИС(книга2).doc" -c- -o-
if errorlevel 1 goto finish

ss checkout "%PRJROOT%/doc/user/Руководство по экcплуатации АБРИС(книга1).doc" -o-
if errorlevel 1 goto finish
ss checkout "%PRJROOT%/doc/user/Руководство по эксплуатации АБРИС(книга2).doc" -o-
if errorlevel 1 goto finish

echo OK
:finish