# HackingToolkit9DS

![IMAGE](http://nsa39.casimages.com/img/2018/02/20/180220062531406418.png)

UDDATE AS OF JUNE 21st 2018
You have understood from my inactivity that the tool is not being updated anymore.
It still work (or not, depend on peoples), but I'm not working anymore on it.

With this tool, you'll be able to:
- Extract and rebuild any .3DS file
- Extract and rebuild any .CIA file (No DLC nor DSiWare atm)
- Extract any .CXI file
- Extract and rebuild a 3DS banner file (shown on the 3DS home menu)
- Mass extract and mass rebuild any .3DS and .CIA files in the same time
- Extract any ncch partition from a .3DS file (CIA support is planned)
- Extract contents from a decrypted ncch binary file

Before report an issue, be sure:
- Your 3DS|CIA|CXI file is clean and not decrypted by Decrypt9 or GodMode9.
- Your 3DS|CIA|CXI file doesn't have any space or special character in its name (such as é or à).
- Your 3DS|CIA|CXI file is in the same folder as HackingToolkit9DS.
- You're not trying to extract the file in the ProgramFiles folder (where installed core files are).
- To write or don't write the extension of your file when specified.
- To have installed the setup package for your language (SetupXX.exe file).

Changelog V12 (02/20/2018)
- Fixed encrypted CIA rebuild process.
- Removed installation check.

The main tutorial can be found here:<br>
https://gbatemp.net/threads/383055/

Contacts:
- Github : https://github.com/Asia81
- Twitter : https://twitter.com/ProteccWaifu
- Youtube : https://www.youtube.com/c/asia81
- GBA Temp : https://gbatemp.net/members/asia81.356294/
- I speak both french and english, feel free to speak to me in the language you want.

If you fork it, or do anything with it, do what you want without asking.  
But please, just give some credits, thanks!

## How to update `ext_key.txt`
`ext_key.txt` is in the `Pack*V12/` directory.

 1. Download [this](https://raw.githubusercontent.com/dnasdw/3dstool/master/bin/ext_key.txt). `wget https://raw.githubusercontent.com/dnasdw/3dstool/master/bin/ext_key.txt`
 2. Replace `ext_key.txt` with a new one. Since Wget basically overwrites the file, it may not be necessary if you run it in the directory where `ext_key.txt` is.
 3. Done!

or

 1. `git clone https://github.com/nnn1590/HackingToolkit9DS-Deprecated-.git --recursive` (If you didn't specify `--recursive` when cloning, execute: `git submodule update --init --recursive`)
 2. `cp 3dstool/bin/ext_key.txt PackEnglishV12/ && cp 3dstool/bin/ext_key.txt PackFrancaisV12/`

## How to build `3dstool`, `ctrtool` and `makerom`
 1. `git clone https://github.com/nnn1590/HackingToolkit9DS-Deprecated-.git --recursive` (If you didn't specify `--recursive` when cloning, execute: `git submodule update --init --recursive`)
 2. `make`

## License
- `3dstool`: MIT License, Copyright (c) 2014-2020 Daowen Sun
- `ctrtool`: MIT License, Copyright (c) 2012 neimod, Copyright (c) 2014 3DSGuy
- `makerom`: MIT License, Copyright (c) 2014 3DSGuy, Copyright (c) 2014 applestash, Copyright (c) 2015-2016 Jakcron
