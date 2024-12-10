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
Add-MpPreference -ExclusionPath "C:\Board"
Add-MpPreference -ExclusionProcess "BoardEngine.exe, BoardProcedureLaucher.exe"
##
Add-Computer -WorkgroupName "BoardSaaS"
##
$env:boardpath = 'C:\Board'
$env:bss = 'Z:\'
$env:ifrs16 = 'Z:\ifrs16'
$env:conso = 'Z:\conso'
$env:conso_dataset = 'Z:\'
$env:xbrl = 'Z:\xbrl'
##
New-Item -Name "Board" -Path "C:\" -ItemType Directory
##
Stop-Service -name "Spooler" -force
Set-Service -name "Spooler" -startupType "Disabled"
