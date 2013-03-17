DateToStrWin.exe 0
call DateToStrWin.bat
echo %dayofweekrus% %day%.%month%.%year% %hour%:%minute%:%second% >> c:\bootlog.txt
del DateToStrWin.bat
