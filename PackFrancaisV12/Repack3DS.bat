#!/bin/bash +H
clear
echo
set CciName=%~n1
set CciExt=.3ds
set CciFull=%CciName%%CciExt%
echo Veuillez patienter, compilation de "%CciFull%" en cours...
echo
mv %CciFull%_Unpacked\ExtractedBanner\banner.cgfx banner0.bcmdl > /dev/null 2>&1
"3dstool.exe" -cv -t banner -f %CciFull%_Unpacked\banner.bin --banner-dir %CciFull%_Unpacked/ExtractedBanner\ > /dev/null 2>&1
mv %CciFull%_Unpacked\ExtractedBanner\banner0.bcmdl banner.cgfx > /dev/null 2>&1
move /Y %CciFull%_Unpacked\banner.bin %CciFull%_Unpacked\ExtractedExeFS\banner.bin > /dev/null 2>&1
mv %CciFull%_Unpacked\ExtractedExeFS\banner.bin banner.bnr > /dev/null 2>&1
mv %CciFull%_Unpacked\ExtractedExeFS\icon.bin icon.icn > /dev/null 2>&1
"3dstool.exe" -cvtfz exefs %CciFull%_Unpacked/CustomExeFS.bin --header %CciFull%_Unpacked\HeaderExeFS.bin --exefs-dir %CciFull%_Unpacked\ExtractedExeFS > /dev/null 2>&1
mv %CciFull%_Unpacked\ExtractedExeFS\banner.bnr banner.bin > /dev/null 2>&1
mv %CciFull%_Unpacked\ExtractedExeFS\icon.icn icon.bin > /dev/null 2>&1
"3dstool.exe" -cvtf romfs %CciFull%_Unpacked/CustomRomFS.bin --romfs-dir %CciFull%_Unpacked/ExtractedRomFS > /dev/null 2>&1
"3dstool.exe" -cvtf romfs %CciFull%_Unpacked/CustomManual.bin --romfs-dir %CciFull%_Unpacked/ExtractedManual > /dev/null 2>&1
"3dstool.exe" -cvtf romfs %CciFull%_Unpacked/CustomDownloadPlay.bin --romfs-dir %CciFull%_Unpacked/ExtractedDownloadPlay > /dev/null 2>&1
"3dstool.exe" -cvtf romfs %CciFull%_Unpacked/CustomN3DSUpdate.bin --romfs-dir %CciFull%_Unpacked/ExtractedN3DSUpdate > /dev/null 2>&1
"3dstool.exe" -cvtf romfs %CciFull%_Unpacked/CustomO3DSUpdate.bin --romfs-dir %CciFull%_Unpacked/ExtractedO3DSUpdate > /dev/null 2>&1
"3dstool.exe" -cvtf cxi %CciFull%_Unpacked/CustomPartition0.bin --header %CciFull%_Unpacked\HeaderNCCH0.bin --exh %CciFull%_Unpacked\DecryptedExHeader.bin --exh-auto-key --exefs %CciFull%_Unpacked\CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs %CciFull%_Unpacked\CustomRomFS.bin --romfs-auto-key --logo %CciFull%_Unpacked\LogoLZ.bin --plain %CciFull%_Unpacked\PlainRGN.bin > /dev/null 2>&1
"3dstool.exe" -cvtf cfa %CciFull%_Unpacked/CustomPartition1.bin --header %CciFull%_Unpacked\HeaderNCCH1.bin --romfs %CciFull%_Unpacked\CustomManual.bin --romfs-auto-key > /dev/null 2>&1
"3dstool.exe" -cvtf cfa %CciFull%_Unpacked/CustomPartition2.bin --header %CciFull%_Unpacked\HeaderNCCH2.bin --romfs %CciFull%_Unpacked\CustomDownloadPlay.bin --romfs-auto-key > /dev/null 2>&1
"3dstool.exe" -cvtf cfa %CciFull%_Unpacked/CustomPartition6.bin --header %CciFull%_Unpacked\HeaderNCCH6.bin --romfs %CciFull%_Unpacked\CustomN3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
"3dstool.exe" -cvtf cfa %CciFull%_Unpacked/CustomPartition7.bin --header %CciFull%_Unpacked\HeaderNCCH7.bin --romfs %CciFull%_Unpacked\CustomO3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
for %%j in (%CciFull%_Unpacked\Custom*.bin) do if %%~zj LEQ 20000 del %%j > /dev/null 2>&1
"3dstool.exe" -cvt01267f cci %CciFull%_Unpacked\CustomPartition0.bin %CciFull%_Unpacked\CustomPartition1.bin %CciFull%_Unpacked\CustomPartition2.bin %CciFull%_Unpacked\CustomPartition6.bin %CciFull%_Unpacked\CustomPartition7.bin %CciName%_Edited.3ds --header %CciFull%_Unpacked\HeaderNCSD.bin > /dev/null 2>&1