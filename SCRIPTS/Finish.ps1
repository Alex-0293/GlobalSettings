# Error trap
trap {
    if (get-module -FullyQualifiedName AlexkUtils) {
        Get-ErrorReporting $_
        
    }
    Else {
        Write-Host "[$($MyInvocation.MyCommand.path)] There is error before logging initialized. Error: $_" -ForegroundColor Red
    }   
    exit 1
}
################################# Script start here #################################
#Write-Host "ScriptNameStack: [$(($($Global:gsScriptStack) | Select-Object ScriptName).ScriptName -join ", ")]"  -ForegroundColor DarkGreen
[datetime] $ScriptEndTime = Get-Date

$ScriptWithArgs = "$($Global:gsScriptName) $($Global:gsScriptArguments)".Trim()
$TimeSpan       = New-TimeSpan -start $ScriptStartTime -End $ScriptEndTime
$ExecutionTime  = Format-TimeSpan -TimeSpan $TimeSpan
Add-ToLog -Message "Script [$ScriptWithArgs] exited. Execution time [$ExecutionTime]." -logFilePath $Global:gsScriptLogFilePath -Display -Status "Info"  -Level $Global:gsParentLevel
[array]$Global:gsScriptStack = $Global:gsScriptStack | Select-Object -first (@($Global:gsScriptStack).count - 1)

if (@($Global:gsScriptStack).count) {
    # Restore parent script params
    $LastScriptStackItem = $Global:gsScriptStack  | Select-Object -last 1 

    $Global:ScriptStartTime      = $LastScriptStackItem.ScriptStartTime
    $Global:gsParentLevel        = $LastScriptStackItem.ParentLevel
    $Global:gsScriptName         = $LastScriptStackItem.ScriptName
    $Global:ProjectRoot          = $LastScriptStackItem.ProjectRoot
    $Global:gsScriptArguments    = $LastScriptStackItem.ScriptArguments
    $Global:gsScriptFileName     = $LastScriptStackItem.ScriptFileName
    $Global:gsScriptBaseFileName = $LastScriptStackItem.ScriptBaseFileName
    $Global:gsScriptLogFilePath  = $LastScriptStackItem.ScriptLogFilePath  
}
Else {
    if (Test-Path "$ProjectRoot\debug.txt") {
        $TranscriptPath = "$LogFolder\Transcript.log"
        Stop-Transcript  | Out-Null
        Write-Host "Transcript stopped." -ForegroundColor Magenta
    }

    $TotalVars = (Get-Variable -Name *).count
    [string] $RemovedVars = ""
    $ExcludeVarList = "TotalVars", "gsInitVarsCount", "RemovedVars"
    foreach ($item in (Get-Variable -Name * -Scope local | Where-Object { ($_.options -eq "None") -and ($_.name -NotLike "*psEditor*") -and ($_.name -notin $ExcludeVarList) -and ($_.name.Length -gt 1) })) {
        Try {
            #Write-Host "Try to remove [$($item.name)]."
            Remove-Variable $item.name -scope local -ErrorAction SilentlyContinue
            #Write-Host "Removed [$($item.name)]." 
            $RemovedVars += "`n $($item.name)"
        }
        Catch {
            Write-Host "Unable to remove [$($item.name)]."
        }       
    }
    $AfterRemove = (Get-Variable -Name *).count - 1
    Write-Host "Removed [$AfterRemove/$TotalVars], now [$($TotalVars-$AfterRemove)], on start [$($Global:gsInitVarsCount)]." # Removed vars [$RemovedVars]."
    Remove-Variable "TotalVars", "InitVarsCount", "AfterRemove", "RemovedVars" -scope local -ErrorAction SilentlyContinue
}
Exit 0
