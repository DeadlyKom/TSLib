@echo off
@echo Current directory is: %cd%

@REM set Project=1.Empty
@REM set Project=2.HelloWorld
set Project=3.Bitmap
@REM set Project=Demo

Build\_sjasmplus\sjasmplus.exe --fullpath --lstlab --sym=Build\Tmp\%Project%.labels --lst=Build\Tmp\%Project%.list --sld=Build\Tmp\%Project%.sld Examples\%Project%\Configuration.inc

if errorlevel 1 exit

Build\SPG\spgbld.exe -b Examples\%Project%\Files\Config.ini Examples\%Project%\%Project%.spg -с 0