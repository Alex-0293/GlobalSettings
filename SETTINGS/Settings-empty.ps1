# Rename this file to Settings.ps1
# Rename this file to Settings.ps1
######################### no replacement #####################
# Latest Ver:1.1
function Get-WorkDir () {
    if ($PSScriptRoot -eq "") {
        if ($PWD -ne "") {
            $MyScriptRoot = $PWD
        }        
        else {
            Write-Host "Where i am? What is my work dir?"
        }
    }
    else {
        $MyScriptRoot = $PSScriptRoot
    }
    return $MyScriptRoot
}
# Error trap
trap {
    $Global:GlobalSettingsSuccessfullyLoaded = $False
    exit 1
}
# Ver 1.0
[string] $Global:ErrorsLogFileName    = "Errors.log"
[string] $Global:DATAFolder           = "DATA"
[string] $Global:LOGSFolder           = "LOGS"
[string] $Global:SCRIPTSFolder        = "SCRIPTS"
[string] $Global:SETTINGSFolder       = "SETTINGS"
[string] $Global:VALUESFolder         = "VALUES"
[string] $Global:ACLFolder            = "ACL"
[string] $Global:DefaultSettingsFile  = "Settings.ps1"
[string] $Global:EmptySettingsFile    = "Settings-empty.ps1"
[array]  $Global:SPECIALFolders       = @($DATAFolder, $LOGSFolder, $SCRIPTSFolder, $SETTINGSFolder, $VALUESFolder, $ACLFolder)
[string] $Global:KEYSFolder           = "$VALUESFolder\KEYS"
[string] $Global:GlobalRoot           = Split-Path $ProjectRoot   -parent
[string] $Global:GlobalSettings       = Split-Path (Split-Path $PSCommandPath -parent) -Parent
[string] $Global:Helpers              = "$(Split-Path $GlobalSettings -parent)\HELPERS"
[string] $Global:ScriptLocalHost      = $Env:COMPUTERNAME
[string] $Global:GlobalDateFormat     = "dd.MM.yyyy"
[string] $Global:GlobalDateTimeFormat = "dd.MM.yyyy HH:mm:ss"
[int16]  $Global:ScriptOperationTry   = 3
[int16]  $Global:PauseBetweenRetries  = 500 # MilliSeconds
[int16]  $Global:InitVarsCount        = (Get-Variable -Name *).count
[int16]  $Global:LogFileNamePosition  = 230
$Global:RunningCredentials            = [System.Security.Principal.WindowsIdentity]::GetCurrent()

# Create vars for local init
[array]  $Global:ScriptStack        = @()
[array]  $Global:LogBuffer          = @()
[string] $Global:ScriptArguments    = ""
[string] $Global:ScriptName         = ""
[string] $Global:ScriptLogFilePath  = ""
[string] $Global:ScriptFileName     = ""
[string] $Global:ScriptBaseFileName = ""
[int16]  $Global:ParentLevel        = 0

# Ver 1.1
[string] $Global:ProjectServicesFolderPath = "C:\Users\Alex\Documents\ProjectServices"
[string] $Global:ProjectsFolderPath        = "C:\Users\Alex\Documents\PROJECTS"
[string] $Global:OtherProjectsFolderPath   = "C:\Users\Alex\Documents\OtherProjects"
[array]  $Global:WorkFolderList            = @($Global:ProjectsFolderPath, $Global:ProjectServicesFolderPath, $Global:OtherProjectsFolderPath)
[string] $Global:TemplateProjectPath       = "$($Global:ProjectServicesFolderPath)\TemplateProject"


[bool]   $Global:GlobalSettingsSuccessfullyLoaded = $True

######################### value replacement ########################

[string] $Global:GlobalKey1        = ""          # AES Key.



