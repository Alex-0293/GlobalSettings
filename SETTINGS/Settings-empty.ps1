# Rename this file to Settings.ps1
######################### no replacement #####################
# Error trap
trap {    
    $Global:GlobalSettingsSuccessfullyLoaded = $False
    exit 1
}

[string] $Global:ErrorsLogFileName                = "Errors.log"
[string] $Global:DATAFolder                       = "DATA"
[string] $Global:LOGSFolder                       = "LOGS"
[string] $Global:SCRIPTSFolder                    = "SCRIPTS"
[string] $Global:SETTINGSFolder                   = "SETTINGS"
[string] $Global:VALUESFolder                     = "VALUES"
[string] $Global:ACLFolder                        = "ACL"
[array]  $Global:SPECIALFolders                   = @($DATAFolder, $LOGSFolder, $SCRIPTSFolder, $SETTINGSFolder, $VALUESFolder, $ACLFolder)
[string] $Global:KEYSFolder                       = "$VALUESFolder\KEYS"
[string] $Global:GlobalRoot                       = Split-Path $ProjectRoot   -parent
[string] $Global:GlobalSettings                   = split-path (split-path $PSCommandPath -parent) -Parent
[string] $Global:Helpers                          = "$(split-path $GlobalSettings -parent)\HELPERS"
[string] $Global:ScriptFileName                   = Split-Path $ProjectRoot -Leaf
[string] $Global:ScriptBaseFileName               = $ScriptFileName.split(".")[0]
[string] $Global:OutputXMLPath                    = "$ProjectRoot\$DATAFolder\ScriptBlockOutput.xml" #Start-PSScript output file for script blocks.
[string] $Global:ScriptLogFilePath                = "$ProjectRoot\$LOGSFolder\$ScriptFileName.log"
[string] $Global:ScriptLocalHost                  = $Env:COMPUTERNAME
[string] $Global:GlobalDateFormat                 = "dd.MM.yyyy"
[string] $Global:GlobalDateTimeFormat             = "dd.MM.yyyy HH:mm:ss"
[string] $Global:ScriptArguments                  = ""
[string] $Global:ScriptName                       = ""
[string] $Global:LogBuffer                        = @{}
[int16]  $Global:ParentLevel                      = 0
[int16]  $Global:ScriptOperationTry               = 3
[int16]  $Global:PauseBetweenRetries              = 500 # MilliSeconds
[array]  $Global:ScriptNameStack                  = @()
[array]  $Global:StartDateStack                   = @()
[array]  $Global:ProjectRootStack                 = @()
[int16]  $Global:InitVarsCount                    = (Get-Variable -Name *).count
[int16]  $Global:LogFileNamePosition              = 230
$Global:RunningCredentials                        = [System.Security.Principal.WindowsIdentity]::GetCurrent()
[bool]   $Global:GlobalSettingsSuccessfullyLoaded = $True
######################### value replacement ########################

[string] $Global:GlobalKey1             = ""          # AES Key.
