#Replace file
# [array] $Global:ReplaceScope = "D:\DATA\DOCUMENTS\MyProjects\Projects\ADStructureCreator"
# $Global:ReplaceScope += "D:\DATA\DOCUMENTS\MyProjects\Projects\HELKInstaller"
# $Global:ReplaceScope += "D:\DATA\DOCUMENTS\MyProjects\Projects\VirtualLab-Win2016-OPNSens"
# $Global:ReplaceScope += "D:\DATA\DOCUMENTS\MyProjects\Projects\VMScripts"
# $Global:ReplaceScope += "C:\Program Files\WindowsPowerShell\Modules\AlexkLinuxGuestUtils"
$Global:ReplaceScope = "C:\Program Files\WindowsPowerShell\Modules\AlexkVMUtils"
# $Global:ReplaceScope += "C:\Program Files\WindowsPowerShell\Modules\AlexkWindowsGuestUtils"
Write-Host "Replace scope: " -NoNewline
Write-Host "$($Global:ReplaceScope -join ",")" -ForegroundColor Cyan

$Global:Replaces     = @()
$Version = "1"
$Date = get-date -date "28.09.2020"

$Replaces += [PSCustomObject]@{Find = '$Global:MyProjectFolderPath'  ; Replace = '$Global:gsMyProjectFolderPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ErrorsLogFileName'    ; Replace = '$Global:gsErrorsLogFileName' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:DATAFolder'           ; Replace = '$Global:gsDATAFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:LOGSFolder'           ; Replace = '$Global:gsLOGSFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:SCRIPTSFolder'        ; Replace = '$Global:gsSCRIPTSFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:SETTINGSFolder'       ; Replace = '$Global:gsSETTINGSFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:VALUESFolder'         ; Replace = '$Global:gsVALUESFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ACLFolder'            ; Replace = '$Global:gsACLFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:DefaultSettingsFile'  ; Replace = '$Global:gsDefaultSettingsFile' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:EmptySettingsFile'    ; Replace = '$Global:gsEmptySettingsFile' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:SPECIALFolders'       ; Replace = '$Global:gsSPECIALFolders' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:KEYSFolder'           ; Replace = '$Global:gsKEYSFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:GlobalRoot'           ; Replace = '$Global:gsGlobalRoot' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:GlobalSettingsPath'   ; Replace = '$Global:gsGlobalSettingsPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:Helpers'              ; Replace = '$Global:gsHelpers' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ScriptLocalHost'      ; Replace = '$Global:gsScriptLocalHost' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:GlobalDateFormat'     ; Replace = '$Global:gsGlobalDateFormat' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:GlobalDateTimeFormat' ; Replace = '$Global:gsGlobalDateTimeFormat' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ScriptOperationTry'   ; Replace = '$Global:gsScriptOperationTry' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:PauseBetweenRetries'  ; Replace = '$Global:gsPauseBetweenRetries' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:InitVarsCount'        ; Replace = '$Global:gsInitVarsCount' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:LogFileNamePosition'  ; Replace = '$Global:gsLogFileNamePosition' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:RunningCredentials'   ; Replace = '$Global:gsRunningCredentials' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ScriptStack'          ; Replace = '$Global:gsScriptStack' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:LogBuffer'            ; Replace = '$Global:gsLogBuffer' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ScriptArguments'      ; Replace = '$Global:gsScriptArguments' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ScriptName'           ; Replace = '$Global:gsScriptName' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ScriptLogFilePath'    ; Replace = '$Global:gsScriptLogFilePath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ScriptFileName'       ; Replace = '$Global:gsScriptFileName' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ScriptBaseFileName'   ; Replace = '$Global:gsScriptBaseFileName' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ParentLevel'          ; Replace = '$Global:gsParentLevel' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:ProjectServicesFolderPath'        ; Replace = '$Global:gsProjectServicesFolderPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:OtherProjectsFolderPath'          ; Replace = '$Global:gsOtherProjectsFolderPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:DisabledProjectsFolderPath'       ; Replace = '$Global:gsDisabledProjectsFolderPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:WorkFolderList'                   ; Replace = '$Global:gsWorkFolderList' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:TemplateProjectPath'              ; Replace = '$Global:gsTemplateProjectPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:GlobalSettingsSuccessfullyLoaded' ; Replace = '$Global:gsGlobalSettingsSuccessfullyLoaded' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:GlobalKey1'                       ; Replace = '$Global:gsGlobalKey1' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Global:GlobalVMKey1'                     ; Replace = '$Global:gsGlobalVMKey1' ; Version = $Version; Date = $date }

$Replaces += [PSCustomObject]@{Find = '$MyProjectFolderPath'  ; Replace = '$Global:gsMyProjectFolderPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ErrorsLogFileName'    ; Replace = '$Global:gsErrorsLogFileName' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$DATAFolder'           ; Replace = '$Global:gsDATAFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$LOGSFolder'           ; Replace = '$Global:gsLOGSFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$SCRIPTSFolder'        ; Replace = '$Global:gsSCRIPTSFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$SETTINGSFolder'       ; Replace = '$Global:gsSETTINGSFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$VALUESFolder'         ; Replace = '$Global:gsVALUESFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ACLFolder'            ; Replace = '$Global:gsACLFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$DefaultSettingsFile'  ; Replace = '$Global:gsDefaultSettingsFile' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$EmptySettingsFile'    ; Replace = '$Global:gsEmptySettingsFile' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$SPECIALFolders'       ; Replace = '$Global:gsSPECIALFolders' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$KEYSFolder'           ; Replace = '$Global:gsKEYSFolder' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$GlobalRoot'           ; Replace = '$Global:gsGlobalRoot' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$GlobalSettingsPath'   ; Replace = '$Global:gsGlobalSettingsPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$Helpers'              ; Replace = '$Global:gsHelpers' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ScriptLocalHost'      ; Replace = '$Global:gsScriptLocalHost' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$GlobalDateFormat'     ; Replace = '$Global:gsGlobalDateFormat' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$GlobalDateTimeFormat' ; Replace = '$Global:gsGlobalDateTimeFormat' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ScriptOperationTry'   ; Replace = '$Global:gsScriptOperationTry' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$PauseBetweenRetries'  ; Replace = '$Global:gsPauseBetweenRetries' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$InitVarsCount'        ; Replace = '$Global:gsInitVarsCount' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$LogFileNamePosition'  ; Replace = '$Global:gsLogFileNamePosition' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$RunningCredentials'   ; Replace = '$Global:gsRunningCredentials' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ScriptStack'          ; Replace = '$Global:gsScriptStack' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$LogBuffer'            ; Replace = '$Global:gsLogBuffer' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ScriptArguments'      ; Replace = '$Global:gsScriptArguments' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ScriptName'           ; Replace = '$Global:gsScriptName' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ScriptLogFilePath'    ; Replace = '$Global:gsScriptLogFilePath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ScriptFileName'       ; Replace = '$Global:gsScriptFileName' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ScriptBaseFileName'   ; Replace = '$Global:gsScriptBaseFileName' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ParentLevel'          ; Replace = '$Global:gsParentLevel' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$ProjectServicesFolderPath'        ; Replace = '$Global:gsProjectServicesFolderPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$OtherProjectsFolderPath'          ; Replace = '$Global:gsOtherProjectsFolderPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$DisabledProjectsFolderPath'       ; Replace = '$Global:gsDisabledProjectsFolderPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$WorkFolderList'                   ; Replace = '$Global:gsWorkFolderList' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$TemplateProjectPath'              ; Replace = '$Global:gsTemplateProjectPath' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$GlobalSettingsSuccessfullyLoaded' ; Replace = '$Global:gsGlobalSettingsSuccessfullyLoaded' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$GlobalKey1'                       ; Replace = '$Global:gsGlobalKey1' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '$GlobalVMKey1'                     ; Replace = '$Global:gsGlobalVMKey1' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '.AUTHOR'                           ; Replace = 'AUTHOR' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '.DATE'                             ; Replace = 'DATE' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '.VER'                              ; Replace = 'VER' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '.LANG'                             ; Replace = 'LANG' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '.NOTE'                             ; Replace = '.NOTES' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '.PARAMETER'                        ; Replace = '' ; Version = $Version; Date = $date }

$Global:Replaces     = @()
$Date = Get-Date -Date "29.09.2020"

$FunctionScope = "Export-CustomVM", "Add-VMNetAdapter", "Remove-VMNetAdapter", "Get-VMList", "Get-VMCheckpointList", "Set-VMStartupOrder", "Get-VMStartupOrder", "Install-RDPShortcutsForVMConsoles", "Add-CustomVM", "Add-VMCheckPoint", "Start-CustomVM", "Stop-CustomVM", "Suspend-CustomVM", "Save-CustomVM", "Resume-CustomVM", "Restore-VMCheckpoint", "Remove-CustomVM", "Rename-CustomVM", "Get-VMSettings", "Move-VMStorage", "Add-BootISO", "Remove-BootISO", "Set-VMRamSize", "Get-VMNetworkList", "Add-VMIndex", "Get-VMIndex", "Restart-CustomVM", "Start-VMConsole", "Remove-VMCheckpoint", "Start-VMVHDOptimization", "Add-GuestCredentialsToVault", "Remove-GuestCredentialsFromVault", "Get-GuestUsername", "Get-GuestCredentials", "Get-VMSwitchList", "Get-VMNetAdapterList", "Get-VMIp", "Get-HostNameFromSeries", "Set-VMFirmware", "Get-IPType", "Test-MAC", "Get-VMAccessibleIP", "Update-VMCache"
$Global:ActionScope   = [PSCustomObject]@{ File = "AlexkVMUtils.psm1"; FunctionScopeFilter = $FunctionScope }

$Replaces += [PSCustomObject]@{Find = '-VMName $VMName'  ; Replace = '-VM $Item' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '[string] $VMName' ; Replace = '$VM' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = 'VM name.'         ; Replace = 'VM.' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '-VMName "VM1"'    ; Replace = '-VM $VM' ; Version = $Version; Date = $date }
$Replaces += [PSCustomObject]@{Find = '[$VMName]'        ; Replace = '[$($VM.Name)]' ; Version = $Version; Date = $date }
write-host "$($Replaces | Format-Table -AutoSize| out-string)" -ForegroundColor Blue -NoNewline