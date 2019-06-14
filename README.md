# azure.scripts
Scripts para trabalhar com Azure, VMs visando automação

##PowerShell##

### VMs
**install-iis-aspnet45-urlrewrite.ps1**

Instala o IIS e módulos adicionais:
 * Instala o IIS e dependências para executar aplicações em ASP.NET 4.5
 * Habilita o módulo Request Monitor no IIS
 * Habilita os módulos Static e Dynamic Content Compression no IIS
 * Habilita o módulo HTTP Redirection no IIS
 * Habilita o módulo IP and Domain Restrictions no IIS
 * Habilita o módulo IIS 6 Metabase Compatibility no IIS
 * Habilita o módulo Basic Authentication no IIS
 * Habilita o módulo HTTP Activation do WCF Services (Permite executar WCF no IIS)
 * Instala o Web Platform Installer no IIS
 * Habilita o módulo URL Rewrite no IIS

##Runbooks##

### VMs
**ScaleVM.ps1**

Runbook para escalar verticalmente uma VM no Azure. 

Criar como _Runbook do PowerShell_.

**Stop-Start-AzureVM.ps1**

Runbook para iniciar ou parar uma VM no Azure.

Criar como _Runbook de Fluxo de Trabalho do PowerShell_.
