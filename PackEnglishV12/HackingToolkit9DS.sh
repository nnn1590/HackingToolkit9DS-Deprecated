#!/bin/bash +fH
cd $(dirname ${0})

echo === HackingToolkit9DS ===

function title_menu() {
  clear
  echo
  echo '   ##################################################'
  echo '   #                                                #'
  echo '   #          HackingToolkit9DS by Asia81           #'
  echo '   #           Updated: 02/20/2018 (V12)            #'
  echo '   #                                                #'
  echo '   ##################################################'
  echo
  echo
  echo - Write D for extract a .3DS file
  echo - Write R for rebuild a .3DS file
  echo - Write CE for extract a .CIA file
  echo - Write CR for rebuild a .CIA file
  echo - Write ME for use a Mass Extractor
  echo - Write MR for use a Mass Rebuilder
  echo - Write CXI for extract a .CXI file
  echo - Write B1 for extract a decrypted banner
  echo - Write B2 for rebuild a decrypted banner
  echo - Write FS1 for extract a ncch partition
  echo - Write FS2 for extract a file partition
  echo
  echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  echo
  local -u _menu
  read -p"Write your choice: " _menu
  case "${_menu}" in
    "D" ) extract_3ds ;;
    "R" ) rebuild_3ds ;;
    "CE" ) extract_cia ;;
    "CR" ) rebuild_cia ;;
    "ME" ) mass_extractor ;;
    "MR" ) mass_rebuilder ;;
    "CXI" ) decrypted_cxi ;;
    "B1" ) extract_banner ;;
    "B2" ) rebuild_banner ;;
    "FS1" ) extract_ncch_partition ;;
    "FS2" ) extract_file_partition ;;
    * ) exit 0 ;;
  esac
  return 0
}

function extract_3ds() {
  clear
  echo
  local _rom_3ds
  read -ep"Write your input .3DS filename (without extension) : " _rom_3ds
  echo
  clear
  echo
  echo Please wait, extraction in progress...
  echo
  ./3dstool -xvt01267f cci DecryptedPartition0.bin DecryptedPartition1.bin DecryptedPartition2.bin DecryptedPartition6.bin DecryptedPartition7.bin "${_rom_3ds}.3ds" --header HeaderNCSD.bin > /dev/null 2>&1
  ./3dstool -xvtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs DecryptedExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs DecryptedRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null 2>&1
  ./3dstool -xvtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin --romfs-auto-key > /dev/null 2>&1
  ./3dstool -xvtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin --romfs-auto-key > /dev/null 2>&1
  ./3dstool -xvtf cfa DecryptedPartition6.bin --header HeaderNCCH6.bin --romfs DecryptedN3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
  ./3dstool -xvtf cfa DecryptedPartition7.bin --header HeaderNCCH7.bin --romfs DecryptedO3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
  rm DecryptedPartition0.bin > /dev/null 2>&1
  rm DecryptedPartition1.bin > /dev/null 2>&1
  rm DecryptedPartition2.bin > /dev/null 2>&1
  rm DecryptedPartition6.bin > /dev/null 2>&1
  rm DecryptedPartition7.bin > /dev/null 2>&1
  ./3dstool -xvtfu exefs DecryptedExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin > /dev/null 2>&1
  ./3dstool -xvtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS > /dev/null 2>&1
  ./3dstool -xvtf romfs DecryptedManual.bin --romfs-dir ExtractedManual > /dev/null 2>&1
  ./3dstool -xvtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null 2>&1
  ./3dstool -xvtf romfs DecryptedN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate > /dev/null 2>&1
  ./3dstool -xvtf romfs DecryptedO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate > /dev/null 2>&1
  mv ExtractedExeFS/banner.bnr ExtractedExeFS/banner.bin > /dev/null 2>&1  # REN to MODE DONE
  mv ExtractedExeFS/icon.icn ExtractedExeFS/icon.bin > /dev/null 2>&1  # REN to MODE DONE
  cp ExtractedExeFS/banner.bin banner.bin > /dev/null 2>&1
  ./3dstool -xv -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null 2>&1
  rm banner.bin > /dev/null 2>&1
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null 2>&1  # REN to MODE DONE
  echo 'Extraction done!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function rebuild_3ds() {
  clear
  echo
  local _output_rom_3ds
  read -ep"Write your output .3DS filename (without extension) : " _output_rom_3ds
  clear
  echo
  echo Please wait, rebuild in progress...
  echo
  mv ExtractedBanner/banner.cgfx ExtractedBanner/banner0.bcmdl > /dev/null 2>&1 # REN2MOVE done
  ./3dstool -cv -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null 2>&1
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null 2>&1
  mv -f banner.bin ExtractedExeFS/banner.bin > /dev/null 2>&1
  mv ExtractedExeFS/banner.bin ExtractedExeFS/banner.bnr > /dev/null 2>&1
  mv ExtractedExeFS/icon.bin ExtractedExeFS/icon.icn > /dev/null 2>&1
  ./3dstool -cvtfz exefs CustomExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin > /dev/null 2>&1
  mv ExtractedExeFS/banner.bnr ExtractedExeFS/banner.bin > /dev/null 2>&1
  mv ExtractedExeFS/icon.icn ExtractedExeFS/icon.bin > /dev/null 2>&1
  ./3dstool -cvtf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS > /dev/null 2>&1
  ./3dstool -cvtf romfs CustomManual.bin --romfs-dir ExtractedManual > /dev/null 2>&1
  ./3dstool -cvtf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null 2>&1
  ./3dstool -cvtf romfs CustomN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate > /dev/null 2>&1
  ./3dstool -cvtf romfs CustomO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate > /dev/null 2>&1
  ./3dstool -cvtf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs CustomRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null 2>&1
  ./3dstool -cvtf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin --romfs-auto-key > /dev/null 2>&1
  ./3dstool -cvtf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin --romfs-auto-key > /dev/null 2>&1
  ./3dstool -cvtf cfa CustomPartition6.bin --header HeaderNCCH6.bin --romfs CustomN3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
  ./3dstool -cvtf cfa CustomPartition7.bin --header HeaderNCCH7.bin --romfs CustomO3DSUpdate.bin --romfs-auto-key > /dev/null 2>&1
  local IFS=$'\n'
  for j in $(find . -mindepth 1 -maxdepth 1 -type f -name 'Custom*.bin'); do if [ "$(wc -c < "${j}")" -lt 20000 ]; then rm "${j}"; fi; done
  ./3dstool -cvt01267f cci CustomPartition0.bin CustomPartition1.bin CustomPartition2.bin CustomPartition6.bin CustomPartition7.bin "${_output_rom_3ds}_Edited.3ds" --header HeaderNCSD.bin > /dev/null 2>&1
  rm CustomPartition0.bin > /dev/null 2>&1
  rm CustomPartition1.bin > /dev/null 2>&1
  rm CustomPartition2.bin > /dev/null 2>&1
  rm CustomPartition6.bin > /dev/null 2>&1
  rm CustomPartition7.bin > /dev/null 2>&1
  echo 'Creation done!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function extract_cia() {
  clear
  echo
  local _rom_cia
  read -ep"Write your input .CIA filename (without extension) : " _rom_cia
  echo
  clear
  echo
  echo Please wait, extraction in progress...
  echo
  ./ctrtool --content=DecryptedApp "${_rom_cia}.cia" > /dev/null 2>&1
  mv DecryptedApp.0000.* DecryptedPartition0.bin > /dev/null 2>&1
  mv DecryptedApp.0001.* DecryptedPartition1.bin > /dev/null 2>&1
  mv DecryptedApp.0002.* DecryptedPartition2.bin > /dev/null 2>&1
  ./3dstool -xvtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs DecryptedExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs DecryptedRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null 2>&1
  ./3dstool -xvtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin --romfs-auto-key > /dev/null 2>&1
  ./3dstool -xvtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin --romfs-auto-key > /dev/null 2>&1
  rm DecryptedPartition0.bin > /dev/null 2>&1
  rm DecryptedPartition1.bin > /dev/null 2>&1
  rm DecryptedPartition2.bin > /dev/null 2>&1
  ./3dstool -xvtfu exefs DecryptedExeFS.bin --header HeaderExeFS.bin --exefs-dir ExtractedExeFS > /dev/null 2>&1
  ./3dstool -xvtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS > /dev/null 2>&1
  ./3dstool -xvtf romfs DecryptedManual.bin --romfs-dir ExtractedManual > /dev/null 2>&1
  ./3dstool -xvtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null 2>&1
  mv ExtractedExeFS/banner.bnr ExtractedExeFS/banner.bin > /dev/null 2>&1
  mv ExtractedExeFS/icon.icn ExtractedExeFS/icon.bin > /dev/null 2>&1
  cp ExtractedExeFS/banner.bin banner.bin > /dev/null 2>&1
  ./3dstool -xv -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null 2>&1
  rm banner.bin > /dev/null 2>&1
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null 2>&1
  echo 'Extraction done!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function rebuild_cia() {
  clear
  echo
  local _output_rom_cia _minor_ver _micro_ver
  read -ep"Write your output .CIA filename (without extension) : " _output_rom_cia
  read -ep"Original minor version (write 0 if you don't know) : " _minor_ver
  read -ep"Original micro version (write 0 if you don't know) : " _micro_ver
  clear
  echo
  echo Please wait, rebuild in progress...
  echo
  mv ExtractedBanner/banner.cgfx ExtractedBanner/banner0.bcmdl > /dev/null 2>&1
  ./3dstool -cv -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null 2>&1
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null 2>&1
  mv -f banner.bin ExtractedExeFS/banner.bin > /dev/null 2>&1
  mv ExtractedExeFS/banner.bin ExtractedExeFS/banner.bnr > /dev/null 2>&1
  mv ExtractedExeFS/icon.bin ExtractedExeFS/icon.icn > /dev/null 2>&1
  mv ExtractedExeFS/banner.bin ExtractedExeFS/banner.bnr > /dev/null 2>&1
  mv ExtractedExeFS/icon.bin ExtractedExeFS/icon.icn > /dev/null 2>&1
  ./3dstool -cvtfz exefs CustomExeFS.bin --header HeaderExeFS.bin --exefs-dir ExtractedExeFS > /dev/null 2>&1
  mv ExtractedExeFS/banner.bnr ExtractedExeFS/banner.bin > /dev/null 2>&1
  mv ExtractedExeFS/icon.icn ExtractedExeFS/icon.bin > /dev/null 2>&1
  ./3dstool -cvtf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS > /dev/null 2>&1
  ./3dstool -cvtf romfs CustomManual.bin --romfs-dir ExtractedManual > /dev/null 2>&1
  ./3dstool -cvtf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null 2>&1
  ./3dstool -cvtf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs CustomRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null 2>&1
  ./3dstool -cvtf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin --romfs-auto-key > /dev/null 2>&1
  ./3dstool -cvtf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin --romfs-auto-key > /dev/null 2>&1
  for j in $(find . -mindepth 1 -maxdepth 1 -type f -name 'Custom*.bin'); do if [ "$(wc -c < "${j}")" -lt 20000 ]; then rm "${j}"; fi; done
  local _arg_0 _arg_1 _arg_2
  if [ -e "CustomPartition0.bin" ]; then _arg_0="-content CustomPartition0.bin:0:0x00"; fi > /dev/null 2>&1
  if [ -e "CustomPartition1.bin" ]; then _arg_1="-content CustomPartition1.bin:1:0x01"; fi > /dev/null 2>&1
  if [ -e "CustomPartition2.bin" ]; then _arg_2="-content CustomPartition2.bin:2:0x02"; fi > /dev/null 2>&1
  ./makerom -target p -ignoresign -f cia ${_arg_0} ${_arg_1} ${_arg_2} -minor "${_minor_ver}" -micro "${_micro_ver}" -o "${_output_rom_cia}_Edited.cia" > /dev/null 2>&1
  echo 'Creation done!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

decrypted_cxi() {
  clear
  echo
  local _rom_cxi
  read -ep"Write your input .CXI filename (without extension) : " _rom_cxi
  echo
  local -u _decompress_code
  local _dc
  read -ep"Decompress the code.bin file (n/y) : " _decompress_code
  if [ "${_decompress_code}" == "Y" ]; then _dc="--decompresscode"; else _dc=""; fi
  clear
  echo
  echo Please wait, extraction in progress...
  echo
  ./ctrtool --ncch=0 --exheader=DecryptedExHeader.bin "${_rom_cxi}.cxi" > /dev/null 2>&1
  ./ctrtool --ncch=0 --exefs=DecryptedExeFS.bin "${_rom_cxi}.cxi" > /dev/null 2>&1
  ./ctrtool --ncch=0 --romfs=DecryptedRomFS.bin "${_rom_cxi}.cxi" > /dev/null 2>&1
  ./ctrtool -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin > /dev/null 2>&1
  ./ctrtool -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin ${_dc} > /dev/null 2>&1
  echo 'Extraction done!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function mass_extractor() {
  clear
  echo
  local IFS=$'\n'
  for x in $(find . -mindepth 1 -maxdepth 1 -type f -name '*.3ds'); do ./Unpack3DS.sh "${x}"; done
  for x in $(find . -mindepth 1 -maxdepth 1 -type f -name '*.cci'); do ./Unpack3DS.sh "${x}"; done
  for x in $(find . -mindepth 1 -maxdepth 1 -type f -name '*.cia'); do ./UnpackCIA.sh "${x}"; done
}

function mass_rebuilder() {
  clear
  echo
  for D in $(find . -mindepth 1 -maxdepth 1 -type d -name '*.3ds'); do ./Repack3DS.sh "${D##*/}"; done
  for D in $(find . -mindepth 1 -maxdepth 1 -type d -name '*.cci'); do ./Repack3DS.sh "${D##*/}"; done
  for D in $(find . -mindepth 1 -maxdepth 1 -type d -name '*.cia'); do ./RepackCIA.sh "${D##*/}"; done
}

function extract_banner() {
  clear
  echo
  ./3dstool -x -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null 2>&1
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null 2>&1
  echo 'Banner extracted!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function rebuild_banner() {
  clear
  echo
  mv ExtractedBanner/banner.cgfx ExtractedBanner/banner0.bcmdl > /dev/null 2>&1
  ./3dstool -c -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null 2>&1
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null 2>&1
  echo 'Banner created!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function extract_ncch_partition() {
  clear
  echo
  echo  1 = Extract DecryptedExHeader.bin from NCCH0
  echo  2 = Extract DecryptedExeFS.bin from NCCH0
  echo  3 = Extract DecryptedRomFS.bin from NCCH0
  echo  4 = Extract DecryptedManual.bin from NCCH1
  echo  5 = Extract DecryptedDownloadPlay.bin from NCCH2
  echo  6 = Extract DecryptedN3DSUpdate.bin from NCCH6
  echo  7 = Extract DecryptedO3DSUpdate.bin from NCCH7
  echo
  echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  echo
  local _ncch_partition
  read -ep"Write your choice (1/2/3/4/5/6/7) : " _ncch_partition
  case "${_ncch_partition}" in
    "1" ) extract_ncch_ex_header ;;
    "2" ) extract_ncch_exe_fs ;;
    "3" ) extract_ncch_rom_fs ;;
    "4" ) extract_ncch_manual ;;
    "5" ) extract_ncch_download_play ;;
    "6" ) extract_ncch_n3ds_update ;;
    "7" ) extract_ncch_o3ds_update ;;
  esac
}

function extract_ncch_ex_header() {
  clear
  echo
  local _file_name
  read -ep"Write your 3DS|CXI filename (with extension): " _file_name
  clear
  ./ctrtool --ncch=0 --exheader=DecryptedExHeader.bin "${_file_name}" > /dev/null 2>&1
  echo
  echo 'Extraction done!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function extract_ncch_exe_fs() {
  clear
  echo
  local _file_name
  read -ep"Write your 3DS|CXI filename (with extension): " _file_name
  clear
  echo
  echo Please wait, extraction in progress...
  ./ctrtool --ncch=0 --exefs=DecryptedExeFS.bin "${_file_name}" > /dev/null 2>&1
  echo
  local -u _ask2extract
  read -ep'Extraction done! Would you extract it now (n/y) : ' _ask2extract
  if [ "${_ask2extract}" == "Y" ]; then extract_exe_fs; fi
}

function extract_ncch_rom_fs() {
  clear
  echo
  local _file_name
  read -ep"Write your 3DS|CXI filename (with extension): " _file_name
  clear
  echo
  echo Please wait, extraction in progress...
  ./ctrtool --ncch=0 --romfs=DecryptedRomFS.bin "${_file_name}" > /dev/null 2>&1
  echo
  local -u _ask2extract
  read -ep'Extraction done! Would you extract it now (n/y) : ' _ask2extract
  if [ "${_ask2extract}" == "Y" ]; then extract_rom_fs; fi
}

function extract_ncch_manual() {
  clear
  echo
  local _file_name
  read -ep"Write your 3DS|CXI filename (with extension): " _file_name
  clear
  echo
  echo Please wait, extraction in progress...
  ./ctrtool --ncch=1 --romfs=DecryptedManual.bin "${_file_name}" > /dev/null 2>&1
  echo
  local -u _ask2extract
  read -ep'Extraction done! Would you extract it now (n/y) : ' _ask2extract
  if [ "${_ask2extract}" == "Y" ]; then extract_manual; fi
}

function extract_ncch_download_play() {
  clear
  echo
  local _file_name
  read -ep"Write your 3DS|CXI filename (with extension): " _file_name
  clear
  echo
  echo Please wait, extraction in progress...
  ./ctrtool --ncch=2 --romfs=DecryptedDownloadPlay.bin "${_file_name}" > /dev/null 2>&1
  echo
  local -u _ask2extract
  read -ep'Extraction done! Would you extract it now (n/y) : ' _ask2extract
  if [ "${_ask2extract}" == "Y" ]; then extract_download_play; fi
}

function extract_ncch_n3ds_update() {
  clear
  echo
  local _file_name
  read -ep"Write your 3DS|CXI filename (with extension): " _file_name
  clear
  echo
  echo Please wait, extraction in progress...
  ./ctrtool --ncch=6 --romfs=DecryptedN3DSUpdate.bin "${_file_name}" > /dev/null 2>&1
  echo
  local -u _ask2extract
  read -ep'Extraction done! Would you extract it now (n/y) : ' _ask2extract
  if [ "${_ask2extract}" == "Y" ]; then extract_n3ds_update; fi
}

function extract_ncch_o3ds_update() {
  clear
  echo
  local _file_name
  read -ep"Write your 3DS|CXI filename (with extension): " _file_name
  clear
  echo
  echo Please wait, extraction in progress...
  ./ctrtool --ncch=7 --romfs=DecryptedO3DSUpdate.bin "${_file_name}" > /dev/null 2>&1
  echo
  local -u _ask2extract
  read -ep'Extraction done! Would you extract it now (n/y) : ' _ask2extract
  if [ "${_ask2extract}" == "Y" ]; then extract_o3ds_update; fi
}

function extract_file_partition() {
  clear
  echo
  echo  1 = Extract contents from DecryptedExeFS.bin
  echo  2 = Extract contents from DecryptedRomFS.bin
  echo  3 = Extract contents from DecryptedManual.bin
  echo  4 = Extract contents from DecryptedDownloadPlay.bin
  echo  5 = Extract contents from DecryptedN3DSUpdate.bin
  echo  6 = Extract contents from DecryptedO3DSUpdate.bin
  echo
  echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  echo
  local _partition
  read -ep"Write your choice (1/2/3/4/5/6) : " _partition
  case "${_partition}" in
    "1" ) extract_exe_fs ;;
    "2" ) extract_rom_fs ;;
    "3" ) extract_manual ;;
    "4" ) extract_download_play ;;
    "5" ) extract_n3ds_update ;;
    "6" ) extract_o3ds_update ;;
  esac
}

function extract_exe_fs() {
  clear
  echo
  local -u _decompress_code
  read -ep"Decompress the code.bin file (n/y) : " _decompress_code
  clear
  echo
  echo Please wait, extraction in progress...
  local _dc
  if [ "${_decompress_code}" == "Y" ]; then _dc="--decompresscode"; else _dc=""; fi
  ./ctrtool -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin ${_dc} > /dev/null 2>&1
  rm -f ExtractedExeFS/.bin > /dev/null 2>&1  # Is this typo?
  cp ExtractedExeFS/banner.bin banner.bin > /dev/null 2>&1
  ./3dstool -x -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null 2>&1
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null 2>&1
  rm banner.bin > /dev/null 2>&1
  echo
  echo Extraction done
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function extract_rom_fs() {
  clear
  echo
  echo Please wait, extraction in progress...
  ./ctrtool -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin > /dev/null 2>&1
  echo
  echo 'Extraction done!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function extract_manual() {
  clear
  echo
  echo Please wait, extraction in progress...
  ./ctrtool -t romfs --romfsdir=./ExtractedManual DecryptedManual.bin > /dev/null 2>&1
  echo
  echo 'Extraction done!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function extract_download_play() {
  clear
  echo
  echo Please wait, extraction in progress...
  ./ctrtool -t romfs --romfsdir=./ExtractedDownloadPlay DecryptedDownloadPlay.bin > /dev/null 2>&1
  echo
  echo 'Extraction done!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function extract_o3ds_update() {
  clear
  echo
  echo Please wait, extraction in progress...
  ./ctrtool -t romfs --romfsdir=./ExtractedO3DSUpdate DecryptedO3DSUpdate.bin > /dev/null 2>&1
  echo
  echo 'Extraction done!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

function extract_n3ds_update() {
  clear
  echo
  echo Please wait, extraction in progress...
  ./ctrtool -t romfs --romfsdir=./ExtractedN3DSUpdate DecryptedN3DSUpdate.bin > /dev/null 2>&1
  echo
  echo 'Extraction done!'
  echo
  read -rsn1 -p"Press any key to continue..."; echo
}

while :; do title_menu || exit ${?}; done
