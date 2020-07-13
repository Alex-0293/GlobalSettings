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
#Write-Host "ScriptNameStack: [$(($Global:ScriptStack | Select-Object ScriptName).ScriptName -join ", ")]"  -ForegroundColor DarkGreen
[datetime] $ScriptEndTime = Get-Date

Add-ToLog -message "Script [$($Global:ScriptName)] exited. Executed [$(($ScriptEndTime - $ScriptStartTime).TotalSeconds)] seconds." -logFilePath $ScriptLogFilePath -display -status "Info"  -level $Global:ParentLevel
[array]$Global:ScriptStack = $Global:ScriptStack | Select-Object -first (@($Global:ScriptStack).count - 1)

if (@($Global:ScriptStack).count) {
    # Restore parent script params
    $LastScriptStackItem = $Global:ScriptStack  | Select-Object -last 1 

    $Global:ScriptStartTime    = $LastScriptStackItem.ScriptStartTime
    $Global:ParentLevel        = $LastScriptStackItem.ParentLevel
    $Global:ScriptName         = $LastScriptStackItem.ScriptName
    $Global:ProjectRoot        = $LastScriptStackItem.ProjectRoot
    $Global:ScriptArguments    = $LastScriptStackItem.ScriptArguments
    $Global:ScriptFileName     = $LastScriptStackItem.ScriptFileName
    $Global:ScriptBaseFileName = $LastScriptStackItem.ScriptBaseFileName
    $Global:ScriptLogFilePath  = $LastScriptStackItem.ScriptLogFilePath  
}
Else {
    if (Test-Path "$ProjectRoot\debug.txt") {
        $TranscriptPath = "$LogFolder\Transcript.log"
        Stop-Transcript  | Out-Null
        Write-Host "Transcript stopped." -ForegroundColor Magenta
    }

    $TotalVars = (Get-Variable -Name *).count
    [string] $RemovedVars = ""
    foreach ($item in (Get-Variable -Name * -Scope local | Where-Object { ($_.options -eq "None") -and ($_.name -NotLike "*psEditor*") -and ($_.name -ne "TotalVars") -and ($_.name -ne "InitVarsCount") -and ($_.name -ne "RemovedVars") -and ($_.name.Length -gt 1) })) {
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
    Write-Host "Removed [$AfterRemove/$TotalVars], now [$($TotalVars-$AfterRemove)], on start [$InitVarsCount]." # Removed vars [$RemovedVars]."
    Remove-Variable "TotalVars", "InitVarsCount", "AfterRemove", "RemovedVars" -scope local -ErrorAction SilentlyContinue
}
Exit 0