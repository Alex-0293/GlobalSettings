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
    $Global:gsGlobalSettingsSuccessfullyLoaded = $False
    exit 1
}

######################### value replacement ########################
# Ver 1.2
[string] $Global:gsMyProjectFolderPath = ""          # Replace this path

######################### no replacement #####################
# Ver 1.0
[string] $Global:gsErrorsLogFileName    = "Errors.log"
[string] $Global:gsDATAFolder           = "DATA"
[string] $Global:gsLOGSFolder           = "LOGS"
[string] $Global:gsSCRIPTSFolder        = "SCRIPTS"
[string] $Global:gsSETTINGSFolder       = "SETTINGS"
[string] $Global:gsVALUESFolder         = "VALUES"
[string] $Global:gsACLFolder            = "ACL"
[string] $Global:gsDefaultSettingsFile  = "Settings.ps1"
[string] $Global:gsEmptySettingsFile    = "Settings-empty.ps1"
[array]  $Global:gsSPECIALFolders       = @($Global:gsDATAFolder, $Global:gsLOGSFolder, $Global:gsSCRIPTSFolder, $Global:gsSETTINGSFolder, $Global:gsVALUESFolder, $Global:gsACLFolder)
[string] $Global:gsKEYSFolder           = "$($Global:gsVALUESFolder)\KEYS"
[string] $Global:gsGlobalRoot           = Split-Path $ProjectRoot   -parent
[string] $Global:gsGlobalSettingsPath   = Split-Path (Split-Path $PSCommandPath -parent) -Parent
[string] $Global:gsHelpers              = "$(Split-Path $($Global:gsGlobalSettingsPath) -parent)\HELPERS"
[string] $Global:gsScriptLocalHost      = $Env:COMPUTERNAME
[string] $Global:gsGlobalDateFormat     = "dd.MM.yyyy"
[string] $Global:gsGlobalDateTimeFormat = "dd.MM.yyyy HH:mm:ss"
[int16]  $Global:gsScriptOperationTry   = 3
[int16]  $Global:gsPauseBetweenRetries  = 500 # MilliSeconds
[int16]  $Global:gsInitVarsCount        = (Get-Variable -Name *).count
[int16]  $Global:gsLogFileNamePosition  = 230
$Global:gsRunningCredentials            = [System.Security.Principal.WindowsIdentity]::GetCurrent()

# Create vars for local init
[array]  $Global:gsScriptStack        = @()
[array]  $Global:gsLogBuffer          = @()
[string] $Global:gsScriptArguments    = ""
[string] $Global:gsScriptName         = ""
[string] $Global:gsScriptLogFilePath  = ""
[string] $Global:gsScriptFileName     = ""
[string] $Global:gsScriptBaseFileName = ""
[int16]  $Global:gsParentLevel        = 0


#Ver 1.2 
[string] $Global:gsProjectServicesFolderPath  = "$($Global:gsMyProjectFolderPath)\ProjectServices"
[string] $Global:ProjectsFolderPath         = "$($Global:gsMyProjectFolderPath)\PROJECTS"
[string] $Global:gsOtherProjectsFolderPath    = "$($Global:gsMyProjectFolderPath)\OtherProjects"
[string] $Global:gsDisabledProjectsFolderPath = "$($Global:gsMyProjectFolderPath)\DisabledProjects" #Ver 1.3 
[array]  $Global:gsWorkFolderList             = @($Global:ProjectsFolderPath, $Global:gsProjectServicesFolderPath, $Global:gsOtherProjectsFolderPath)
[string] $Global:gsTemplateProjectPath        = "$($Global:gsProjectServicesFolderPath)\TemplateProject"

[bool]   $Global:gsGlobalSettingsSuccessfullyLoaded = $True

[string] $Global:gsGlobalKey1        = "$($Global:gsGlobalSettingsPath)\$($Global:gsKEYSFolder)\Key1.dat"           # AES Key.
[string] $Global:gsGlobalVMKey1      = "$($Global:gsGlobalSettingsPath)\$($Global:gsKEYSFolder)\VMKey.dat"          # AES Key.


[int]   $Global:SessionTimeout = ""         
[string]$Global:MailUserFile   = ""         
[string]$Global:MailPassFile   = ""         
[string]$Global:gsGlobalKey1     = ""          # AES Key
[string]$Global:GlobalKey2     = ""          # AES Key
[String]$Global:APP_SCRIPT_ADMIN_LoginFilePath = ""         
[String]$Global:APP_SCRIPT_ADMIN_PassFilePath  = ""         
[string]$Global:gsGlobalVMKey1   = ""          # AES Key.
