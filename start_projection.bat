:: 投影を開始するため、プロジェクターを起動し、入力をIDMI1に切り替えるバッチファイル

:: 第1引数 IP Power の型 9255 or 9258 を指定
:: 第2引数 IP Power のIPアドレス
:: 第3引数 プロジェクターの台数
:: 第4引数 ローカルネットワークのIPセグメント
:: 第5引数 1番目のプロジェクターのIPアドレスの末尾


@echo off
setlocal

:: 変数に引数を代入
set ip_power_type=%1
set ip_power_ip_address=%2
set pj_count=%3
set ip_segment=%4
set first_pj_ip=%5

:: IP Power のプラグをONに設定
if "%ip_power_type%"=="9255" (
    call set_plug_power_9255.bat 1 %ip_power_ip_address%
) else if "%ip_power_type%"=="9258" (
    call set_plug_power_9258.bat 1 %ip_power_ip_address% 
)

:: プロジェクターが起動するまで待機
echo プロジェクターが起動するのを待っています。
timeout /t 55 /nobreak > nul
echo プロジェクターが起動しました。

:: プロジェクターの入力をHDMI1に切り替え
call change_projector_input.bat %pj_count% %ip_segment% %first_pj_ip%