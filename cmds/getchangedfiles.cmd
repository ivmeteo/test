rem ��ਯ� �।�����祭 ��� ��娢�஢���� ��� ���������� 䠩��� 㪠������ � ��᪥

echo %1 - ��᪠ 䠫�� ��� ���᪠

ff.exe -a+a-h -s-a %1 >> %temp%\file.list
rsf.exe %temp%\file.list vssver.scc " "
arch %temp%\notarchivated.rar @%temp%\file.list
del %temp%\file.list
