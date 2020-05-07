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
    [Parameter(Mandatory = $false, Position = 1, HelpMessage = "Will force init global vars." )]
    [switch] $Force
)
[datetime] $Global:ScriptStartTime = get-date
$ImportResult    = Import-Module AlexkUtils  -PassThru -force
if ($null -eq $ImportResult) {
    Write-Host "Module 'AlexkUtils' does not loaded!" -ForegroundColor Red
    exit 1
}
else {
    $ImportResult = $null
}
#requires -version 3

#########################################################################
function Get-WorkDir () {
    if ($PSScriptRoot -eq "") {
        if ($PWD -ne "") {
            $ScriptRoot = $PWD
        }        
        else {
            Write-Host "Where i am? What is my work dir?"
        }
    }
    else {
        $ScriptRoot = $PSScriptRoot
    }
    return $ScriptRoot
}
Function Initialize-Script   () {
    $ScriptRoot               = Get-WorkDir
    $ScriptRootParent         = Split-Path -path $ScriptRoot -Parent
    $SettingsFolder           = "SETTINGS"

    [string]$Global:GlobalSettingsPath = "$ScriptRootParent\$SettingsFolder\Settings.ps1"
    if (-not $Global:GlobalSettingsSuccessfullyLoaded -or $Force ){
        Get-SettingsFromFile -SettingsFile $Global:GlobalSettingsPath
    }
    if ($GlobalSettingsSuccessfullyLoaded) {    
        Get-SettingsFromFile -SettingsFile "$ProjectRoot\$($Global:SETTINGSFolder)\Settings.ps1"
        if ($Global:LocalSettingsSuccessfullyLoaded) {
            Initialize-Logging   "$ProjectRoot\$LOGSFolder\$ErrorsLogFileName" "Latest"
            Write-Host "Logging initialized." -ForegroundColor Green           
        }
        Else {
            Add-ToLog -Message "[Error] Error loading local settings!" -logFilePath "$(Split-Path -path $Global:MyScriptRoot -parent)\$LOGSFolder\$ErrorsLogFileName" -Display -Status "Error" -Format 'yyyy-MM-dd HH:mm:ss'
            Exit 1 
        }
    }
    Else { 
        Add-ToLog -Message "[Error] Error loading global settings!" -logFilePath "$(Split-Path -path $Global:MyScriptRoot -parent)\LOGS\Errors.log" -Display -Status "Error" -Format 'yyyy-MM-dd HH:mm:ss'
        Exit 1
    }
}
#########################################################################
Initialize-Script
$Global:ScriptNameStack += $Global:ScriptName
$Global:StartDateStack  += $Global:ScriptStartTime
$Global:ParentLevel = $Global:ScriptNameStack.count - 1
Add-ToLog -message "Script [$($Global:ScriptName)] with PID [$($PID)] started." -logFilePath $ScriptLogFilePath -display -status "Info" -level $Global:ParentLevel