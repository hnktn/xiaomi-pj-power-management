:: Xiaomi Mi Laser UST Projector 150" �̓��͂�ADB�R�}���h��HDMI1�ɕύX����o�b�`�t�@�C��
:: ���v���W�F�N�^�[�̃z�[����ʂ̂��C�ɓ����1�Ԗڂ� Projectivy Launcher ���ݒ肳��Ă��邱��
:: ���v���W�F�N�^�[��USB�f�o�b�O���L���ɂȂ��Ă��邱��

:: ��1���� �v���W�F�N�^�[�̑䐔
:: ��2���� ���[�J���l�b�g���[�N��IP�Z�O�����g
:: ��3���� 1�Ԗڂ̃v���W�F�N�^�[��IP�A�h���X�̖���


@echo off
setlocal

:: �ϐ��Ɉ�������
set pj_count=%1
set ip_segment=%2
set first_pj_ip=%3

set /a last_pj_ip=%first_pj_ip%+%pj_count%-1

:: ADB�̃p�X�A�l�b�g���[�N�ڑ��̍ۂ̃|�[�g�ݒ�
set adbPath=C:\Tools\platform-tools\adb.exe
set port=5555

:: ��U�ڑ����N���A���邽�߂�adb�T�[�o�[���I������
%adbPath% kill-server

:: �v���W�F�N�^�[�̓��͂�HDMI1�ɂ��鑀���䐔���J��Ԃ�
for /l %%i in (%first_pj_ip%, 1, %last_pj_ip%) do (
    %adbPath% connect %ip_segment%.%%i:%port%
    %adbPath% -s %ip_segment%.%%i:%port% shell input keyevent ENTER

    timeout /t 3 > nul

    %adbPath% -s %ip_segment%.%%i:%port% shell input keyevent ENTER
)

echo �v���W�F�N�^�[�̓��͂�HDMI1�ɐ؂�ւ��܂����B