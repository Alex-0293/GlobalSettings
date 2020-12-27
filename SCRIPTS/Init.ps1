<#
    .SYNOPSIS 
        Creator
        dd.MM.yyyy
        Ver
    .DESCRIPTION
   
    .EXAMPLE
#>
param (
    [Parameter( Mandatory = $false, Position = 0, HelpMessage = "Initialize global settings." )]
    [bool] $InitGlobal = $True,
    [Parameter( Mandatory = $false, Position = 1, HelpMessage = "Initialize local settings." )]
    [bool] $InitLocal = $True,  
    [Parameter(Mandatory = $true, Position = 2, HelpMessage = "Path to script root folder." )]
    [string] $MyScriptRoot,
    [Parameter(Mandatory = $false, Position = 3, HelpMessage = "Select local init script name." )]
    [string] $SettingsName
)
[datetime] $Global:ScriptStartTime = get-date

# Error trap
trap {
    if (get-module -FullyQualifiedName AlexkUtils) {
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
Function Test-VariablesPath {
    $PathName = "*ExistedPath"    
    $PathVariables = Get-Variable $PathName -Exclude $Exclude
    $PathError = $false
    $VariablesWithPathError = @()
    foreach ($item in $PathVariables){
        $res = test-path -Path $item.Value
        if (-not $res) {
            $PathError = $true
            $VariablesWithPathError += $item.name
            Add-ToLog "Variable [$($item.name)] path [$($item.value)] not exist!" -display -status "error" -logFilePath $Global:gsScriptLogFilePath
        }
    }
    if ($PathError){
        if ($SettingsName) {
            $SettingsFileName = "$SettingsName.ps1"
        }
        Else {
            $SettingsFileName = "Settings.ps1"
        }
        throw "Settings file [$SettingsFileName] contains variables [$($VariablesWithPathError -join ", ")] with non existing path!"
    }
}

[string] $Global:ProjectRoot = Split-Path $MyScriptRoot -parent

if ( $InitGlobal ) {
    if ($env:AlexKFrameworkGlobalInitScript) { if (. "$env:AlexKFrameworkGlobalInitScript" -MyScriptRoot $MyScriptRoot) { exit 1 }} Else { Write-Host "Environmental variable [AlexKFrameworkGlobalInitScript] does not exist!" -ForegroundColor Red; exit 1 }
}

if ($Global:gsGlobalSettingsSuccessfullyLoaded -or (-not $InitGlobal )) {        
    if (Test-Path "$($Global:ProjectRoot)\debug.txt") {
        $TranscriptPath = "$($Global:ProjectRoot)\$($($Global:gsLOGSFolder))\Transcript.log"
        Start-Transcript -Path $TranscriptPath -Append -Force | Out-Null
        Write-Host "Transcript started." -ForegroundColor Magenta
    }
    if ($InitLocal) {
        Write-Host "Initializing local settings." -ForegroundColor DarkGreen
        if ($SettingsName){
            Get-SettingsFromFile -SettingsFile "$ProjectRoot\$($($Global:gsSETTINGSFolder))\$SettingsName.ps1"
        }
        Else {
            Get-SettingsFromFile -SettingsFile "$ProjectRoot\$($($Global:gsSETTINGSFolder))\Settings.ps1"
        }
        if (-not $LocalSettingsSuccessfullyLoaded) {    
            Add-ToLog -Message "[Error] Error loading local settings!" -logFilePath "$(Split-Path -path $Global:MyScriptRoot -parent)\$($Global:gsLOGSFolder)\$ErrorsLogFileName" -Display -Status "Error" -Format 'yyyy-MM-dd HH:mm:ss'
            Exit 1 
        }
    }

    $Global:gsScriptName = $ScriptInvocation.MyCommand.Name
    
    $Global:gsScriptArguments = ""
    foreach ($boundparam in $ScriptInvocation.BoundParameters.GetEnumerator()) {
        if ($null -ne $boundparam.Value) {
            if ($boundparam.Value.GetType().name -eq "String") { 
                $Global:gsScriptArguments += "-$($boundparam.Key) `"$($boundparam.Value)`" "
            }
            Else {
                $Global:gsScriptArguments += "-$($boundparam.Key) $($boundparam.Value) "
            }
        }
        Else {
            $Global:gsScriptArguments += "-$($boundparam.Key) $($boundparam.Value) "
        }
    }
    
    
    $Global:gsScriptFileName      = Split-Path $ProjectRoot -Leaf
    $Global:gsScriptBaseFileName  = $Global:gsScriptFileName.split(".")[0]
    $Global:gsScriptLogFilePath   = "$ProjectRoot\$($Global:gsLOGSFolder)\$($Global:gsScriptFileName).log"
    $Global:gsScriptArguments     = $Global:gsScriptArguments.Trim()
    $Global:gsParentLevel         = $Global:gsScriptStack.count

    $ScriptStackItem = [PSCustomObject]@{
        ScriptStartTime    = $Global:ScriptStartTime
        ParentLevel        = $Global:gsParentLevel
        ScriptName         = $Global:gsScriptName
        ProjectRoot        = $Global:ProjectRoot        
        ScriptArguments    = $Global:gsScriptArguments
        ScriptFileName     = $Global:gsScriptFileName
        ScriptBaseFileName = $Global:gsScriptBaseFileName
        ScriptLogFilePath  = $Global:gsScriptLogFilePath
    }
    $Global:gsScriptStack += $ScriptStackItem
    
    #Write-Host "ScriptNameStack: [$(($($Global:gsScriptStack) | Select-Object ScriptName).ScriptName -join ", ")]"  -ForegroundColor DarkGreen
    Test-VariablesPath
    $ScriptWithArgs = "$($($Global:gsScriptName)) $($($Global:gsScriptArguments))".Trim()
    Add-ToLog -Message "Script [$ScriptWithArgs] with PID [$($PID)] started under [$($($Global:gsRunningCredentials).Name)]." -logFilePath $Global:gsScriptLogFilePath -Display -Status "Info" -Level $Global:gsParentLevel
}
$Global:Return = $null
exit 0
