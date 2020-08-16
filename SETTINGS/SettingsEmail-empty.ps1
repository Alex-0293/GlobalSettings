# Rename this file to Settings.ps1
######################### value replacement #####################
[string] $Global:SmtpServer          = ""          # SMTP Server FQDN or IP
[string] $Global:From                = ""          # Mail from:
[string] $Global:To                  = ""          # Mail to:

######################### no replacement ########################


[Bool]   $Global:UseMailAuth         = $True
[string] $Global:MailUserExistedPath = "$($Global:GlobalSettingsPath)\$($Global:VALUESFolder)\MailUser.dat" #Enc user
[string] $Global:MailPassExistedPath = "$($Global:GlobalSettingsPath)\$($Global:VALUESFolder)\MailPass.dat" #Enc pass


[SecureString] $MailUser = AlexkUtils\Get-VarFromAESFile -AESKeyFilePath $Global:GlobalKey1  -VarFilePath $Global:MailUserExistedPath
[SecureString] $MailPass = AlexkUtils\Get-VarFromAESFile -AESKeyFilePath $Global:GlobalKey1  -VarFilePath $Global:MailPassExistedPath

[HashTable] $Data = @{
    SmtpServer  = $Global:SmtpServer
    From        = $Global:From
    To          = $Global:To
    User        = $MailUser
    Pass        = $MailPass
}

$Global:EmailParameters = [PSCustomObject]@{
    Name        = "Email"
    Description = "Add message, subject parameters."
    Data        = $Data
}



[bool]  $Global:LocalSettingsSuccessfullyLoaded  = $true
# Error trap
trap {
    $Global:LocalSettingsSuccessfullyLoaded = $False
    exit 1
}
