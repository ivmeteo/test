rem @echo off
rem 
rem Скрипт архивирования
rem

if not .%1 == . goto archivate

echo %%1 - имя архива с расширением
echo %%2 - маска файлов для архивирования
echo %%3 - метод сжатия (0-без сжатия...3-обычный...5-максимальный)
echo %%4 - пароль
pause
goto exit


:archivate
call settings.cmd

if not .%3 == . goto arch_with_metod
set metod=3
goto check_pass

:arch_with_metod
set metod=%3

:check_pass
del %1 
if .%4 == . goto nopassword
rar a -r -p%4 -m%metod% %1 %2
set archresult=%errorlevel%
goto delbak

:nopassword
rem rar a -r -s -v120000k -m%metod% %1 %2
rar a -r -s -m%metod% %1 %2
set archresult=%errorlevel%

:delbak
del *.bak

:exit
echo on
