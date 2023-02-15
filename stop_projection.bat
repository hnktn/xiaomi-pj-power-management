@chcp 65001 > nul


:: 投影を終了するため、プロジェクターを安全にシャットダウンするためのバッチファイル 

:: 第1引数 IP Power の型 9255 or 9258 を指定 
:: 第2引数 IP Power のIPアドレス 
:: 第3引数 プロジェクターの台数 
:: 第4引数 ゲートウェイのIPアドレスの最初の3つのセグメント  
:: 第5引数 1番目のプロジェクターのIPアドレスの末尾 


@echo off
setlocal

pushd %~dp0

:: 変数に引数を代入 
set ip_power_type=%1
set ip_power_ip_address=%2
set pj_count=%3
set ip_segment=%4
set first_pj_ip=%5

:: プロジェクターをシャットダウン 
call shutdown_projector.bat %pj_count% %ip_segment% %first_pj_ip%

:: IP Power のプラグをOFFに設定 
if "%ip_power_type%"=="9255" (
    call set_plug_power_9255.bat 0 %ip_power_ip_address%
) else if "%ip_power_type%"=="9258" (
    call set_plug_power_9258.bat 0 %ip_power_ip_address% 
)