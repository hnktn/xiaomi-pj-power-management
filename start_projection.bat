@chcp 65001 > nul

:: 投影を開始するため、プロジェクターを起動し、入力をIDMI1に切り替えるバッチファイル 

:: 第1引数 IP Power の型 9255 or 9258 を指定 
:: 第2引数 IP Power のIPアドレス 


@echo off
setlocal

pushd %~dp0

:: 変数に引数を代入 
set ip_power_type=%1
set ip_power_ip_address=%2

:: IP Power のプラグをONに設定 
if "%ip_power_type%"=="9255" (
    call set_plug_power_9255.bat 1 %ip_power_ip_address%
) else if "%ip_power_type%"=="9258" (
    call set_plug_power_9258.bat 1 %ip_power_ip_address% 
)