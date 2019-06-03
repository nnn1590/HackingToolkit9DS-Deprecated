#!/bin/bash +H
echo === CleanTool9 by Asia81 ===
echo -ne "\e[31m"
clear
echo
echo !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!
echo !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!
echo
echo This file will erase the following files in this folder:
echo
echo - All .xorpad files
echo - All .3ds files
echo - All .cci files
echo - All .cxi files
echo - All .cia files
echo - All .app files
echo - All .out files
echo - All .cfa files
echo - All .sav files
echo - All .tmd files
echo - All .cmd files
echo - All .bin files
echo - All .lz files
echo - All \"Extracted*\" folders
echo
echo !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!
echo !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!
echo
pause
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
