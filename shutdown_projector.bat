@chcp 65001 > nul


:: Xiaomi Mi Laser UST Projector 150" をADBコマンドで安全にシャットダウンするバッチファイル 
:: ※プロジェクターのUSBデバッグが有効になっていること 

:: 使用方法 : shutdown_projector [オプション] <pj_count> <ip_segment> <first_pj_ip> 
::  -h, --help 使用方法を表示します 
:: <pj_count>    : プロジェクターの台数 
:: <ip_segment>  : ゲートウェイのIPアドレスの最初の3つのセグメント 
:: <first_pj_ip> : 1番目のプロジェクターのIPアドレスの末尾 


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
set expected_args=3

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
set pj_count=%1
set ip_segment=%2
set first_pj_ip=%3

set /a last_pj_ip=%first_pj_ip%+%pj_count%-1

:: ADBのポート設定 
set port=5555

:: 一旦接続をクリアするためにadbサーバーを終了する 
adb kill-server > nul
adb start-server > nul 2>&1

:: プロジェクターをシャットダウンする操作を台数分繰り返す 
for /l %%i in (%first_pj_ip%, 1, %last_pj_ip%) do (
    echo %ip_segment%.%%iのプロジェクターに接続しています
    adb connect %ip_segment%.%%i:%port%
    echo.
    adb -s %ip_segment%.%%i:%port% shell reboot -p > nul 2>&1
    if ERRORLEVEL 1 (
        echo %ip_segment%.%%iのプロジェクターへのシャットダウンコマンドの送信に失敗しました 
        echo IPアドレスのセグメントもしくはプロジェクターのIPアドレスが間違っている可能性があります 
        exit /b 1
    ) else (
        echo %ip_segment%.%%iのプロジェクターにシャットダウンコマンドを送信しました 
    )
    echo.
)

:: プロジェクターがシャットダウンするまで待機 
echo プロジェクターがシャットダウンするのを待っています 
timeout /t 10 /nobreak > nul
echo プロジェクターがシャットダウンしました 

exit /b 0


:: サブルーチン 

:usage
echo 使用方法 : %selfname% [オプション] ^<pj_count^> ^<ip_segment^> ^<first_pj_ip^> 
echo  -h, --help 使用方法を表示します 
echo ^<pj_count^>            : プロジェクターの台数 
echo ^<ip_segment^>          : ゲートウェイのIPアドレスの最初の3つのセグメント 
echo ^<first_pj_ip^>         : 1番目のプロジェクターのIPアドレスの末尾 
exit /b