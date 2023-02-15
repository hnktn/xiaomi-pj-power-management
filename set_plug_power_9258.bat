@chcp 65001 > nul


:: IP Power 9258T+Ping のプラグのON/OFFを制御するバッチファイル 

:: 第1引数 プラグのON/OFF 
:: 第2引数 IP Power 9258T+Ping のIPアドレス 
:: 第3引数(オプション) IP Power 9258T+Ping のポート (デフォルト: "80") 
:: 第4引数(オプション) IP Power 9258T+Ping のログインユーザー名 (デフォルト: "admin") 
:: 第5引数(オプション) IP Power 9258T+Ping のログインパスワード (デフォルト: "12345678") 


@echo off
setlocal

:: 変数に引数を代入 
set power=%1
set ip=%2

set port=%3
if "%port%"=="" (set port=80) 

:: IP Powerのログイン情報を入力。デフォルトでユーザー名は"admin"、パスワードは"12345678" 
set user = %4
if "%user%"=="" (set user=admin) 

set password = %5
if "%password%"=="" (set password=12345678) 

:: curlでIP PowerにHTTPリクエストを送る。9258T+Pingはプラグが4つなため、setpowerコマンドで指定するプラグは4つ。 
curl \http://%user%:%password%@%ip%:%port%/set.cmd?cmd=setpower+p61=%power%+p62=%power%+p63=%power%+p64=%power% > nul

if "%power%"=="1" (
    echo プラグをONにしました。 
) else if "%power%"=="0" (
    echo プラグをOFFにしました。 
)