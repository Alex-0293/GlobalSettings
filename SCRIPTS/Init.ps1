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
        . "$GlobalSettingsPath\$SCRIPTSFolder\Finish.ps1" 
    }
    Else {
        Write-Host "[$($MyInvocation.MyCommand.path)] There is error before logging initialized. Error: $_" -ForegroundColor Red
    }  
    $Global:GlobalSettingsSuccessfullyLoaded = $false
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
            Add-ToLog "Variable [$($item.name)] path [$($item.value)] not exist!" -display -status "error" -logFilePath $ScriptLogFilePath
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

if ($GlobalSettingsSuccessfullyLoaded -or (-not $InitGlobal )) {        
    if (Test-Path "$($Global:ProjectRoot)\debug.txt") {
        $TranscriptPath = "$($Global:ProjectRoot)\$($Global:LOGSFolder)\Transcript.log"
        Start-Transcript -Path $TranscriptPath -Append -Force | Out-Null
        Write-Host "Transcript started." -ForegroundColor Magenta
    }
    if ($InitLocal) {
        Write-Host "Initializing local settings." -ForegroundColor DarkGreen
        if ($SettingsName){
            Get-SettingsFromFile -SettingsFile "$ProjectRoot\$($Global:SETTINGSFolder)\$SettingsName.ps1"
        }
        Else {
            Get-SettingsFromFile -SettingsFile "$ProjectRoot\$($Global:SETTINGSFolder)\Settings.ps1"
        }
        if (-not $LocalSettingsSuccessfullyLoaded) {    
            Add-ToLog -Message "[Error] Error loading local settings!" -logFilePath "$(Split-Path -path $Global:MyScriptRoot -parent)\$LOGSFolder\$ErrorsLogFileName" -Display -Status "Error" -Format 'yyyy-MM-dd HH:mm:ss'
            Exit 1 
        }
    }

    $Global:ScriptName = $ScriptInvocation.MyCommand.Name
    
    $Global:ScriptArguments = ""
    foreach ($boundparam in $ScriptInvocation.BoundParameters.GetEnumerator()) {
        if ($null -ne $boundparam.Value) {
            if ($boundparam.Value.GetType().name -eq "String") { 
                $Global:ScriptArguments += "-$($boundparam.Key) `"$($boundparam.Value)`" "
            }
            Else {
                $Global:ScriptArguments += "-$($boundparam.Key) $($boundparam.Value) "
            }
        }
        Else {
            $Global:ScriptArguments += "-$($boundparam.Key) $($boundparam.Value) "
        }
    }
    
    
    $Global:ScriptFileName      = Split-Path $ProjectRoot -Leaf
    $Global:ScriptBaseFileName  = $ScriptFileName.split(".")[0]
    $Global:ScriptLogFilePath   = "$ProjectRoot\$LOGSFolder\$ScriptFileName.log"
    $Global:ScriptArguments     = $Global:ScriptArguments.Trim()
    $Global:ParentLevel         = $Global:ScriptStack.count

    $ScriptStackItem = [PSCustomObject]@{
        ScriptStartTime    = $Global:ScriptStartTime
        ParentLevel        = $Global:ParentLevel
        ScriptName         = $Global:ScriptName
        ProjectRoot        = $Global:ProjectRoot        
        ScriptArguments    = $Global:ScriptArguments
        ScriptFileName     = $Global:ScriptFileName
        ScriptBaseFileName = $Global:ScriptBaseFileName
        ScriptLogFilePath  = $Global:ScriptLogFilePath
    }
    $Global:ScriptStack += $ScriptStackItem
    
    #Write-Host "ScriptNameStack: [$(($Global:ScriptStack | Select-Object ScriptName).ScriptName -join ", ")]"  -ForegroundColor DarkGreen
    Test-VariablesPath
    if ($Global:ScriptArguments) {
        $ScriptView = "$($Global:ScriptName) $($Global:ScriptArguments)"
    }
    Else {
        $ScriptView = $Global:ScriptName
    }
    Add-ToLog -Message "Script [$ScriptView] with PID [$($PID)] started under [$($RunningCredentials.Name)]." -logFilePath $ScriptLogFilePath -Display -Status "Info" -Level $Global:ParentLevel
}
exit 0