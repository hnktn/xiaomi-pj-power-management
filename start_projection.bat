@chcp 65001 > nul


:: 投影を開始するため、プロジェクターを起動し、入力をIDMI1に切り替えるバッチファイル 

:: 使用方法 : start_projection [オプション] <ip_power_type> <ip_power_ip_address> 
::  -h, --help 使用方法を表示します 
:: <ip_power_type>       : IP Power の型 9255 or 9258 を指定 
:: <ip_power_ip_address> : IP Power のIPアドレス 


@echo off
setlocal

set selfname=%~n0

:: 引数無し、もしくは--helpオプションが使用された際は使用方法を表示する 
if "%1"=="" (
    call :usage
    exit /b 0
)

if "%1"=="-h" (
    call :usage
    exit /b 0
)

if "%1"=="--help" (
    call :usage
    exit /b 0
)

:: 引数が不足している、もしくは多い時にエラーメッセージを出力しバッチファイルを終了する 
set expected_args=2

set arg_count=0
for %%x in (%*) do set /a arg_count+=1

if %arg_count% lss %expected_args% (
    echo エラー: 引数が不足しています 
    echo "%selfname% --help" で使用方法を確認できます 
    exit /b 1
) else if %arg_count% gtr %expected_args% (
    echo エラー: 不要な引数が渡されました 
    echo "%selfname% --help" で使用方法を確認できます 
    exit /b 1
)

:: 変数に引数を代入 
set ip_power_type=%1
set ip_power_ip_address=%2

pushd %~dp0

:: IP Power のプラグをONに設定 
if "%ip_power_type%"=="9255" (
    call set_plug_power_9255.bat 1 %ip_power_ip_address%
) else if "%ip_power_type%"=="9258" (
    call set_plug_power_9258.bat 1 %ip_power_ip_address%
)

if %errorlevel%==1 (
    exit /b 1
)

echo.

echo 投影を開始します 

exit /b 0


:: サブルーチン 

:usage
echo 使用方法 : %selfname% [オプション] ^<ip_power_type^> ^<ip_power_ip_address^> 
echo  -h, --help 使用方法を表示します 
echo ^<ip_power_type^>       : IP Power の型 9255 or 9258 を指定 
echo ^<ip_power_ip_address^> : IP Power のIPアドレス 
exit /b