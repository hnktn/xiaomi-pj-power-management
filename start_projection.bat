:: ���e���J�n���邽�߁A�v���W�F�N�^�[���N�����A���͂�IDMI1�ɐ؂�ւ���o�b�`�t�@�C��

:: ��1���� IP Power �̌^ 9255 or 9258 ���w��
:: ��2���� IP Power ��IP�A�h���X
:: ��3���� �v���W�F�N�^�[�̑䐔
:: ��4���� ���[�J���l�b�g���[�N��IP�Z�O�����g
:: ��5���� 1�Ԗڂ̃v���W�F�N�^�[��IP�A�h���X�̖���


@echo off
setlocal

:: �ϐ��Ɉ�������
set ip_power_type=%1
set ip_power_ip_address=%2
set pj_count=%3
set ip_segment=%4
set first_pj_ip=%5

:: IP Power �̃v���O��ON�ɐݒ�
if "%ip_power_type%"=="9255" (
    call set_plug_power_9255.bat 1 %ip_power_ip_address%
) else if "%ip_power_type%"=="9258" (
    call set_plug_power_9258.bat 1 %ip_power_ip_address% 
)

:: �v���W�F�N�^�[���N������܂őҋ@
echo �v���W�F�N�^�[���N������̂�҂��Ă��܂��B
timeout /t 55 /nobreak > nul
echo �v���W�F�N�^�[���N�����܂����B

:: �v���W�F�N�^�[�̓��͂�HDMI1�ɐ؂�ւ�
call change_projector_input.bat %pj_count% %ip_segment% %first_pj_ip%