:: ���e���J�n���邽�߁A�v���W�F�N�^�[���N�����A���͂�IDMI1�ɐ؂�ւ���o�b�`�t�@�C��

:: ��1���� IP Power �̌^ 9255 or 9258 ���w��
:: ��2���� IP Power ��IP�A�h���X


@echo off
cd %~dp0
setlocal

:: �ϐ��Ɉ�������
set ip_power_type=%1
set ip_power_ip_address=%2

:: IP Power �̃v���O��ON�ɐݒ�
if "%ip_power_type%"=="9255" (
    call set_plug_power_9255.bat 1 %ip_power_ip_address%
) else if "%ip_power_type%"=="9258" (
    call set_plug_power_9258.bat 1 %ip_power_ip_address% 
)