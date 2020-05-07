[datetime] $ScriptEndTime = Get-Date

Add-ToLog -message "Script [$($Global:ScriptName)] exited. Execute [$(($ScriptEndTime - $ScriptStartTime).seconds)] seconds." -logFilePath $ScriptLogFilePath -display -status "Info"  -level $Global:ParentLevel
[array]$Global:ScriptNameStack = $Global:ScriptNameStack | Select-Object -first (@($Global:ScriptNameStack).count-1)
[array]$Global:StartDateStack  = $Global:StartDateStack | Select-Object -first (@($Global:StartDateStack).count - 1)

if (@($Global:ScriptNameStack).count) {
   $Global:ScriptName      = $Global:ScriptNameStack | Select-Object -last 1 
   $Global:ScriptStartTime = $Global:StartDateStack  | Select-Object -last 1 
   $Global:ParentLevel     = $Global:ScriptNameStack.count - 1
}
Else {
    foreach ($item in (Get-Variable -Name * | Where-Object { ($_.options -eq "None") -and ($_.name.Length -gt 2) -and ($_.name -NotLike "*psEditor*") })) {
        Try {
            #Write-Host "Try to remove [$($item.name)]."
            Remove-Variable $item.name -scope global -ErrorAction SilentlyContinue
            #Write-Host "Removed [$($item.name)]." 
        }
        Catch { }       
    }
}