$RegistryPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL'
$KeyName     	= 'AllowInsecureRenegoClients'
$KeyName2     	= 'AllowInsecureRenegoServers'
$KeyName3       = 'DisableRenegoOnServer'
$Value    	= '0'
$Value2    	= '0'
$Value3     = '1'
New-ItemProperty -Path $RegistryPath -Name $KeyName -Value $Value -PropertyType DWORD -Force
New-ItemProperty -Path $RegistryPath -Name $KeyName2 -Value $Value2 -PropertyType DWORD -Force
New-ItemProperty -Path $RegistryPath -Name $KeyName3 -Value $Value3 -PropertyType DWORD -Force
##
$RegistryPath2 = 'HKLM:\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters'
$KeyName4     	= 'RestrictNullSessAccess'
$Value4     = '0'
New-ItemProperty -Path $RegistryPath2 -Name $KeyName4 -Value $Value4 -PropertyType DWORD -Force
##
$RegistryPath3 = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$KeyName5     	= 'NoDriveTypeAutoRun'
$Value5     = '1'
New-ItemProperty -Path $RegistryPath3 -Name $KeyName5 -Value $Value5 -PropertyType DWORD -Force
##
$RegistryPath4 = 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon'
$KeyName6     	= 'CachedLogonsCount'
$Value6     = '0'
Set-ItemProperty -Path $RegistryPath4 -Name $KeyName6 -Value $Value6 -Force
##
$RegistryPath5 = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
$KeyName7     	= 'boardpath'
$Value7     = 'C:\Board'
$KeyName8     	= 'bss'
$Value8     = 'Z:\'
$KeyName9     	= 'ifrs16'
$Value9     = 'Z:\ifrs16'
$KeyName10     	= 'conso'
$Value10     = 'Z:\conso'
$KeyName11     	= 'conso_dataset'
$Value11     = 'Z:\'
$KeyName12     	= 'xbrl'
$Value12     = 'Z:\xbrl'
New-ItemProperty -Path $RegistryPath5 -Name $KeyName7 -Value $Value7 -PropertyType String -Force
New-ItemProperty -Path $RegistryPath5 -Name $KeyName8 -Value $Value8 -PropertyType String -Force
New-ItemProperty -Path $RegistryPath5 -Name $KeyName9 -Value $Value9 -PropertyType String -Force
New-ItemProperty -Path $RegistryPath5 -Name $KeyName10 -Value $Value10 -PropertyType String -Force
New-ItemProperty -Path $RegistryPath5 -Name $KeyName11 -Value $Value11 -PropertyType String -Force
New-ItemProperty -Path $RegistryPath5 -Name $KeyName12 -Value $Value12 -PropertyType String -Force

##
Add-MpPreference -ExclusionPath "C:\Board"
Add-MpPreference -ExclusionProcess "BoardEngine.exe, BoardProcedureLaucher.exe"
##
Add-Computer -WorkgroupName "BoardSaaS"
##
New-Item -Name "Board" -Path "C:\" -ItemType Directory
##
Stop-Service -name "Spooler" -force
Set-Service -name "Spooler" -startupType "Disabled"
##
if ((Get-ComputerInfo).WindowsInstallationType -match "Server Core" ) {
  Add-WindowsCapability -Online -Name ServerCore.AppCompatibility
}
