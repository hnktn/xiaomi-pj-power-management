:: Xiaomi Mi Laser UST Projector 150" ��ADB�R�}���h�ň��S�ɃV���b�g�_�E������o�b�`�t�@�C��
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

:: ADB�̃|�[�g�ݒ�
set port=5555

:: ��U�ڑ����N���A���邽�߂�adb�T�[�o�[���I������
adb kill-server

:: �v���W�F�N�^�[���V���b�g�_�E�����鑀���䐔���J��Ԃ�
for /l %%i in (%first_pj_ip%, 1, %last_pj_ip%) do (
    adb connect %ip_segment%.%%i:%port%
    adb -s %ip_segment%.%%i:%port% shell reboot -p
)

:: �v���W�F�N�^�[���V���b�g�_�E������܂őҋ@
echo �v���W�F�N�^�[���V���b�g�_�E������̂�҂��Ă��܂��B
timeout /t 10 /nobreak > nul
echo �v���W�F�N�^�[���V���b�g�_�E�����܂����B