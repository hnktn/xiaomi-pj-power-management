:: IP Power 9255Pro �̃v���O��ON/OFF�𐧌䂷��o�b�`�t�@�C��

:: ��1���� �v���O��ON/OFF
:: ��2���� IP Power 9255Pro ��IP�A�h���X
:: ��3����(�I�v�V����) IP Power 9255Pro �̃|�[�g (�f�t�H���g: "80")
:: ��4����(�I�v�V����) IP Power 9255Pro �̃��O�C�����[�U�[�� (�f�t�H���g: "admin")
:: ��5����(�I�v�V����) IP Power 9255Pro �̃��O�C���p�X���[�h (�f�t�H���g: "12345678")


@echo off
setlocal

:: �ϐ��Ɉ�������
set power=%1
set ip=%2

set port=%3
if "%port%"=="" (set port=80) 

:: IP Power�̃��O�C��������́B�f�t�H���g�Ń��[�U�[����"admin"�A�p�X���[�h��"12345678"
set user = %4
if "%user%"=="" (set user=admin) 

set password = %5
if "%password%"=="" (set password=12345678) 

:: curl��IP Power��HTTP���N�G�X�g�𑗂�B9255Pro�̓v���O��1�Ȃ��߁Asetpower�R�}���h�Ŏw�肷��v���O��1�B
curl http://%user%:%password%@%ip%:%port%/set.cmd?cmd=setpower+p61=%power%

if "%power%"=="1" (
    echo �v���O��ON�ɂ��܂����B
) else if "%power%"=="0" (
    echo �v���O��OFF�ɂ��܂����B
)