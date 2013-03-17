set FlashDiskPath=h:\

call arch archive.rar *.*
copy archive.rar %FlashDiskPath%
del archive.rar
DATESTR.EXE 
call DATESTR.BAT
del DATESTR.BAT
ren %FlashDiskPath%archive.rar %FullDateNow%.rar
