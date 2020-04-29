######################### no replacement #####################
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

[string] $Global:ErrorsLogFileName  = "Errors.log"
[string] $Global:DATAFolder         = "DATA"
[string] $Global:LOGSFolder         = "LOGS"
[string] $Global:SCRIPTSFolder      = "SCRIPTS"
[string] $Global:SETTINGSFolder     = "SETTINGS"
[string] $Global:VALUESFolder       = "VALUES"
[string] $Global:ACLFolder          = "ACL"
[array]  $Global:SPECIALFolders     = @($DATAFolder, $LOGSFolder, $SCRIPTSFolder, $SETTINGSFolder, $VALUESFolder, $ACLFolder)
[string] $Global:KEYSFolder         = "$VALUESFolder\KEYS"
[string] $Global:ProjectRoot        = Split-Path $MyScriptRoot -parent
[string] $Global:GlobalRoot         = Split-Path $ProjectRoot  -parent
[string] $Global:GlobalSettings     = split-path (Get-WorkDir) -parent
[string] $Global:Helpers            = "$(split-path $GlobalSettings -parent)\HELPERS"
[string] $Global:ScriptFileName     = Split-Path $ProjectRoot -Leaf
[string] $Global:ScriptBaseFileName = $ScriptFileName.split(".")[0] 
[bool]   $Global:GlobalSettingsSuccessfullyLoaded = $True
[string] $Global:OutputXMLPath     = "$ProjectRoot\$DATAFolder\ScriptBlockOutput.xml" #Start-PSScript output file for script blocks.
[string] $Global:ScriptLogFilePath = "$ProjectRoot\$LOGSFolder\$ScriptFileName.log"

######################### value replacement ########################

[string] $Global:GlobalKey1        = ""          # AES Key.



