#!/bin/bash +H
clear
echo
set CiaName=%~n1
set CiaExt=.cia
set CiaFull=%CiaName%%CiaExt%
echo Please wait, rebuild of "%CiaFull%" in progress...
echo
# %CiaFull%_Unpacked\ExtractedBanner\banner.cgfx banner0.bcmdl > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cv -t banner -f %CiaFull%_Unpacked\banner.bin --banner-dir %CiaFull%_Unpacked/ExtractedBanner\ > /dev/null 2>&1
# %CiaFull%_Unpacked\ExtractedBanner\banner0.bcmdl banner.cgfx > /dev/null 2>&1
move /Y %CiaFull%_Unpacked\banner.bin %CiaFull%_Unpacked\ExtractedExeFS\banner.bin > /dev/null 2>&1
# %CiaFull%_Unpacked\ExtractedExeFS\banner.bin banner.bnr > /dev/null 2>&1
# %CiaFull%_Unpacked\ExtractedExeFS\icon.bin icon.icn > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtfz exefs %CiaFull%_Unpacked/CustomExeFS.bin --header %CiaFull%_Unpacked\HeaderExeFS.bin --exefs-dir %CiaFull%_Unpacked\ExtractedExeFS > /dev/null 2>&1
# %CiaFull%_Unpacked\ExtractedExeFS\banner.bnr banner.bin > /dev/null 2>&1
# %CiaFull%_Unpacked\ExtractedExeFS\icon.icn icon.bin > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf romfs %CiaFull%_Unpacked/CustomRomFS.bin --romfs-dir %CiaFull%_Unpacked/ExtractedRomFS > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf romfs %CiaFull%_Unpacked/CustomManual.bin --romfs-dir %CiaFull%_Unpacked/ExtractedManual > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf romfs %CiaFull%_Unpacked/CustomDownloadPlay.bin --romfs-dir %CiaFull%_Unpacked/ExtractedDownloadPlay > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf cxi %CiaFull%_Unpacked/CustomPartition0.bin --header %CiaFull%_Unpacked\HeaderNCCH0.bin --exh %CiaFull%_Unpacked\DecryptedExHeader.bin --exh-auto-key --exefs %CiaFull%_Unpacked\CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs %CiaFull%_Unpacked\CustomRomFS.bin --romfs-auto-key --logo %CiaFull%_Unpacked\LogoLZ.bin --plain %CiaFull%_Unpacked\PlainRGN.bin > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf cfa %CiaFull%_Unpacked/CustomPartition1.bin --header %CiaFull%_Unpacked\HeaderNCCH1.bin --romfs %CiaFull%_Unpacked\CustomManual.bin --romfs-auto-key > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -cvtf cfa %CiaFull%_Unpacked/CustomPartition2.bin --header %CiaFull%_Unpacked\HeaderNCCH2.bin --romfs %CiaFull%_Unpacked\CustomDownloadPlay.bin --romfs-auto-key > /dev/null 2>&1
for %%j in (%CiaFull%_Unpacked\Custom*.bin) do if %%~zj LEQ 20000 del %%j > /dev/null 2>&1
if exist %CiaFull%_Unpacked\CustomPartition0.bin (SET ARG0=-content %CiaFull%_Unpacked\CustomPartition0.bin:0:0x00) > /dev/null 2>&1
if exist %CiaFull%_Unpacked\CustomPartition1.bin (SET ARG1=-content %CiaFull%_Unpacked\CustomPartition1.bin:1:0x01) > /dev/null 2>&1
if exist %CiaFull%_Unpacked\CustomPartition2.bin (SET ARG2=-content %CiaFull%_Unpacked\CustomPartition2.bin:2:0x02) > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\makerom.exe" -target p -ignoresign -f cia %ARG0% %ARG1% %ARG2% -o %CiaName%_Edited.cia > /dev/null 2>&1