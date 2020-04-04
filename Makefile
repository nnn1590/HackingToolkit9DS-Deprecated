CC	:= gcc
CXX	:= g++

.PHONY: all
all: 3dstool ctrtool makerom copy

.PHONY: 3dstool ctrtool makerom

3dstool:
	mkdir -p 3dstool/build
	cd 3dstool/build && cmake -DUSE_DEP=OFF ..
	$(MAKE) -C 3dstool/build

ctrtool:
	$(MAKE) -C Project_CTR/ctrtool

makerom:
	$(MAKE) -C Project_CTR/makerom

.PHONY: copy
copy: 3dstool ctrtool makerom
	cp 3dstool/bin/Release/3dstool PackEnglishV12/
	cp 3dstool/bin/Release/3dstool PackFrancaisV12/
	cp Project_CTR/ctrtool/ctrtool PackEnglishV12/
	cp Project_CTR/ctrtool/ctrtool PackFrancaisV12/
	cp Project_CTR/makerom/makerom PackEnglishV12/
	cp Project_CTR/makerom/makerom PackFrancaisV12/

.PHONY: clean
clean:
	$(RM) PackEnglishV12/3dstool PackFrancaisV12/3dstool PackEnglishV12/ctrtool PackFrancaisV12/ctrtool PackEnglishV12/makerom PackFrancaisV12/makerom
	$(RM) -rf 3dstool/build 3dstool/bin/Release
	$(MAKE) -C Project_CTR/ctrtool clean
	$(MAKE) -C Project_CTR/makerom clean
