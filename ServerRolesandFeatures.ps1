Install-WindowsFeature -name Web-Server, Web-Basic-Auth, Web-Dyn-Compression, Web-Mgmt-Tools, Web-Asp-Net45, Web-ISAPI-Filter, Web-WebSockets
##
Install-WindowsFeature -name FS-Resource-Manager
##
Install-WindowsFeature -name Telnet-client
##
Start-Sleep -Seconds 5
##
Remove-IISSite -Name "Default Web Site" -Confirm:$false
Remove-WebAppPool -Name "DefaultAppPool" -Confirm:$false
Remove-Item C:\inetpub\wwwroot\* -Recurse -Force
##
Start-Sleep -Seconds 5
##
Import-Module WebAdministration
Import-Module -Name IISAdministration
New-WebAppPool -Name "B10WEB"
New-WebAppPool -Name "B10ADMIN"
Reset-IISServerManager -Confirm:$false
$sm = Get-IISServerManager
Set-ItemProperty IIS:\AppPools\B10WEB -name Recycling.periodicRestart -value @{time = "00:00:00" }
Set-ItemProperty IIS:\AppPools\B10WEB -name Recycling.periodicRestart.schedule -value @{value = "23:00" }
Set-ItemProperty IIS:\AppPools\B10WEB -name ProcessModel -value @{loadUserProfile = "$True" }
Set-ItemProperty IIS:\AppPools\B10ADMIN -name ProcessModel -value @{IdentityType = "LocalSystem" }
Set-ItemProperty IIS:\AppPools\B10ADMIN -name Recycling.periodicRestart -value @{time = "00:00:00" }
Set-ItemProperty IIS:\AppPools\B10ADMIN -name Recycling.periodicRestart.schedule -value @{value = "22:55" }
$sm.CommitChanges()
Start-Sleep -Seconds 5
if ((gci WSMan:\localhost\Listener).Keys -contains "Transport=HTTPS") {
    winrm delete winrm/config/Listener?Address=*+Transport=HTTPS
}
else {
    Add-Content -Path C:\Temp\azureImageBuilderRestart.txt -Value 'No WinRM listener with HTTPS transport found on original image'
}
Start-Sleep -Seconds 5
$file = "C:\DeprovisioningScript.ps1"
if (Test-Path -Path $file){
Remove-Item $file -Force
}
