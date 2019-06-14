<#
.SYNOPSIS
  Conecta no Azure e inicia ou para VMs

.DESCRIPTION
  Este runbook conecta no Azure e inicia ou para VMs 

  CONFIGURAÇÕES NECESSÁRIAS
  1. Criar uma variável de automação chamada "AzureSubscriptionId" contendo o GUID da sua assinatura do Azure.  
  2. Criar uma credencial de automação chamada "AzureCredential" contendo as credenciais de um usuário do Azure AD com perfil de acesso. 
     (Se a conta for uma conta Microsoft não funciona, necessário criar um novo usuário)

.PARAMETER AzureVMList
   Required 
   Passar o nome das VMs separadas por vírgula.

.PARAMETER Action
   Required 
   Passar "Stop" para parar a VM ou "Start" para iniciar a VM.
#>

Workflow Stop-Start-AzureVM 
{ 
    Param 
    (    
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] 
        [String] 
        $AzureVMList, 
        [Parameter(Mandatory=$true)][ValidateSet("Start","Stop")] 
        [String] 
        $Action 
    ) 
        
    $credential = Get-AutomationPSCredential -Name 'AzureCredential' 
    Login-AzureRmAccount -Credential $credential 

    $AzureSubscriptionId = Get-AutomationVariable -Name 'AzureSubscriptionId'
    Write-Output "Usando Assinatura [$AzureSubscriptionId]"
    Select-AzureRmSubscription -SubscriptionId $AzureSubscriptionId 

    $AzureVMs = $AzureVMList.Split(",") 
    [System.Collections.ArrayList]$AzureVMsToHandle = $AzureVMs 

    foreach($AzureVM in $AzureVMsToHandle) 
    { 
        if(!(Get-AzureRmVM | ? {$_.Name -eq $AzureVM})) 
        { 
            throw " AzureVM : [$AzureVM] - não existe! - Verifique os parâmetros. " 
        } 
    } 

    if($Action -eq "Stop") 
    { 
        Write-Output "Parando VMs"; 
        foreach -parallel ($AzureVM in $AzureVMsToHandle) 
        { 
            Get-AzureRmVM | ? {$_.Name -eq $AzureVM} | Stop-AzureRmVM -Force 
        } 
    } 
    else 
    { 
        Write-Output "Iniciado VMs"; 
        foreach -parallel ($AzureVM in $AzureVMsToHandle) 
        { 
            Get-AzureRmVM | ? {$_.Name -eq $AzureVM} | Start-AzureRmVM 
        } 
    } 
}