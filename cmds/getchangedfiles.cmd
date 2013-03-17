rem Скрипт предназначен для архивирования всех измененных файлов указанных в маске

echo %1 - маска фалов для поиска

ff.exe -a+a-h -s-a %1 >> %temp%\file.list
rsf.exe %temp%\file.list vssver.scc " "
arch %temp%\notarchivated.rar @%temp%\file.list
del %temp%\file.list
