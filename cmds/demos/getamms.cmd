@echo off

rem
rem Скрипт изъятия и сборки последней версии Абриса
rem
rem %1 - конечная папка SourceSafe (base или amms)
rem %2 - наименование версии вида productnb.ReleaseNb.buildnum (10.1.12)


if .%1 == . goto exitwithnothing


rem Устанавливаю переменные ..................

:settings
call settings.cmd


echo Подготовлю папку ........................

md %GetAbrisDir%\%1
md %GetAbrisDir%\%1\Version
cd %GetAbrisDir%\%1


echo Проверю версию ..........................

if not .%2 == . goto OldVersion
cd Version
ss get %AmmsPRJROOT%/%1/Version/Version.inc -r -o- -gws -i-
cd ..
CRCChecker.exe %CRCini% ..\%1\Version\Version.inc
if %errorlevel% == 0 goto projectexists



echo Беру новую версию целеком и собираю .....

ss get %AmmsPRJROOT%/%1 -r -o- -gws -i-
goto NextPrep


:OldVersion

echo Беру указанную версию целеком и собираю .
ss get %AmmsPRJROOT%/%1 -r -o- -gws -i- "-vlBuild %2"


:NextPrep

md %GetAbrisDir%\%1\obj.rru
md %GetAbrisDir%\%1\obj.ren 
md %GetAbrisDir%\%1\obj.dru
md %GetAbrisDir%\%1\obj.den
copy %Lib4GWPRO%\*.* 


echo Подготавливаю хранилище ....

datestr.exe
defstr.exe %GetAbrisDir%\%1\version\version.inc 
call datestr.bat
call defstr.bat
md %putdir%\%productnb%\%ReleaseNb%\%buildnum%


echo Собираю версии ....

wmake -f cdu.mk RELEASE#1 RUS#1 
if not %errorlevel% == 0 goto error
ren cdu.exe rus.*
copy %GetAbrisDir%\%1\rus.exe %putdir%\%productnb%\%ReleaseNb%\%buildnum%

wmake -f cdu.mk RELEASE#1 ENG#1 
if not %errorlevel% == 0 goto error
ren cdu.exe eng.*
copy %GetAbrisDir%\%1\eng.exe %putdir%\%productnb%\%ReleaseNb%\%buildnum%

wmake -f cdu.mk DEBUG#1 RUS#1 
if not %errorlevel% == 0 goto error
ren cdu.exe rus_deb.*
copy %GetAbrisDir%\%1\rus_deb.exe %putdir%\%productnb%\%ReleaseNb%\%buildnum%

wmake -f cdu.mk DEBUG#1 ENG#1 
if not %errorlevel% == 0 goto error
ren cdu.exe eng_deb.*
copy %GetAbrisDir%\%1\eng_deb.exe %putdir%\%productnb%\%ReleaseNb%\%buildnum%

copy %putdir%\%productnb%\%ReleaseNb%\%buildnum%\*.* \\aviation\d$\CduInst\Exe.lib\__LAST__.CDU\%1

rem del /q /s %GetAbrisDir%\%1\*.obj
rem del /q /s %GetAbrisDir%\%1\*.odl
rem del /q /s %GetAbrisDir%\%1\*.oda
rem del /q /s %GetAbrisDir%\%1\*.ln
rem del /q /s %GetAbrisDir%\%1\*.exe


echo Архивирую исходники .....................

call arch src.rar *.* "Build %productnb%.%ReleaseNb%.%buildnum%"
rar d -p"Build %productnb%.%ReleaseNb%.%buildnum%" src.rar *.obj *.odl *.oda *.ln *.exe
copy src.rar %putdir%\%productnb%\%ReleaseNb%\%buildnum%
del src.rar


echo Посылаю рапорт об успешном окончании сборки на компьютер %senderrorto%

call sendreport.cmd "Automatic compilation of Abris %productnb%.%ReleaseNb%.%buildnum% done!"


echo OK
goto finish


:projectexists
echo Версия уже собиралась!
goto finish


:error
echo Ошибка сборки Абриса
call sendreport.cmd "Error during automatic compilation of Abris %productnb%.%ReleaseNb%.%buildnum% !"

echo Удаляю исходники ........................

:finish
rem call clear_ro.cmd %GetAbrisDir%\%1\*.*
rem del /q /s %GetAbrisDir%\%1\*.*

:exitwithnothing
cd ..