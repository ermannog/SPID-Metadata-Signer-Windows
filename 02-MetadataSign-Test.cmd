REM *** Impostazioni ***
SET MetadataUnsignedFile=agid-spid-esempio-metadata.xml
SET MetadataSignedFile=agid-spid-esempio-metadata-signed-ComuneVigata-SPID.xml
SET CertCRTFile=ComuneVigata-SPID.crt
SET CertKeyFileNoPass=ComuneVigata-SPID-nopass.key

REM *** Configurazioni ***
SET MetadataPath=%~dp0Metadata
SET CertsPath=%~dp0Certs
SET XmlSecToolPath=%~dp0XmlSecTool\xmlsectool-2.0.0
SET CLASSPATH=%XmlSecToolPath%\lib\*

CLS
@ECHO OFF

ECHO Firma file metadata %MetadataUnsignedFile% con il certificato %CertCRTFile:~0,-4%
ECHO.

IF EXIST %MetadataPath%\%MetadataSignedFile% CHOICE /C:SN /M "Sovrascrivere il file metadata firmato %MetadataSignedFile% esistente?"
IF ERRORLEVEL 2 GOTO END

java -Xmx256m net.shibboleth.tool.xmlsectool.XMLSecTool --sign --referenceIdAttributeName ID --inFile "%MetadataPath%\%MetadataUnsignedFile%" --outFile "%MetadataPath%\%MetadataSignedFile%" --digest SHA-256 --signatureAlgorithm http://www.w3.org/2001/04/xmldsig-more#rsa-sha256 --key "%CertsPath%\%CertKeyFileNoPass%" --certificate "%CertsPath%\%CertCRTFile%"

PAUSE

:END