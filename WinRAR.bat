@echo off
echo LICENSING...
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
cd c:\
for /f "delims=" %%a in ('dir "WinRAR.exe" /S /B') do (call set concat=%%concat%%%%a)
set str=%concat:WinRAR.exe=%
cd %str%
IF EXIST rarreg.key DEL /F rarreg.key
(
echo RAR registration data
echo Federal Agency for Education
echo 1000000 PC usage license
echo UID=b621cca9a84bc5deffbf
echo 6412612250ffbf533df6db2dfe8ccc3aae5362c06d54762105357d
echo 5e3b1489e751c76bf6e0640001014be50a52303fed29664b074145
echo 7e567d04159ad8defc3fb6edf32831fd1966f72c21c0c53c02fbbb
echo 2f91cfca671d9c482b11b8ac3281cb21378e85606494da349941fa
echo e9ee328f12dc73e90b6356b921fbfb8522d6562a6a4b97e8ef6c9f
echo fb866be1e3826b5aa126a4d2bfe9336ad63003fc0e71c307fc2c60
echo 64416495d4c55a0cc82d402110498da970812063934815d81470829275
) > rarreg.key
cls
echo DONE!
pause
exit