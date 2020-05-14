# Error trap
trap {
    if ($Global:Logger) {
        Get-ErrorReporting $_
    }
    Else {
        Write-Host "[$($MyInvocation.MyCommand.path)] There is error before logging initialized." -ForegroundColor Red
    }   
    exit 1
}
################################# Script start here #################################

[datetime] $ScriptEndTime = Get-Date

Add-ToLog -message "Script [$($Global:ScriptName)] exited. Executed [$(($ScriptEndTime - $ScriptStartTime).TotalSeconds)] seconds." -logFilePath $ScriptLogFilePath -display -status "Info"  -level $Global:ParentLevel
[array]$Global:ScriptNameStack  = $Global:ScriptNameStack  | Select-Object -first (@($Global:ScriptNameStack).count-1)
[array]$Global:StartDateStack   = $Global:StartDateStack   | Select-Object -first (@($Global:StartDateStack).count - 1)
[array]$Global:ProjectRootStack = $Global:ProjectRootStack | Select-Object -first (@($Global:ProjectRootStack).count - 1)

if (@($Global:ScriptNameStack).count) {
   $Global:ScriptName      = $Global:ScriptNameStack  | Select-Object -last 1 
   $Global:ScriptStartTime = $Global:StartDateStack   | Select-Object -last 1 
   $Global:ProjectRoot     = $Global:ProjectRootStack | Select-Object -last 1 
   $Global:ParentLevel     = $Global:ScriptNameStack.count - 1   
   Initialize-Logging        "$ProjectRoot\$LOGSFolder\$ErrorsLogFileName" "Latest"
}
Else {
    if (Test-Path "$ProjectRoot\debug.txt") {
        $TranscriptPath = "$LogFolder\Transcript.log"
        Stop-Transcript  | Out-Null
        Write-Host "Transcript stopped." -ForegroundColor Gray
    }

    $TotalVars = (Get-Variable -Name *).count
    foreach ($item in (Get-Variable -Name * -Scope local | Where-Object { ($_.options -eq "None") -and ($_.name -NotLike "*psEditor*") -and ($_.name -ne "TotalVars") -and ($_.name -ne "InitVarsCount") })) {
        Try {
            #Write-Host "Try to remove [$($item.name)]."
            Remove-Variable $item.name -scope local -ErrorAction SilentlyContinue
            #Write-Host "Removed [$($item.name)]." 
        }
        Catch {
            Write-Host "Unable to remove [$($item.name)]."
        }       
    }
    $AfterRemove = (Get-Variable -Name *).count - 1
    Write-Host "Removed [$AfterRemove/$TotalVars], now [$($TotalVars-$AfterRemove)], on start [$InitVarsCount]."
    Remove-Variable "TotalVars", "InitVarsCount", "AfterRemove" -scope global -ErrorAction SilentlyContinue
}
Exit 0