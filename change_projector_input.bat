:: Xiaomi Mi Laser UST Projector 150" の入力をADBコマンドでHDMI1に変更するバッチファイル
:: ※プロジェクターのホーム画面のお気に入りの1番目に Projectivy Launcher が設定されていること
:: ※プロジェクターのUSBデバッグが有効になっていること

:: 第1引数 プロジェクターの台数
:: 第2引数 ローカルネットワークのIPセグメント
:: 第3引数 1番目のプロジェクターのIPアドレスの末尾


@echo off
setlocal

:: 変数に引数を代入
set pj_count=%1
set ip_segment=%2
set first_pj_ip=%3

set /a last_pj_ip=%first_pj_ip%+%pj_count%-1

:: ADBのパス、ネットワーク接続の際のポート設定
set adbPath=C:\Tools\platform-tools\adb.exe
set port=5555

:: 一旦接続をクリアするためにadbサーバーを終了する
%adbPath% kill-server

:: プロジェクターの入力をHDMI1にする操作を台数分繰り返す
for /l %%i in (%first_pj_ip%, 1, %last_pj_ip%) do (
    %adbPath% connect %ip_segment%.%%i:%port%
    %adbPath% -s %ip_segment%.%%i:%port% shell input keyevent ENTER

    timeout /t 3 > nul

    %adbPath% -s %ip_segment%.%%i:%port% shell input keyevent ENTER
)

echo プロジェクターの入力をHDMI1に切り替えました。