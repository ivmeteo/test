set roootfolder=d:
rem ��娢�஢���� ����� 楫���� �� d:\ ��᪥ � ��ᮬ 䫠�� Archive
rem %1 - ��� �����
rem %2 - ��⮤ ᦠ�� (0-��� ᦠ��...3-�����...5-���ᨬ����)

ff.exe -a+a-h -s-a %roootfolder%\%1\*.* >> %temp%\file.list
del %temp%\file.list
del %1_*.rar
arch %1_%FullDateNow%.rar %roootfolder%\%1\*.* %2
