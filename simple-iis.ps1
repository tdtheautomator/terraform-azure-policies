Start-Transcript -Path 'C:/simple-iis.log' -Force -Append
Add-WindowsFeature -Name Web-Server -IncludeManagementTools
Set-Content -Path "C:\inetpub\wwwroot\Default.htm" -Value "You are connected to host $($env:computername) !"
Stop-Transcript