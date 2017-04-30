# SPID Metadata Signer in ambiente Windows

Gli scritps permettono la generazione di un certificato digitale autofirmato e la firma di un metadata SAML:
* Lo script **01-CreateSelfSignedCert-Test.cmd** permette di generare un certificato digitale autofirmato tramite [OpenSSL](https://www.openssl.org/)
* Lo script **02-MetadataSign-Test.cmd** permette di firmare un metadata SAML utilizzando [XmlSecTool V2](https://wiki.shibboleth.net/confluence/display/XSTJ2/xmlsectool+V2+Home)

## Requisiti per utilizzare lo script 01-CreateSelfSignedCert-Test.cmd
* [OpenSSL](https://slproweb.com/products/Win32OpenSSL.html) la versione a 64 bit è disponibile nella directory *OpenSSL*

## Requisiti per utilizzare lo script 02-MetadataSign-Test.cmd
* [XmlSecTool V2](http://shibboleth.net/downloads/tools/xmlsectool/latest/xmlsectool-2.0.0-bin.zip) disponibile nella directory *XmlSecTool*
* [Java 8](https://www.java.com/it/download/manual.jsp)
* Metadata compliant alle [Regole Tecniche SPID](http://spid-regole-tecniche.readthedocs.io/en/latest/)
* Chiave e certificato di firma generati con lo script **01-CreateSelfSignetCert-Test.cmd** (in alternativa è possibile usare anche quello utilizzato per la firma delle asserzioni saml)

## Note Generali

* Gli scripts funzionano su sistemi Windows 
* Nella directory *Metadata* è presente un esempio di metadata non firmato (agid-spid-esempio-metadata.xml) e di uno firmato (agid-spid-esempio-metadata-signed.xml) copiati dal repository GitHub [italia/spid-metadata-signer](https://github.com/italia/spid-metadata-signer)
* Nella cartella *Certs* è presente una chiave senza password (ComuneVigata-SPID-nopass.key) e un certificato di prova (ComuneVigata-SPID.crt) generati con lo script **01-CreateSelfSignedCert-Test.cmd**
* Per l'utlizzo degli scrits crearne una copia e modificare la sezione *"Impostazioni"* e se necessario la sezione *"Configurazioni"* come descritto successivamente nelle sezioni **Note di utilizzo dello script 01-CreateSelfSignedCert-Test.cmd** e **Note di utilizzo dello script 02-MetadataSign-Test.cmd**

## Note di utilizzo dello script 01-CreateSelfSignedCert-Test.cmd
Lo script crea un certificato autofirmato mediante l'utilizzo di OpenSSL che deve essere presente nella directory *OpenSSl* le impostazioni con cui verrà generato il certificato sono riportate nella sezione *"Impostazioni"*.
Nello script **01-CreateSelfSignedCert-Test.cmd** le impostazioni sono impostate per la creazione di un certificato autofirmato per il *Comune di Vigata* con chiave di cifratura di 4096 Bits, SHA di 256 Bits, validità di 1095 giorni (3 anni) e prefisso per i file generati pari a *ComuneVigate-SPID*.
Lo script **01-CreateSelfSignedCert-Test.cmd** genererà nella directory *Certs* un file chiave privata protetta dalla password *P@ssW0rd!* denominato *ComuneVigata-SPID.key*, un file per la chiave privata non protetto da password denominato *ComuneVigata-SPID-nopass.key* e un file per la chiave pubblica denominato *ComuneVigata-SPID.crt*

```
REM *** Impostazioni ***
SET Subject="/C=IT/ST=Montelusa/L=Vigata/O=Comune di Vigata/OU=Spid/CN=comune.vigata.gov.it/emailAddress=spid@comune.vigata.gov.it"
SET Password=P@ssW0rd!
SET FileName=ComuneVigata-SPID
SET KeyLenght=4096
SET ValidityDays=1095
SET SHABits=256
```

Le configurazioni relative al path di OpenSSL e della directory *Certs* sono riportate nella sezione *"Configurazioni"*.
Nello script **01-CreateSelfSignedCert-Test.cmd** le configurazioni sono impostate per utilizzare OpenSSL v1.1.0e Light a 64 Bits presente nella directory *OpenSSL\OpenSSL-Win64-1_1_0e\bin* 

```
REM *** Configurazioni ***
SET OpenSSBinPath=%~dp0OpenSSL\OpenSSL-Win64-1_1_0e\bin
SET CertsPath=%~dp0Certs
```

## Note di utilizzo dello script 02-MetadataSign-Test.cmd
Lo script firma un file di metadata SAML mediante l'utilizzo di XmlSecTool V2 che deve essere presente nella directory *XmlSecTool*  le impostazioni con cui verrà firmato il file riportate nella sezione *"Impostazioni"*.
Nello script **02-MetadataSign-Test.cmd** le impostazioni sono impostate per la firma di un file metadata SAML denominato *agid-spid-esempio-metadata.xml* presente nella directory *Metadata*, creando il file metadata SAML denominato *agid-spid-esempio-metadata-signed-ComuneVigata-SPID.xml* nella cartella *Metadata*.
Lo script **02-MetadataSign-Test.cmd** utilizzerà per firmare il file metadata SAML il certificato con il file per la chiave privata non protetto da password denominato *ComuneVigata-SPID-nopass.key* e il file per la chiave pubblica denominato *ComuneVigata-SPID.crt* entrambi presenti nella directory *Certs*.

```
REM *** Impostazioni ***
SET MetadataUnsignedFile=agid-spid-esempio-metadata.xml
SET MetadataSignedFile=agid-spid-esempio-metadata-signed-ComuneVigata-SPID.xml
SET CertCRTFile=ComuneVigata-SPID.crt
SET CertKeyFileNoPass=ComuneVigata-SPID-nopass.key
```
