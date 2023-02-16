@chcp 65001 > nul


:: Avoisys社製 IP Power 9255Pro / 9258T+Ping のプラグのON/OFFを制御するバッチファイル 

:: 使用方法 : set_plug_power [オプション] <power> <type> <ip_address> [port] [user] [password] 
::  -h, --help 使用方法を表示します 
:: <power>      : プラグの ON/OFF を 1/0 で指定 
:: <type>       : IP Power の型 9255 or 9258 を指定 
:: <ip_address> : IP Power のIPアドレス 
:: [port]       : (オプション) IP Power のポート (デフォルト: "80") 
:: [user]       : (オプション) IP Power のログインユーザー名 (デフォルト: "admin") 
:: [password]   : (オプション) IP Power のログインパスワード (デフォルト: "12345678") 


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
set expected_min_args=3
set expected_max_args=6

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
set type=%2
set ip=%3

set port=%4
if "%port%"=="" (set port=80)

:: IP Powerのログイン情報を入力 
:: デフォルトでユーザー名は"admin"、パスワードは"12345678" 
set user = %5
if "%user%"=="" (set user=admin)

set password = %6
if "%password%"=="" (set password=12345678)

:: curlでIP PowerにHTTPリクエストを送る
if "%type%"=="9255" (
    :: 9255Proはプラグが1つなため、setpowerコマンドで指定するプラグは1つ 
    curl http://%user%:%password%@%ip%:%port%/set.cmd?cmd=setpower+p61=%power% > nul 2>&1
) else if "%type%"=="9258" (
    :: 9258T+Pingはプラグが4つなため、setpowerコマンドで指定するプラグは4つ 
    curl http://%user%:%password%@%ip%:%port%/set.cmd?cmd=setpower+p61=%power%+p62=%power%+p63=%power%+p64=%power% > nul 2>&1
)

if not %errorlevel%==0 (
    echo IP PowerのIPアドレスが間違っています 
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
echo 使用方法 : %selfname% [オプション] ^<power^> ^<type^> ^<ip_address^> [port] [user] [password] 
echo  -h, --help 使用方法を表示します 
echo ^<power^>      : プラグの ON/OFF を 1/0 で指定 
echo ^<type^>       : IP Power の型 9255 or 9258 を指定 
echo ^<ip_address^> : IP Power のIPアドレス 
echo [port]       : (オプション) IP Power のポート (デフォルト: "80") 
echo [user]       : (オプション) IP Power のログインユーザー名 (デフォルト: "admin") 
echo [password]   : (オプション) IP Power のログインパスワード (デフォルト: "12345678") 
exit /b