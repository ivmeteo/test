@echo off

echo �� �ணࠬ�� 㤠��� �� ����祭�� � ��।���� 䠪��
echo   �᫨ ��� �த������ ������ ���� ������� 
echo   ���� ���ன� �� ����
pause


c:
cd "C:\Program Files\WinFax\Data" 
DATESTR.EXE 
call DATESTR.BAT 
md D:\archives\winfax\%FullDateTimeNow%
copy *.fx* D:\archives\winfax\%FullDateTimeNow%
copy Status*.* D:\archives\winfax\%FullDateTimeNow%
del *.fx*
del Status*.*
del *.tmp