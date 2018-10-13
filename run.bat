@echo off
setlocal enabledelayedexpansion


if NOT "%1"=="" (
	set build_type=%1
) else (
	set build_type=Debug
)


set script_dir=%~dp0

set app=%script_dir%Multi\%build_type%\skel.exe

if NOT EXIST %app% (
	set error_message=calling build

	call %script_dir%build.bat %build_type%
	if NOT '!ERRORLEVEL!'=='0' goto fail
)


set error_message="%app%"
cd %script_dir%
%app%
if NOT '!ERRORLEVEL!'=='0' goto fail


:success
	exit /b 0


:fail
	echo Something wrong during %error_message%
	exit /b 1
