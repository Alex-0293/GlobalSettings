<#
    .SYNOPSIS 
        Creator
        dd.MM.yyyy
        Ver
    .DESCRIPTION
    
    .EXAMPLE
#>
param (
    [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Path to script root folder." )]
    [string] $MyScriptRoot,
    [Parameter(Mandatory = $false, Position = 1, HelpMessage = "Select local init script name." )]
    [string] $LocalInit
)
[datetime] $Global:ScriptStartTime = Get-Date
$ImportResult = Import-Module AlexkUtils  -PassThru -Force
if ($null -eq $ImportResult) {
    Write-Host "Module 'AlexkUtils' does not loaded!" -ForegroundColor Red
    exit 1
}
else {
    $ImportResult = $null
}
# Error trap
trap {
    if (Get-Module -FullyQualifiedName AlexkUtils) {
        Get-ErrorReporting $_        
        . "$($Global:gsGlobalSettingsPath)\$($Global:gsSCRIPTSFolder)\Finish.ps1" 
    }
    Else {
        Write-Host "[$($MyInvocation.MyCommand.path)] There is error before logging initialized. Error: $_" -ForegroundColor Red
    }  
    $Global:gsGlobalSettingsSuccessfullyLoaded = $false
    exit 1
}

#requires -version 3

################################# Script start here #################################
Function Initialize-Script   ($ScriptRoot) {
    $ScriptRootParent = Split-Path -Path $ScriptRoot -Parent
    $Global:gsSETTINGSFolder = "SETTINGS"

    [string]$Global:gsGlobalSettingsPath = "$ScriptRootParent\$Global:gsSETTINGSFolder\Settings.ps1"
    Write-Host "Initializing global settings." -ForegroundColor DarkGreen
    Get-SettingsFromFile -SettingsFile $Global:gsGlobalSettingsPath

    if ( -not $Global:gsGlobalSettingsSuccessfullyLoaded ) {
        Add-ToLog -Message "[Error] Error loading global settings!" -logFilePath "$(Split-Path -Path $Global:MyScriptRoot -Parent)\LOGS\Errors.log" -Display -Status "Error" -Format "dd.MM.yyyy HH:mm:ss"
        Exit 1
    }
}

Clear-Host
$ScriptRoot = Split-Path $MyInvocation.MyCommand.path -Parent
Initialize-Script $ScriptRoot
