REM *** Impostazioni ***
SET Subject="/C=IT/ST=Montelusa/L=Vigata/O=Comune di Vigata/OU=Spid/CN=comune.vigata.gov.it/emailAddress=spid@comune.vigata.gov.it"
SET Password=P@ssW0rd!
SET FileName=ComuneVigata-SPID
SET KeyLenght=4096
SET ValidityDays=1095
SET SHABits=256

REM *** Configurazioni ***
SET OpenSSBinPath=%~dp0OpenSSL\OpenSSL-Win64-1_1_0e\bin
SET OPENSSL_CONF=%OpenSSBinPath%\openssl.cfg
SET CertsPath=%~dp0Certs

CLS
@ECHO OFF

ECHO Creazione certificato RSA autofirmato %FileName%
ECHO Key=%KeyLenght% bits, SHA=%SHABits% bits, Validity=%ValidityDays% days
ECHO.

IF EXIST %CertsPath%\%FileNAme%.key CHOICE /C:SN /M "Sovrascrivere il certificato esistente?"
IF ERRORLEVEL 2 GOTO END

REM Creazione file chiave privata (.key) protetta da password e chiave pubblica (*.crt)
%OpenSSBinPath%\openssl req -x509 -sha%SHABits% -days %ValidityDays% -newkey rsa:%KeyLenght% -keyout %CertsPath%\%FileName%.key -out %CertsPath%\%FileName%.crt -passout pass:%Password% -subj %Subject%

REM Creazione file chiave privata non protetta da password (*-nopass.key)
%OpenSSBinPath%\openssl rsa -in %CertsPath%\%FileName%.key -out %CertsPath%\%FileName%-nopass.key -passin pass:%Password%

PAUSE

:END