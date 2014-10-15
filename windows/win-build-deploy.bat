@echo off
SET QMAKESPEC=win32-msvc2013
SET SSLDIR=C:\OpenSSL-Win32
SET TORDIR="C:\Program Files (x86)\Tor"
SET VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC
SET MSBUILD="C:\Program Files (x86)\MSBuild\12.0\Bin\msbuild.exe"

echo generate makefile
qmake OPENSSLDIR=%SSLDIR%

echo compile
%MSBUILD% /p:Configuration=Release

echo deploy
md release\Ricochet
del /Q release\Ricochet\*.*
cd release
copy ricochet.exe .\Ricochet\
cd Ricochet
windeployqt.exe --qmldir ..\..\src\ui\qml ricochet.exe
copy %SSLDIR%\libeay32.dll .\
copy %TORDIR%\Tor.exe .\

echo done
pause