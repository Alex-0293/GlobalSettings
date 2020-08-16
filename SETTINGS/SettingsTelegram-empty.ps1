# Rename this file to Settings.ps1
######################### value replacement #####################


######################### no replacement ########################

[string] $Global:TelegramTokenExistedPath  = "$($Global:GlobalSettingsPath)\$($Global:VALUESFolder)\Telegram_Token.dat"
[string] $Global:TelegramChatIdExistedPath = "$($Global:GlobalSettingsPath)\$($Global:VALUESFolder)\Telegram_ChatId.dat"
[SecureString] $TelegramToken       = AlexkUtils\Get-VarFromAESFile -AESKeyFilePath $Global:GlobalKey1  -VarFilePath $Global:TelegramTokenExistedPath
[SecureString] $TelegramChatId      = AlexkUtils\Get-VarFromAESFile -AESKeyFilePath $Global:GlobalKey1  -VarFilePath $Global:TelegramChatIdExistedPath

[HashTable] $TelegramData = @{
    Token  = $TelegramToken;
    ChatId = $TelegramChatId
}

$Global:TelegramParameters = [PSCustomObject]@{
    Name        = "Telegram"
    Description = "Add message parameter."
    Data        = $TelegramData
}


[bool]  $Global:LocalSettingsSuccessfullyLoaded  = $true
# Error trap
trap {
    $Global:LocalSettingsSuccessfullyLoaded = $False
    exit 1
}
