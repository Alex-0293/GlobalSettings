<#
    .SYNOPSIS 
        Creator
        dd.MM.yyyy
        Ver
    .DESCRIPTION
    .PARAMETER
    .EXAMPLE
#>
param (
    [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Path to script root folder." )]
    [string] $MyScriptRoot,
    [Parameter(Mandatory = $false, Position = 1, HelpMessage = "Select local init script name." )]
    [string] $LocalInit
)
[datetime] $Global:ScriptStartTime = get-date

# Error trap
trap {
    if ($Global:Logger) {
        Get-ErrorReporting $_
        . "$GlobalSettings\$SCRIPTSFolder\Finish.ps1" 
    }
    Else {
        Write-Host "[$($MyInvocation.MyCommand.path)] There is error before logging initialized." -ForegroundColor Red
    }   
    exit 1
}

#requires -version 3

################################# Script start here #################################
$InitGlobalScript = "C:\DATA\Projects\GlobalSettings\SCRIPTS\InitGlobal.ps1"
if (. "$InitGlobalScript" -MyScriptRoot $MyScriptRoot) { exit 1 }

if ($GlobalSettingsSuccessfullyLoaded) {        
    if ($LocalInit){
        Get-SettingsFromFile -SettingsFile "$ProjectRoot\$($Global:SETTINGSFolder)\$LocalInit.ps1"
    }
    Else {
        Get-SettingsFromFile -SettingsFile "$ProjectRoot\$($Global:SETTINGSFolder)\Settings.ps1"
    }
    if (-not $LocalSettingsSuccessfullyLoaded) {    
        Add-ToLog -Message "[Error] Error loading local settings!" -logFilePath "$(Split-Path -path $Global:MyScriptRoot -parent)\$LOGSFolder\$ErrorsLogFileName" -Display -Status "Error" -Format 'yyyy-MM-dd HH:mm:ss'
        Exit 1 
    }
}
Else { 
    Add-ToLog -Message "[Error] Error loading global settings!" -logFilePath "$(Split-Path -path $Global:MyScriptRoot -parent)\LOGS\Errors.log" -Display -Status "Error" -Format 'yyyy-MM-dd HH:mm:ss'
    Exit 1
}
exit 0