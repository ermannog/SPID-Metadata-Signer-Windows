# SPID Metadata Signer in ambiente Windows

Lo script **01-CreateSelfSignedCert-Test.cmd** permette di generare un certificato digitale autofirmato tramite [OpenSSL](https://www.openssl.org/)
Lo script **02-MetadataSign-Test.cmd** permette di firmare un metadata SAML utilizzando [XmlSecTool V2](https://wiki.shibboleth.net/confluence/display/XSTJ2/xmlsectool+V2+Home)

## Requisiti per utilizzare lo script 01-CreateSelfSignedCert-Test.cmd
* [OpenSSL](https://slproweb.com/products/Win32OpenSSL.html) la versione a 64 bit è disponibile nella directory *OpenSSL*

## Requisiti per utilizzare lo script 02-MetadataSign-Test.cmd
* [XmlSecTool V2](http://shibboleth.net/downloads/tools/xmlsectool/latest/xmlsectool-2.0.0-bin.zip) disponibile nella directory *XmlSecTool*
* [Java 8](https://www.java.com/it/download/manual.jsp)
* Metadata compliant alle [Regole Tecniche SPID](http://spid-regole-tecniche.readthedocs.io/en/latest/)
* Chiave e certificato di firma generati con lo script **01-CreateSelfSignetCert-Test.cmd** (in alternativa è possibile usare anche quello utilizzato per la firma delle asserzioni saml)

### Note Generali

* Gli scripts funzionano su sistemi Windows 
* Nella directory *Metadata* è presente un esempio di metadata non firmato (agid-spid-esempio-metadata.xml) e di uno firmato (agid-spid-esempio-metadata-signed.xml) copiati dal repository GitHub [italia/spid-metadata-signer](https://github.com/italia/spid-metadata-signer)
* Nella cartella *Certs* è presente una chiave senza password (ComuneVigata-SPID-nopass.key) e un certificato di prova (ComuneVigata-SPID.crt) generati con lo script **01-CreateSelfSignedCert-Test.cmd**
* Per l'utlizzo degli scrits crearne una copia e modificare la sezione *"Impostazioni"* e se necessario la sezione *"Configurazioni"* come descritto successivamente nelle sezioni **Note di utilizzo dello script 01-CreateSelfSignedCert-Test.cmd** e **Note di utilizzo dello script 02-MetadataSign-Test.cmd**
