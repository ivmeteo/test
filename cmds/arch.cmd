rem @echo off
rem 
rem ��ਯ� ��娢�஢����
rem

if not .%1 == . goto archivate

echo %%1 - ��� ��娢� � ���७���
echo %%2 - ��᪠ 䠩��� ��� ��娢�஢����
echo %%3 - ��⮤ ᦠ�� (0-��� ᦠ��...3-�����...5-���ᨬ����)
echo %%4 - ��஫�
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
