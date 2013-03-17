set roootfolder=d:
rem Архивирование папок целиком на d:\ диске со сбросом флага Archive
rem %1 - имя папки
rem %2 - метод сжатия (0-без сжатия...3-обычный...5-максимальный)

ff.exe -a+a-h -s-a %roootfolder%\%1\*.* >> %temp%\file.list
del %temp%\file.list
del %1_*.rar
arch %1_%FullDateNow%.rar %roootfolder%\%1\*.* %2
