# Xiaomi PJ Power Management
Xiaomi Mi Laser UST Projector 150" を自動運用するために Aviosys社製のリモート電源制御装置 IP Power と ADBコマンドを使って自動起動と自動シャットダウンを実現するバッチファイル群です。

# 必要事項
- プロジェクターに Projectivy Launcher がインストールされていて、起動時の入力がHDMI1に設定されていること
- ADBのPATHが通っていること
- プロジェクターのUSBデバッグが有効になっていること
- プロジェクターのIPアドレスは連続していること（例：192.168.0.11～192.168.0.14）
- 使用するリモート電源制御装置は IP Power 9255Pro もしくは IP Power 9258T+Ping

# 使い方
## 投影を開始する
コマンドプロンプトで`start_projection.bat`を実行します。
```
start_projection.bat <ip_power_type> <ip_power_ip_address>
```
`start_projection.bat`は2つの引数を必要とします。

- 第1引数 IP Power の型 `9255` or `9258` を指定
- 第2引数 IP Power のIPアドレス

例：IP Power 9258T+Ping（`192.168.0.100`）を使用してプロジェクターを起動する場合
```
start_projection.bat 9258 192.168.0.100
```

## 投影を終了する
コマンドプロンプトで`stop_projection.bat`を実行します。
```
stop_projection.bat <ip_power_type> <ip_power_ip_address> <pj_count> <ip_segment> <first_pj_ip>
```
`stop_projection.bat`は5つの引数を必要とします。

- 第1引数 IP Power の型 `9255` or `9258` を指定
- 第2引数 IP Power のIPアドレス
- 第3引数 プロジェクターの台数
- 第4引数 ゲートウェイのIPアドレスの最初の3つのセグメント（例：ゲートウェイのIPアドレスが`192.168.0.1`の場合、`192.168.0`）
- 第5引数 1番目のプロジェクターのIPアドレスの末尾（例：プロジェクターのIPアドレスを`192.168.0.11`～`192.168.0.14`と設定した場合、`11`）

例：IP Power 9258T+Ping（`192.168.0.100`）を使用して4台のプロジェクター（`192.168.0.11`～`192.168.0.14`）をシャットダウンする場合
```
stop_projection.bat 9258 192.168.0.100 4 192.168.0 11
```
