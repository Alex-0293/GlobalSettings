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
[datetime] $Global:ScriptStartTime = Get-Date
$ImportResult = Import-Module AlexkUtils  -PassThru -force
if ($null -eq $ImportResult) {
    Write-Host "Module 'AlexkUtils' does not loaded!" -ForegroundColor Red
    exit 1
}
else {
    $ImportResult = $null
}
# Error trap
trap {
    if (get-module -FullyQualifiedName AlexkUtils) {
        Get-ErrorReporting $_        
        . "$GlobalSettings\$SCRIPTSFolder\Finish.ps1" 
    }
    Else {
        Write-Host "[$($MyInvocation.MyCommand.path)] There is error before logging initialized." -ForegroundColor Red
    }  
    $Global:GlobalSettingsSuccessfullyLoaded = $false
    exit 1
}

#requires -version 3

################################# Script start here #################################
Function Initialize-Script   ($ScriptRoot) {
    $ScriptRootParent = Split-Path -path $ScriptRoot -Parent
    $SettingsFolder   = "SETTINGS"

    [string]$Global:GlobalSettingsPath = "$ScriptRootParent\$SettingsFolder\Settings.ps1"
    write-host "Initializing global settings." -ForegroundColor DarkGreen
    Get-SettingsFromFile -SettingsFile $Global:GlobalSettingsPath

    if ( -not $GlobalSettingsSuccessfullyLoaded ) { 
        Add-ToLog -Message "[Error] Error loading global settings!" -logFilePath "$(Split-Path -path $Global:MyScriptRoot -parent)\LOGS\Errors.log" -Display -Status "Error" -Format "dd.MM.yyyy HH:mm:ss"
        Exit 1
    }
}

clear-host
$ScriptRoot = Split-Path $MyInvocation.MyCommand.path -Parent
Initialize-Script $ScriptRoot