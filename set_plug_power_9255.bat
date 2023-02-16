@chcp 65001 > nul


:: IP Power 9255Pro のプラグのON/OFFを制御するバッチファイル 

:: 使用方法 : set_plug_power_9255 [オプション] <power> <ip_address> [port] [user] [password] 
::  -h, --help 使用方法を表示します 
:: <power>      : プラグのON/OFF 
:: <ip_address> : IP Power 9255Pro のIPアドレス 
:: [port]       : (オプション) IP Power 9255Pro のポート (デフォルト: "80") 
:: [user]       : (オプション) IP Power 9255Pro のログインユーザー名 (デフォルト: "admin") 
:: [password]   : (オプション) IP Power 9255Pro のログインパスワード (デフォルト: "12345678") 


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
set expected_min_args=2
set expected_max_args=5

set arg_count=0
for %%x in (%*) do set /a arg_count+=1

if %arg_count% lss %expected_min_args% (
    echo エラー: 引数が不足しています 
    echo "%selfname% --help" で使用方法を確認できます 
    exit /b 1
) else if %arg_count% gtr %expected_max_args% (
    echo エラー: 不要な引数が渡されました 
    echo "%selfname% --help" で使用方法を確認できます 
    exit /b 1
)

:: 変数に引数を代入 
set power=%1
set ip=%2

set port=%3
if "%port%"=="" (set port=80)

:: IP Powerのログイン情報を入力 
:: デフォルトでユーザー名は"admin"、パスワードは"12345678" 
set user = %4
if "%user%"=="" (set user=admin)

set password = %5
if "%password%"=="" (set password=12345678)

:: curlでIP PowerにHTTPリクエストを送る
:: 9255Proはプラグが1つなため、setpowerコマンドで指定するプラグは1つ 
curl http://%user%:%password%@%ip%:%port%/set.cmd?cmd=setpower+p61=%power% > nul 2>&1

if not %errorlevel%==0 (
    echo IPアドレスが間違っています 
    exit /b 1
)

if "%power%"=="1" (
    echo プラグをONにしました 
) else if "%power%"=="0" (
    echo プラグをOFFにしました 
)

exit /b 0


:: サブルーチン 

:usage
echo 使用方法 : %selfname% [オプション] ^<power^> ^<ip_address^> [port] [user] [password] 
echo  -h, --help 使用方法を表示します 
echo ^<power^>      : プラグのON/OFF 
echo ^<ip_address^> : IP Power 9255Pro のIPアドレス 
echo [port]       : (オプション) IP Power 9255Pro のポート (デフォルト: "80") 
echo [user]       : (オプション) IP Power 9255Pro のログインユーザー名 (デフォルト: "admin") 
echo [password]   : (オプション) IP Power 9255Pro のログインパスワード (デフォルト: "12345678") 
exit /b