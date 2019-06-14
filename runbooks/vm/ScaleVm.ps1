<#
.SYNOPSIS
  Conecta no Azure e escala a VM certicalmente.

.DESCRIPTION
  Este runbook conecta no Azure e escala a VM verticalmente. 

  CONFIGURAÇÕES NECESSÁRIAS
  1. Criar uma variável de automação chamada "AzureSubscriptionId" contendo o GUID da sua assinatura do Azure.  
  2. Criar uma credencial de automação chamada "AzureCredential" contendo as credenciais de um usuário do Azure AD com perfil de acesso. 
     (Se a conta for uma conta Microsoft não funciona, necessário criar um novo usuário)
  3. Se os módulos estiverem desatualizados dará erro ao redimensionar a VM para discos gerenciados. Irá dar um erro no arquivo vhd.

.PARAMETER ResourceGroupName
   Required 
   Nome do grupo de recurso.

.PARAMETER VmName
   Required 
   Nome da VM.

.PARAMETER VmSize
   Required 
   Tamanho da VM (Exemplo: Standard_DS1_V2, Standard_F4s).
#>

param (
	[parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [parameter(Mandatory = $true)]
    [string]$VmName,

    [parameter(Mandatory = $true)]
    [string]$VmSize
)   
    # Conecta no Azure e seleciona a assinatura
    $Cred = Get-AutomationPSCredential -Name 'AzureCredential'
    $null = Add-AzureRmAccount -Credential $Cred -ErrorAction Stop
    
    $SubId = Get-AutomationVariable -Name 'AzureSubscriptionId'
    $null = Set-AzureRmContext -SubscriptionId $SubId -ErrorAction Stop

    #Atualiza o tamanho do disco
    #$disk = Get-AzureRmDisk -ResourceGroupName $ResourceGroupName -DiskName $DiskName
    #New-AzureRmDiskUpdateConfig -DiskSizeGB 1023 | Update-AzureRmDisk -ResourceGroupName $ResourceGroupName -DiskName $DiskName -Disk $disk
		
    try {
        $vm = Get-AzureRmVm -ResourceGroupName $ResourceGroupName -VMName $VmName -ErrorAction Stop
    } catch {
        Write-Error "Máquina virtual não encontrada"
        exit
    }
    $currentVMSize = $vm.HardwareProfile.vmSize
		
    Write-Output "`nMáquina virtual encontrada: $VmName"
    Write-Output "Tamanho atual: $currentVMSize"
    
    Write-Output "`nNovo tamanho será: $VmSize"
        
    $vm.HardwareProfile.VmSize = $VmSize
    Update-AzureRmVm -VM $vm -ResourceGroupName $ResourceGroupName

    Write-Output "`nVerificando o tamanho"
    
    $updatedVm = Get-AzureRmVm -ResourceGroupName $ResourceGroupName -VMName $VmName
    $updatedVMSize = $updatedVm.HardwareProfile.vmSize
    
    Write-Output "`nTamanho alterado para: $updatedVMSize"	