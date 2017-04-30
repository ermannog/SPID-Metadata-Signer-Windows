REM *** Impostazioni ***
SET Subject="/C=IT/ST=Montelusa/L=Vigata/O=Comune di Vigata/OU=Spid/CN=comune.vigata.gov.it/emailAddress=spid@comune.vigata.gov.it"
SET Password=P@ssW0rd!
SET FileName=ComuneVigata-SPID
SET KeyLenght=4096
SET ValidityDays=1095
SET SHABits=256

REM *** Configurazioni ***
SET OpenSSBinPath=%~dp0OpenSSL\OpenSSL-Win64-1_1_0e\bin
SET CertsPath=%~dp0Certs

%OpenSSBinPath%\openssl req -x509 -sha%SHABits% -days %ValidityDays% -newkey rsa:%KeyLenght% -keyout %CertsPath%\%FileName%.key -out %CertsPath%\%FileName%.crt -passout pass:%Password% -subj %Subject% -config %OpenSSBinPath%\openssl.cfg

%OpenSSBinPath%\openssl rsa -in %CertsPath%\%FileName%.key -out %CertsPath%\%FileName%-nopass.key -passin pass:%Password%

pause