echo %1 - bitrate (128, 320 ...)
echo %2 - waw file name

d:\Music\_EAC\lame\lame.exe -b32 -B%1 -v -h "--alt-preset extreme" %2
