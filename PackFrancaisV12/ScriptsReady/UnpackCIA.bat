#!/bin/bash +H
clear
echo
set CiaName=%~n1
set CiaExt=%~x1
set CiaFull=%CiaName%%CiaExt%
clear
echo
echo Veuillez patienter, extraction de "%CiaFull%" en cours...
echo
md %1_Unpacked > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\ctrtool.exe" --content=%1_Unpacked/DecryptedApp %1 > /dev/null 2>&1
mv %1_Unpacked\DecryptedApp.0000.* DecryptedPartition0.bin > /dev/null 2>&1
mv %1_Unpacked\DecryptedApp.0001.* DecryptedPartition1.bin > /dev/null 2>&1
mv %1_Unpacked\DecryptedApp.0002.* DecryptedPartition2.bin > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cxi %1_Unpacked/DecryptedPartition0.bin --header %1_Unpacked/HeaderNCCH0.bin --exh %1_Unpacked/DecryptedExHeader.bin --exh-auto-key --exefs %1_Unpacked/DecryptedExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs %1_Unpacked/DecryptedRomFS.bin --romfs-auto-key --logo %1_Unpacked/LogoLZ.bin --plain %1_Unpacked/PlainRGN.bin > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa %1_Unpacked/DecryptedPartition1.bin --header %1_Unpacked/HeaderNCCH1.bin --romfs %1_Unpacked/DecryptedManual.bin --romfs-auto-key > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa %1_Unpacked/DecryptedPartition2.bin --header %1_Unpacked/HeaderNCCH2.bin --romfs %1_Unpacked/DecryptedDownloadPlay.bin --romfs-auto-key > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa %1_Unpacked/DecryptedPartition6.bin --header %1_Unpacked/HeaderNCCH6.bin --romfs %1_Unpacked/DecryptedN3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf cfa %1_Unpacked/DecryptedPartition7.bin --header %1_Unpacked/HeaderNCCH7.bin --romfs %1_Unpacked/DecryptedO3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
del %1_Unpacked\DecryptedPartition0.bin > /dev/null 2>&1
del %1_Unpacked\DecryptedPartition1.bin > /dev/null 2>&1
del %1_Unpacked\DecryptedPartition2.bin > /dev/null 2>&1
del %1_Unpacked\DecryptedPartition6.bin > /dev/null 2>&1
del %1_Unpacked\DecryptedPartition7.bin > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtfu exefs %1_Unpacked/DecryptedExeFS.bin --header %1_Unpacked/HeaderExeFS.bin --exefs-dir %1_Unpacked/ExtractedExeFS > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs %1_Unpacked/DecryptedRomFS.bin --romfs-dir %1_Unpacked/ExtractedRomFS > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs %1_Unpacked/DecryptedManual.bin --romfs-dir %1_Unpacked/ExtractedManual > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs %1_Unpacked/DecryptedDownloadPlay.bin --romfs-dir %1_Unpacked/ExtractedDownloadPlay > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs %1_Unpacked/DecryptedN3DSUpdate.bin --romfs-dir %1_Unpacked/ExtractedN3DSUpdate > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xvtf romfs %1_Unpacked/DecryptedO3DSUpdate.bin --romfs-dir %1_Unpacked/ExtractedO3DSUpdate > /dev/null 2>&1
mv %1_Unpacked\ExtractedExeFS\banner.bnr banner.bin > /dev/null 2>&1
mv %1_Unpacked\ExtractedExeFS\icon.icn icon.bin > /dev/null 2>&1
copy %1_Unpacked\ExtractedExeFS\banner.bin %1_Unpacked/banner.bin > /dev/null 2>&1
"%PROGRAMFILES%\HackingToolkit9DS\3dstool.exe" -xv -t banner -f %1_Unpacked\banner.bin --banner-dir %1_Unpacked\ExtractedBanner\ > /dev/null 2>&1
del %1_Unpacked\banner.bin > /dev/null 2>&1
mv %1_Unpacked\ExtractedBanner\banner0.bcmdl banner.cgfx > /dev/null 2>&1