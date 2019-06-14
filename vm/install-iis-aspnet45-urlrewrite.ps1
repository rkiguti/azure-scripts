Dism /Online /Enable-Feature /FeatureName:IIS-ASPNET45 /All
Dism /Online /Enable-Feature /FeatureName:IIS-RequestMonitor /All
Dism /Online /Enable-Feature /FeatureName:IIS-Performance /All
Dism /Online /Enable-Feature /FeatureName:IIS-HttpRedirect /All
Dism /Online /Enable-Feature /FeatureName:IIS-IPSecurity /All
Dism /Online /Enable-Feature /FeatureName:IIS-Metabase /All
Dism /Online /Enable-Feature /FeatureName:IIS-HttpCompressionDynamic /All
Dism /Online /Enable-Feature /FeatureName:IIS-BasicAuthentication /All
Dism /Online /Enable-Feature /FeatureName:WCF-HTTP-Activation45 /All

$wpi = "http://download.microsoft.com/download/F/4/2/F42AB12D-C935-4E65-9D98-4E56F9ACBC8E/wpilauncher.exe"
Invoke-WebRequest -URI $wpi -OutFile "$env:temp\wpilauncher.exe"

$install = Start-Process -FilePath "$env:temp\wpilauncher.exe"

Start-Sleep -Seconds 25

Get-Process WebPlatformInstaller | Stop-Process -Force

$WebPICMD = 'C:\Program Files\Microsoft\Web Platform Installer\WebpiCmd-x64.exe'
Start-Process -wait -FilePath $WebPICMD -ArgumentList "/install /Products:UrlRewrite2 /AcceptEula /OptInMU /SuppressPostFinish"