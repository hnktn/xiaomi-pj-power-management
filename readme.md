# Xiaomi PJ Power Management
Xiaomi Mi Laser UST Projector 150" を自動運用するために Aviosys社製のリモート電源制御装置 IP Power と ADBコマンドを使って自動起動と自動シャットダウンを実現するバッチファイル群です。

# 必要事項
- プロジェクターに Projectivy Launcher がインストールされていて、起動時の入力がHDMI1に設定されていること
- ADBのPATHが通っていること
- プロジェクターのUSBデバッグが有効になっていること
- プロジェクターのIPアドレスは連続していること（例：192.168.0.11～192.168.0.14）
- 使用するリモート電源制御装置は IP Power 9255Pro もしくは IP Power 9258T+Ping
- IP Power のログインユーザー、パスワードはデフォルトの `admin` ・ `12345678` であること
- IP Power のポート番号はデフォルトの `80` であること

# 使用方法
## 投影を開始する
コマンドプロンプトで`start_projection.bat`を実行します。
```
start_projection [オプション] <ip_power_type> <ip_power_ip_address>
```

`start_projection.bat`は2つの引数を必要とします。

- `<ip_power_type>` : IP Power の型 `9255` or `9258` を指定
- `<ip_power_ip_address>` : IP Power のIPアドレス

オプション
  - `-h, --help` 使用方法を表示します

例：IP Power 9258T+Ping（`192.168.0.100`）を使用してプロジェクターを起動する場合
```
start_projection 9258 192.168.0.100
```

## 投影を終了する
コマンドプロンプトで`stop_projection.bat`を実行します。
```
stop_projection [オプション] <ip_power_type> <ip_power_ip_address> <pj_count> <ip_segment> <first_pj_ip>
```
`stop_projection.bat`は5つの引数を必要とします。

- `<ip_power_type>`       : IP Power の型 `9255` or `9258` を指定
- `<ip_power_ip_address>` : IP Power のIPアドレス
- `<pj_count>`            : プロジェクターの台数
- `<ip_segment>`          : ゲートウェイのIPアドレスの最初の3つのセグメント（例：ゲートウェイのIPアドレスが `192.168.0.1` の場合、`192.168.0`） 
- `<first_pj_ip>`         : 1番目のプロジェクターのIPアドレスの末尾（例：プロジェクターのIPアドレスを `192.168.0.11` ～ `192.168.0.14` と設定した場合、`11`）

オプション
  - `-h, --help` 使用方法を表示します


例：IP Power 9258T+Ping（`192.168.0.100`）を使用して4台のプロジェクター（`192.168.0.11` ～ `192.168.0.14`）をシャットダウンする場合
```
stop_projection 9258 192.168.0.100 4 192.168.0 11
```
