#!/bin/bash +fH
cd $(dirname ${0})

echo === CleanTool9 par Asia81 ===
echo -ne "\e[31m"
clear
echo
echo '!! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!'
echo '!! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!'
echo
echo Ce fichier va effacer les fichiers suivants de ce dossier :
echo
echo - Tous les fichiers .xorpad
echo - Tous les fichiers .3ds
echo - Tous les fichiers .cci
echo - Tous les fichiers .cxi
echo - Tous les fichiers .cia
echo - Tous les fichiers .app
echo - Tous les fichiers .out
echo - Tous les fichiers .cfa
echo - Tous les fichiers .sav
echo - Tous les fichiers .tmd
echo - Tous les fichiers .cmd
echo - Tous les fichiers .bin
echo - Tous les fichiers .lz
echo - Tous les dossiers \"Extracted*\"
echo
echo '!! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!'
echo '!! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!'
echo
read -rsn1 -p"Appuyez sur n'importe quelle touche pour continuer..."; echo
echo -ne "\e[m"
rm *.xorpad > /dev/null 2>&1
rm *.3ds > /dev/null 2>&1
rm *.cci > /dev/null 2>&1
rm *.cxi > /dev/null 2>&1
rm *.cia > /dev/null 2>&1
rm *.app > /dev/null 2>&1
rm *.out > /dev/null 2>&1
rm *.cfa > /dev/null 2>&1
rm *.sav > /dev/null 2>&1
rm *.tmd > /dev/null 2>&1
rm *.cmd > /dev/null 2>&1
rm *.bin > /dev/null 2>&1
rm *.lz > /dev/null 2>&1
rm -rf ExtractedExeFS > /dev/null 2>&1
rm -rf ExtractedRomFS > /dev/null 2>&1
rm -rf ExtractedBanner > /dev/null 2>&1
rm -rf ExtractedManual > /dev/null 2>&1
rm -rf ExtractedDownloadPlay > /dev/null 2>&1
rm -rf ExtractedO3DSUpdate > /dev/null 2>&1
rm -rf ExtractedN3DSUpdate > /dev/null 2>&1
