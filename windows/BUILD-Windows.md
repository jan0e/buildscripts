How to build Ricochet for Windows
=================================
This file describes how to build ricochet on Windows using Microsoft Visual Studio Express as compiler. You could use MinGW as compiler which would need less preparation but has a significant drawback: QT applications compiled with MinGW rely on OpenGL, while QT applications compiled with VS will use ANGLE, a DirectX wrapper for OpenGL operations. The latter is much more compatible since QtQuick2 relies on OpenGL 2.0, which Windows isn't supporting natively.

Prepare build environment
=========================
Download and install all needed programs and files. Note: if you use the default install dir of each setup the build script should work out of the box.

QT SDK
--------------
- [Download and install QT SDK](http://download.qt-project.org/archive/qt/5.3/5.3.2/qt-opensource-windows-x86-msvc2013-5.3.2.exe)

Be sure to use a 32bit version matching your Visual Studio version _without_ OpenGL.
- Add the QT msvcXXXX bin dir e.g. (C:\Qt\Qt5.3.2\5.3\msvc2013\bin) to your PATH variable

Be sure this is the only QT bin dir in your PATH variable.

Visual Studio Express:
----------------------
- [Download and install Visual Studio Express](http://www.visualstudio.com/)
- Restart your machine

OpenSSL Library
-----------------------
- [Download and install 32bit Visual C++ 2008 Redistributables](http://www.microsoft.com/downloads/details.aspx?familyid=9B2DA534-3E03-4391-8A4D-074B9F2BC1BF)

- [Download and install OpenSSL Lib](http://slproweb.com/download/Win32OpenSSL-1_0_1i.exe)

Tor 
-----------
- [Download and install Tor Expert Bundle](https://www.torproject.org/dist/win32/tor-0.2.4.23-win32.exe)

Run setup as Administrator. Note: You don't have to run Tor
	

Ricochet source code
----------------------------

###Option 1
- [Download and extract ZIP](https://github.com/ricochet-im/ricochet/archive/master.zip)

###Option 2
- [Download and install Git](https://github.com/msysgit/msysgit/releases/download/Git-1.9.4-preview20140929/Git-1.9.4-preview20140929.exe)

Default settings in the setup are just fine

	git clone https://github.com/ricochet-im/ricochet.git

Notepad++ (optional)
--------------------
- [Download and install Notepadd++](http://download.tuxfamily.org/notepadplus/6.6.9/npp.6.6.9.Installer.exe) (a good text editor for Windows)


Building
========

Prepare scripts
-----------------------
- Download ['win-build-deploy.bat'](https://raw.githubusercontent.com/jan0e/buildscripts/windows/windows/win-build-deploy.bat) and copy it into your ricochet folder
- Open 'win-build-deploy.bat' in a text editor
- Check if the variables SSLDIR, TORDIR, MSBUILD and VCINSTALLDIR are pointing to existing locations. Note: Don't use trailing slashes
- Check if QMAKESPEC matches your Visual Studio Version
- Save and close

Prepare compiling
-------------------------
- Open ricochet.pro (in QT Creator or any text editor)
- Search for 'win32 {' and insert 

	TEMPLATE = vcapp

This tells qmake to create a Visual Studio project file
Compile
-------
- Run 'win-build-deploy.bat'

If everything went right you should have a 'release\Ricochet', which contains a ready to go version of Ricochet

Troubleshooting
---------------
If something went wrong: 
- Open a command line
- Navigate to your ricochet folder
- Run 'win-build-deploy.bat' > log.txt

log.txt might help you to find out what's going on

Kown bugs
=========
Try to open the Visual Studio file. You may encounter following error:

	"The element 'translation\ricochet_da.ts' something something" 

For some reason qmake includes the translation files twice. VS complains about that. 

To fix that:	
- Open ricochet.vcxproj with a text editor
- Search for 'ricochet_da.ts'
- Delete one of the ItemGroups which includes those translation files completely  (everything between and including <ItemGroup></ItemGroup>)
- Save, close and try to open again with Visual Studio