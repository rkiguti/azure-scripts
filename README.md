# azure.scripts
Scripts para trabalhar com Azure, VMs visando automa��o

##PowerShell

### VMs
**install-iis-aspnet45-urlrewrite.ps1**

Instala o IIS e m�dulos adicionais:
 * Instala o IIS e depend�ncias para executar aplica��es em ASP.NET 4.5
 * Habilita o m�dulo Request Monitor no IIS
 * Habilita os m�dulos Static e Dynamic Content Compression no IIS
 * Habilita o m�dulo HTTP Redirection no IIS
 * Habilita o m�dulo IP and Domain Restrictions no IIS
 * Habilita o m�dulo IIS 6 Metabase Compatibility no IIS
 * Habilita o m�dulo Basic Authentication no IIS
 * Habilita o m�dulo HTTP Activation do WCF Services (Permite executar WCF no IIS)
 * Instala o Web Platform Installer no IIS
 * Habilita o m�dulo URL Rewrite no IIS

##Runbooks

### VMs
**ScaleVM.ps1**

Runbook para escalar verticalmente uma VM no Azure. 

Criar como _Runbook do PowerShell_.

**Stop-Start-AzureVM.ps1**

Runbook para iniciar ou parar uma VM no Azure.

Criar como _Runbook de Fluxo de Trabalho do PowerShell_.