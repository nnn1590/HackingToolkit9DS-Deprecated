#!/bin/bash +H
echo === HackingToolkit9DS ===

:TitleMenu
clear
echo
echo    ##################################################
echo    #                                                #
echo    #         HackingToolkit9DS par Asia81           #
echo    #        Mis … jour le 20/02/2018 (V12)          #
echo    #                                                #
echo    ##################################################
echo
echo
echo - Entrez D pour extraire un fichier .3DS
echo - Entrez R pour compiler un fichier .3DS
echo - Entrez CE pour extraire un fichier .CIA
echo - Entrez CR pour compiler un fichier .CIA
echo - Entrez ME pour utiliser un extracteur de masse
echo - Entrez MR pour utiliser un reconstructeur de masse
echo - Entrez CXI pour extraire un fichier .CXI
echo - Entrez B1 pour extraire une banniŠre
echo - Entrez B2 pour compiler une banniŠre
echo - Entrez FS1 pour extraire une partition ncch
echo - Entrez FS2 pour extraire les donn‚es d'une partition
echo
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo
set /p Menu=Entrez votre s‚lection : 
if /i "%Menu%"=="D" GOTO Extract3DS
if /i "%Menu%"=="R" GOTO Rebuild3DS
if /i "%Menu%"=="CE" GOTO ExtractCIA
if /i "%Menu%"=="CR" GOTO RebuildCIA
if /i "%Menu%"=="ME" GOTO MassExtractor
if /i "%Menu%"=="MR" GOTO MassRebuilder
if /i "%Menu%"=="CXI" GOTO DecryptedCXI
if /i "%Menu%"=="B1" GOTO ExtractBanner
if /i "%Menu%"=="B2" GOTO RebuildBanner
if /i "%Menu%"=="FS1" GOTO ExtractNcchPartition
if /i "%Menu%"=="FS2" GOTO ExtractFilePartition

:Extract3DS
clear
echo
set /p Rom3DS="Entrez le nom de votre fichier .3DS (sans extension) : "
echo
clear
echo
echo Veuillez patienter, extraction en cours...
echo
"3dstool.exe" -xvt01267f cci DecryptedPartition0.bin DecryptedPartition1.bin DecryptedPartition2.bin DecryptedPartition6.bin DecryptedPartition7.bin %Rom3DS%.3ds --header HeaderNCSD.bin > /dev/null 2>&1
"3dstool.exe" -xvtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs DecryptedExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs DecryptedRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null 2>&1
"3dstool.exe" -xvtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin --romfs-auto-key > /dev/null 2>&1
"3dstool.exe" -xvtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin --romfs-auto-key > /dev/null 2>&1
"3dstool.exe" -xvtf cfa DecryptedPartition6.bin --header HeaderNCCH6.bin --romfs DecryptedN3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
"3dstool.exe" -xvtf cfa DecryptedPartition7.bin --header HeaderNCCH7.bin --romfs DecryptedO3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
del DecryptedPartition0.bin > /dev/null 2>&1
del DecryptedPartition1.bin > /dev/null 2>&1
del DecryptedPartition2.bin > /dev/null 2>&1
del DecryptedPartition6.bin > /dev/null 2>&1
del DecryptedPartition7.bin > /dev/null 2>&1
"3dstool.exe" -xvtfu exefs DecryptedExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin > /dev/null 2>&1
"3dstool.exe" -xvtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS > /dev/null 2>&1
"3dstool.exe" -xvtf romfs DecryptedManual.bin --romfs-dir ExtractedManual > /dev/null 2>&1
"3dstool.exe" -xvtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null 2>&1
"3dstool.exe" -xvtf romfs DecryptedN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate > /dev/null 2>&1
"3dstool.exe" -xvtf romfs DecryptedO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate > /dev/null 2>&1
mv ExtractedExeFS\banner.bnr banner.bin > /dev/null 2>&1
mv ExtractedExeFS\icon.icn icon.bin > /dev/null 2>&1
copy ExtractedExeFS\banner.bin banner.bin > /dev/null 2>&1
"3dstool.exe" -xv -t banner -f banner.bin --banner-dir ExtractedBanner\ > /dev/null 2>&1
del banner.bin > /dev/null 2>&1
mv ExtractedBanner\banner0.bcmdl banner.cgfx > /dev/null 2>&1
echo Extraction termin‚e !
echo
pause
goto:TitleMenu

:Rebuild3DS
clear
echo
set /p OutputRom3DS="Entrez le nom de sortie de votre fichier .3DS (sans extension) : "
clear
echo
echo Veuillez patienter, compilation en cours...
echo
mv ExtractedBanner\banner.cgfx banner0.bcmdl > /dev/null 2>&1
"3dstool.exe" -cv -t banner -f banner.bin --banner-dir ExtractedBanner\ > /dev/null 2>&1
mv ExtractedBanner\banner0.bcmdl banner.cgfx > /dev/null 2>&1
move /Y banner.bin ExtractedExeFS\banner.bin > /dev/null 2>&1
mv ExtractedExeFS\banner.bin banner.bnr > /dev/null 2>&1
mv ExtractedExeFS\icon.bin icon.icn > /dev/null 2>&1
"3dstool.exe" -cvtfz exefs CustomExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin > /dev/null 2>&1
mv ExtractedExeFS\banner.bnr banner.bin > /dev/null 2>&1
mv ExtractedExeFS\icon.icn icon.bin > /dev/null 2>&1
"3dstool.exe" -cvtf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS > /dev/null 2>&1
"3dstool.exe" -cvtf romfs CustomManual.bin --romfs-dir ExtractedManual > /dev/null 2>&1
"3dstool.exe" -cvtf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null 2>&1
"3dstool.exe" -cvtf romfs CustomN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate > /dev/null 2>&1
"3dstool.exe" -cvtf romfs CustomO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate > /dev/null 2>&1
"3dstool.exe" -cvtf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs CustomRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null 2>&1
"3dstool.exe" -cvtf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin --romfs-auto-key > /dev/null 2>&1
"3dstool.exe" -cvtf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin --romfs-auto-key > /dev/null 2>&1
"3dstool.exe" -cvtf cfa CustomPartition6.bin --header HeaderNCCH6.bin --romfs CustomN3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
"3dstool.exe" -cvtf cfa CustomPartition7.bin --header HeaderNCCH7.bin --romfs CustomO3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
for %%j in (Custom*.bin) do if %%~zj LEQ 20000 del %%j > /dev/null 2>&1
"3dstool.exe" -cvt01267f cci CustomPartition0.bin CustomPartition1.bin CustomPartition2.bin CustomPartition6.bin CustomPartition7.bin %OutputRom3DS%_Edited.3ds --header HeaderNCSD.bin > /dev/null 2>&1
del CustomPartition0.bin > /dev/null 2>&1
del CustomPartition1.bin > /dev/null 2>&1
del CustomPartition2.bin > /dev/null 2>&1
del CustomPartition6.bin > /dev/null 2>&1
del CustomPartition7.bin > /dev/null 2>&1
echo Compilation termin‚e !
echo
pause
goto:TitleMenu

:ExtractCIA
clear
echo
set /p RomCIA="Entrez le nom de votre fichier .CIA (sans extension) : "
echo
clear
echo
echo Veuillez patienter, extraction en cours...
echo
"ctrtool.exe" --content=DecryptedApp %RomCIA%.cia > /dev/null 2>&1
mv DecryptedApp.0000.* DecryptedPartition0.bin > /dev/null 2>&1
mv DecryptedApp.0001.* DecryptedPartition1.bin > /dev/null 2>&1
mv DecryptedApp.0002.* DecryptedPartition2.bin > /dev/null 2>&1
"3dstool.exe" -xvtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs DecryptedExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs DecryptedRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null 2>&1
"3dstool.exe" -xvtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin --romfs-auto-key > /dev/null 2>&1
"3dstool.exe" -xvtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin --romfs-auto-key > /dev/null 2>&1
del DecryptedPartition0.bin > /dev/null 2>&1
del DecryptedPartition1.bin > /dev/null 2>&1
del DecryptedPartition2.bin > /dev/null 2>&1
"3dstool.exe" -xvtfu exefs DecryptedExeFS.bin --header HeaderExeFS.bin --exefs-dir ExtractedExeFS > /dev/null 2>&1
"3dstool.exe" -xvtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS > /dev/null 2>&1
"3dstool.exe" -xvtf romfs DecryptedManual.bin --romfs-dir ExtractedManual > /dev/null 2>&1
"3dstool.exe" -xvtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null 2>&1
mv ExtractedExeFS\banner.bnr banner.bin > /dev/null 2>&1
mv ExtractedExeFS\icon.icn icon.bin > /dev/null 2>&1
copy ExtractedExeFS\banner.bin banner.bin > /dev/null 2>&1
"3dstool.exe" -xv -t banner -f banner.bin --banner-dir ExtractedBanner\ > /dev/null 2>&1
del banner.bin > /dev/null 2>&1
mv ExtractedBanner\banner0.bcmdl banner.cgfx > /dev/null 2>&1
echo Extraction termin‚e !
echo
pause
goto:TitleMenu

:RebuildCIA
clear
echo
set /p OutputRomCIA="Entrez le nom de sortie de votre fichier .CIA (sans extension) : "
set /p MinorVer="Version minor originelle (entrez 0 si vous ne savez pas) : "
set /p MicroVer="Version micro originelle (entrez 0 si vous ne savez pas) : "
clear
echo
echo Veuillez patienter, compilation en cours...
echo
mv ExtractedBanner\banner.cgfx banner0.bcmdl > /dev/null 2>&1
"3dstool.exe" -cv -t banner -f banner.bin --banner-dir ExtractedBanner\ > /dev/null 2>&1
mv ExtractedBanner\banner0.bcmdl banner.cgfx > /dev/null 2>&1
move /Y banner.bin ExtractedExeFS\banner.bin > /dev/null 2>&1
mv ExtractedExeFS\banner.bin banner.bnr > /dev/null 2>&1
mv ExtractedExeFS\icon.bin icon.icn > /dev/null 2>&1
mv ExtractedExeFS\banner.bin banner.bnr > /dev/null 2>&1
mv ExtractedExeFS\icon.bin icon.icn > /dev/null 2>&1
"3dstool.exe" -cvtfz exefs CustomExeFS.bin --header HeaderExeFS.bin --exefs-dir ExtractedExeFS > /dev/null 2>&1
mv ExtractedExeFS\banner.bnr banner.bin > /dev/null 2>&1
mv ExtractedExeFS\icon.icn icon.bin > /dev/null 2>&1
"3dstool.exe" -cvtf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS > /dev/null 2>&1
"3dstool.exe" -cvtf romfs CustomManual.bin --romfs-dir ExtractedManual > /dev/null 2>&1
"3dstool.exe" -cvtf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null 2>&1
"3dstool.exe" -cvtf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs CustomRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null 2>&1
"3dstool.exe" -cvtf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin --romfs-auto-key > /dev/null 2>&1
"3dstool.exe" -cvtf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin --romfs-auto-key > /dev/null 2>&1
for %%j in (Custom*.bin) do if %%~zj LEQ 20000 del %%j > /dev/null 2>&1
if exist CustomPartition0.bin (SET ARG0=-content CustomPartition0.bin:0:0x00) > /dev/null 2>&1
if exist CustomPartition1.bin (SET ARG1=-content CustomPartition1.bin:1:0x01) > /dev/null 2>&1
if exist CustomPartition2.bin (SET ARG2=-content CustomPartition2.bin:2:0x02) > /dev/null 2>&1
"makerom.exe" -target p -ignoresign -f cia %ARG0% %ARG1% %ARG2% -minor %MinorVer% -micro %MicroVer% -o %OutputRomCIA%_Edited.cia > /dev/null 2>&1
echo Compilation termin‚e !
echo
pause
goto:TitleMenu

:DecryptedCXI
clear
echo
set /p RomCXI="Entrez le nom de votre fichier .CXI (sans extension) : "
echo
set /p DecompressCode="D‚compresser le fichier code.bin (n/o) : "
if /i "%DecompressCode%"=="O" (SET DC=--decompresscode) else (SET DC=)
clear
echo
echo Veuillez patienter, extraction en cours...
echo
"ctrtool.exe" --ncch=0 --exheader=DecryptedExHeader.bin %RomCXI%.cxi > /dev/null 2>&1
"ctrtool.exe" --ncch=0 --exefs=DecryptedExeFS.bin %RomCXI%.cxi > /dev/null 2>&1
"ctrtool.exe" --ncch=0 --romfs=DecryptedRomFS.bin %RomCXI%.cxi > /dev/null 2>&1
"ctrtool.exe" -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin > /dev/null 2>&1
"ctrtool.exe" -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin %DC% > /dev/null 2>&1
echo Extraction termin‚e !
echo
pause
goto:TitleMenu

:MassExtractor
clear
echo
for %%x in (*.3ds *.cci) DO CALL "Unpack3DS.bat" "%%x"
for %%x in (*.cia) DO CALL "UnpackCIA.bat" "%%x"
goto:TitleMenu

:MassRebuilder
clear
echo
for /D %%D in (*.3ds *.cci) DO CALL "Repack3DS.bat" "%%~nD"
for /D %%D in (*.cia) DO CALL "RepackCIA.bat" "%%~nD"
goto:TitleMenu

:ExtractBanner
clear
echo
"3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ > /dev/null 2>&1
mv ExtractedBanner\banner0.bcmdl banner.cgfx > /dev/null 2>&1
echo BanniŠre extraite !
echo
pause
goto:TitleMenu

:RebuildBanner
clear
echo
mv ExtractedBanner\banner.cgfx banner0.bcmdl > /dev/null 2>&1
"3dstool.exe" -c -t banner -f banner.bin --banner-dir ExtractedBanner\ > /dev/null 2>&1
mv ExtractedBanner\banner0.bcmdl banner.cgfx > /dev/null 2>&1
echo BanniŠre compil‚e !
echo
pause
goto:TitleMenu

:ExtractNcchPartition
clear
echo
echo  1 = Extraire DecryptedExHeader.bin de la partition NCCH0
echo  2 = Extraire DecryptedExeFS.bin de la partition NCCH0
echo  3 = Extraire DecryptedRomFS.bin de la partition NCCH0
echo  4 = Extraire DecryptedManual.bin de la partition NCCH1
echo  5 = Extraire DecryptedDownloadPlay.bin de la partition NCCH2
echo  6 = Extraire DecryptedN3DSUpdate.bin de la partition NCCH6
echo  7 = Extraire DecryptedO3DSUpdate.bin de la partition NCCH7
echo
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo
set /p NcchPartition="Entrez votre choix (1/2/3/4/5/6/7) : "
if /i "%NcchPartition%"=="1" GOTO ExtractNCCH-ExHeader
if /i "%NcchPartition%"=="2" GOTO ExtractNCCH-ExeFS
if /i "%NcchPartition%"=="3" GOTO ExtractNCCH-RomFS
if /i "%NcchPartition%"=="4" GOTO ExtractNCCH-Manual
if /i "%NcchPartition%"=="5" GOTO ExtractNCCH-DownloadPlay
if /i "%NcchPartition%"=="6" GOTO ExtractNCCH-N3DSUpdate
if /i "%NcchPartition%"=="7" GOTO ExtractNCCH-O3DSUpdate

:ExtractNCCH-ExHeader
clear
echo
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
clear
"ctrtool.exe" --ncch=0 --exheader=DecryptedExHeader.bin %FileName% > /dev/null 2>&1
echo
echo Extraction termin‚e !
echo
pause
goto:TitleMenu

:ExtractNCCH-ExeFS
clear
echo
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
clear
echo
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" --ncch=0 --exefs=DecryptedExeFS.bin %FileName% > /dev/null 2>&1
echo
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractExeFS
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-RomFS
clear
echo
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
clear
echo
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" --ncch=0 --romfs=DecryptedRomFS.bin %FileName% > /dev/null 2>&1
echo
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractRomFS
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-Manual
clear
echo
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
clear
echo
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" --ncch=1 --romfs=DecryptedManual.bin %FileName% > /dev/null 2>&1
echo
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractManual
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-DownloadPlay
clear
echo
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
clear
echo
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" --ncch=2 --romfs=DecryptedDownloadPlay.bin %FileName% > /dev/null 2>&1
echo
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractDownloadPlay
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-N3DSUpdate
clear
echo
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
clear
echo
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" --ncch=6 --romfs=DecryptedN3DSUpdate.bin %FileName% > /dev/null 2>&1
echo
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractN3DSUpdate
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractNCCH-O3DSUpdate
clear
echo
set /p FileName="Entrez le nom de votre fichier 3DS|CXI (extension comprise) : "
clear
echo
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" --ncch=7 --romfs=DecryptedO3DSUpdate.bin %FileName% > /dev/null 2>&1
echo
set /p Ask2Extract="Extraction termin‚e ! Souhaitez-vous l'extraire (n/o) : "
if /i %Ask2Extract%==o GOTO ExtractO3DSUpdate
if /i %Ask2Extract%==n GOTO TitleMenu

:ExtractFilePartition
clear
echo
echo  1 = Extraire le contenu du fichier DecryptedExeFS.bin
echo  2 = Extraire le contenu du fichier DecryptedRomFS.bin
echo  3 = Extraire le contenu du fichier DecryptedManual.bin
echo  4 = Extraire le contenu du fichier DecryptedDownloadPlay.bin
echo  5 = Extraire le contenu du fichier DecryptedN3DSUpdate.bin
echo  6 = Extraire le contenu du fichier DecryptedO3DSUpdate.bin
echo
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo
set /p Partition="Entrez votre choix (1/2/3/4/5/6) : "
if /i %Partition%==1 GOTO ExtractExeFS
if /i %Partition%==2 GOTO ExtractRomFS
if /i %Partition%==3 GOTO ExtractManual
if /i %Partition%==4 GOTO ExtractDownloadPlay
if /i %Partition%==5 GOTO ExtractN3DSUpdate
if /i %Partition%==6 GOTO ExtractO3DSUpdate

:ExtractExeFS
clear
echo
set /p DecompressCode="D‚compresser le fichier code.bin (n/o) : "
clear
echo
echo Veuillez patienter, extraction en cours...
if /i "%DecompressCode%"=="O" (SET DC=--decompresscode) else (SET DC=)
"ctrtool.exe" -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin %DC% > /dev/null 2>&1
del ExtractedExeFS\.bin > /dev/null 2>&1
copy ExtractedExeFS\banner.bin banner.bin > /dev/null 2>&1
"3dstool.exe" -x -t banner -f banner.bin --banner-dir ExtractedBanner\ > /dev/null 2>&1
mv ExtractedBanner\banner0.bcmdl banner.cgfx > /dev/null 2>&1
del banner.bin > /dev/null 2>&1
echo
echo Extraction termin‚e !
echo
pause
goto:TitleMenu

:ExtractRomFS
clear
echo
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin > /dev/null 2>&1
echo
echo Extraction termin‚e !
echo
pause
goto:TitleMenu

:ExtractManual
clear
echo
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedManual DecryptedManual.bin > /dev/null 2>&1
echo
echo Extraction termin‚e !
echo
pause
goto:TitleMenu

:ExtractDownloadPlay
clear
echo
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedDownloadPlay DecryptedDownloadPlay.bin > /dev/null 2>&1
echo
echo Extraction termin‚e !
echo
pause
goto:TitleMenu

:ExtractO3DSUpdate
clear
echo
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedO3DSUpdate DecryptedO3DSUpdate.bin > /dev/null 2>&1
echo
echo Extraction termin‚e !
echo
pause
goto:TitleMenu

:ExtractN3DSUpdate
clear
echo
echo Veuillez patienter, extraction en cours...
"ctrtool.exe" -t romfs --romfsdir=./ExtractedN3DSUpdate DecryptedN3DSUpdate.bin > /dev/null 2>&1
echo
echo Extraction termin‚e !
echo
pause
goto:TitleMenu
