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
    if ($Global:Logger) {
        Get-ErrorReporting $_
        . "$GlobalSettings\$SCRIPTSFolder\Finish.ps1" 
    }
    Else {
        Write-Host "[$($MyInvocation.MyCommand.path)] There is error before logging initialized." -ForegroundColor Red
        $_
    }   
    exit 1
}

#requires -version 3

################################# Script start here #################################
Function Initialize-Script   ($ScriptRoot) {
    $ScriptRootParent = Split-Path -path $ScriptRoot -Parent
    $SettingsFolder   = "SETTINGS"

    [string]$Global:GlobalSettingsPath = "$ScriptRootParent\$SettingsFolder\Settings.ps1"
    if (-not $Global:ProjectRootStack.count) {
        Get-SettingsFromFile -SettingsFile $Global:GlobalSettingsPath
    }
    if ($GlobalSettingsSuccessfullyLoaded) {    
            Initialize-Logging   "$ProjectRoot\$LOGSFolder\$ErrorsLogFileName" "Latest"
            #Write-Host "Logging initialized." -ForegroundColor Green
    }
    Else { 
        Add-ToLog -Message "[Error] Error loading global settings!" -logFilePath "$(Split-Path -path $Global:MyScriptRoot -parent)\LOGS\Errors.log" -Display -Status "Error" -Format 'yyyy-MM-dd HH:mm:ss'
        Exit 1
    }
}

[string] $Global:ProjectRoot = Split-Path $MyScriptRoot -parent
$ScriptRoot = Split-Path $MyInvocation.MyCommand.path -Parent
Initialize-Script $ScriptRoot

$Global:ScriptName = $ScriptInvocation.MyCommand.Name

foreach ($boundparam in $ScriptInvocation.BoundParameters.GetEnumerator()) {
    if ($boundparam.Value.GetType().name -eq "String") { 
        $Global:ScriptArguments += "-$($boundparam.Key) `"$($boundparam.Value)`" "
    }
    Else {
        $Global:ScriptArguments += "-$($boundparam.Key) $($boundparam.Value) "
    }
}

$Global:ScriptArguments   = $Global:ScriptArguments.Trim()
$Global:ScriptNameStack  += $Global:ScriptName
$Global:StartDateStack   += $Global:ScriptStartTime
$Global:ProjectRootStack += $Global:ProjectRoot
$Global:ParentLevel       = $Global:ScriptNameStack.count - 1

Add-ToLog -message "Script [$($Global:ScriptName) $($Global:ScriptArguments)] with PID [$($PID)] started under [$($RunningCredentials.Name)]." -logFilePath $ScriptLogFilePath -display -status "Info" -level $Global:ParentLevel