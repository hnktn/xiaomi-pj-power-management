@chcp 65001 > nul


:: 投影を終了するため、プロジェクターを安全にシャットダウンするためのバッチファイル 

:: 使用方法 : stop_projection [オプション] <ip_power_type> <ip_power_ip_address> <pj_count> <ip_segment> <first_pj_ip> 
::  -h, --help 使用方法を表示します 
:: <ip_power_type>       : IP Power の型 9255 or 9258 を指定 
:: <ip_power_ip_address> : IP Power のIPアドレス 
:: <pj_count>            : プロジェクターの台数 
:: <ip_segment>          : ゲートウェイのIPアドレスの最初の3つのセグメント 
:: <first_pj_ip>         : 1番目のプロジェクターのIPアドレスの末尾 


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
set expected_args=5

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
setlocal
set ip_power_type=%1
set ip_power_ip_address=%2
set pj_count=%3
set ip_segment=%4
set first_pj_ip=%5

pushd %~dp0

:: プロジェクターをシャットダウン 
call shutdown_projector.bat %pj_count% %ip_segment% %first_pj_ip%

if %errorlevel%==1 (
    exit /b 1
)

echo.

:: IP Power のプラグをOFFに設定 
if "%ip_power_type%" equ "9255" (
    call set_plug_power_9255.bat 0 %ip_power_ip_address%
) else if "%ip_power_type%" equ "9258" (
    call set_plug_power_9258.bat 0 %ip_power_ip_address%
)

if %errorlevel%==1 (
    exit /b 1
)

echo.

echo 投影を終了しました 

exit /b 0


:: サブルーチン 

:usage
echo 使用方法 : %selfname% [オプション] ^<ip_power_type^> ^<ip_power_ip_address^> ^<pj_count^> ^<ip_segment^> ^<first_pj_ip^> 
echo  -h, --help 使用方法を表示します 
echo ^<ip_power_type^>       : IP Power の型 9255 or 9258 を指定 
echo ^<ip_power_ip_address^> : IP Power のIPアドレス 
echo ^<pj_count^>            : プロジェクターの台数 
echo ^<ip_segment^>          : ゲートウェイのIPアドレスの最初の3つのセグメント 
echo ^<first_pj_ip^>         : 1番目のプロジェクターのIPアドレスの末尾 
exit /b