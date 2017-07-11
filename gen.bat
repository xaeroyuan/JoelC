@echo off
cd /d %~dp0
IF EXIST build rmdir /s/q build
mkdir build
cd build
..\..\cmake\bin\cmake .. -G "Visual Studio 15 2017 Win64"
cd ..
@echo on