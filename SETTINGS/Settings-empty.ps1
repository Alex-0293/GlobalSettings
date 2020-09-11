# Rename this file to Settings.ps1
######################### no replacement #####################
# Latest Ver:1.4
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
######################### value replacement ########################
# Ver 1.2
[string] $Global:MyProjectFolderPath = ""         

######################### no replacement #####################
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
[string] $Global:GlobalRoot           = Split-Path $ProjectRoot   -Parent
[string] $Global:GlobalSettingsPath   = Split-Path (Split-Path $PSCommandPath -Parent) -Parent
[string] $Global:Helpers              = "$(Split-Path $GlobalSettingsPath -Parent)\HELPERS"
[string] $Global:ScriptLocalHost      = $Env:COMPUTERNAME
[string] $Global:GlobalDateFormat     = "dd.MM.yyyy"
[string] $Global:GlobalDateTimeFormat = "dd.MM.yyyy HH:mm:ss"
[int16]  $Global:ScriptOperationTry   = 3
[int16]  $Global:PauseBetweenRetries  = 500 # MilliSeconds
[int16]  $Global:InitVarsCount        = (Get-Variable -Name *).count
[int16]  $Global:LogFileNamePosition  = 230
         $Global:RunningCredentials   = [System.Security.Principal.WindowsIdentity]::GetCurrent()

# Create vars for local init
[array]  $Global:ScriptStack        = @()
[array]  $Global:LogBuffer          = @()
[string] $Global:ScriptArguments    = ""
[string] $Global:ScriptName         = ""
[string] $Global:ScriptLogFilePath  = ""
[string] $Global:ScriptFileName     = ""
[string] $Global:ScriptBaseFileName = ""
[int16]  $Global:ParentLevel        = 0

#Ver 1.2 
[string] $Global:ProjectServicesFolderPath  = "$($Global:MyProjectFolderPath)\ProjectServices"
[string] $Global:ProjectsFolderPath         = "$($Global:MyProjectFolderPath)\PROJECTS"
[string] $Global:OtherProjectsFolderPath    = "$($Global:MyProjectFolderPath)\OtherProjects"
[string] $Global:DisabledProjectsFolderPath = "$($Global:MyProjectFolderPath)\DisabledProjects" #Ver 1.3 
[string] $Global:TemplateProjectPath        = "$($Global:ProjectServicesFolderPath)\TemplateProject"
[array]  $Global:WorkFolderList             = @($Global:ProjectsFolderPath, $Global:ProjectServicesFolderPath, $Global:OtherProjectsFolderPath)

#Ver 1.4
[HashTable] $Global:Plugins = @{"Telegram" = "$($Global:GlobalSettingsPath)\$($Global:SETTINGSFolder)\SettingsTelegram.ps1"; "Email" = "$($Global:GlobalSettingsPath)\$($Global:SETTINGSFolder)\SettingsEmail.ps1" }

#Ver 1.5
$Global:StateObject = [PSCustomObject]@{
    Date        = ""
    Host        = $Global:ScriptLocalHost   
    Application = Split-Path -Path $Global:ProjectRoot -Leaf
    Action      = ""
    Data        = ""
    State       = ""
    GlobalState = ""
}
[string] $Global:StateFilePath = "$($Global:ProjectRoot)\$($Global:LOGSFolder)\States.xml"

[bool]   $Global:GlobalSettingsSuccessfullyLoaded = $True

######################### value replacement ########################

[int]   $Global:SessionTimeout = ""         
[string]$Global:MailUserFile   = ""         
[string]$Global:MailPassFile   = ""         
[string]$Global:GlobalKey1     = ""          # AES Key
[string]$Global:GlobalKey2     = ""          # AES Key
[String]$Global:APP_SCRIPT_ADMIN_LoginFilePath = ""         
[String]$Global:APP_SCRIPT_ADMIN_PassFilePath  = ""         
[string]$Global:GlobalVMKey1   = ""          # AES Key.
