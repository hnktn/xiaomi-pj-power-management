@chcp 65001 > nul


:: Xiaomi Mi Laser UST Projector 150" をADBコマンドで安全にシャットダウンするバッチファイル 
:: ※プロジェクターのUSBデバッグが有効になっていること 

:: 第1引数 プロジェクターの台数 
:: 第2引数 ゲートウェイのIPアドレスの最初の3つのセグメント 
:: 第3引数 1番目のプロジェクターのIPアドレスの末尾 


@echo off
setlocal

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
    adb connect %ip_segment%.%%i:%port% > nul
    echo %ip_segment%.%%iのプロジェクターに接続しました。 
    adb -s %ip_segment%.%%i:%port% shell reboot -p > nul 2>&1
    echo %ip_segment%.%%iのプロジェクターにシャットダウンコマンドを送信しました。 
)

:: プロジェクターがシャットダウンするまで待機 
echo プロジェクターがシャットダウンするのを待っています。 
timeout /t 10 /nobreak > nul
echo プロジェクターがシャットダウンしました。 