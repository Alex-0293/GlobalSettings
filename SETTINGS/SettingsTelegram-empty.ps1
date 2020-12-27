# Rename this file to Settings-[..].ps1
######################### value replacement #####################


######################### no replacement ########################

[string] $Global:TelegramTokenExistedPath  = "$($Global:gsGlobalSettingsPath)\$($Global:gsVALUESFolder)\Telegram_Token.dat"
[string] $Global:TelegramChatIdExistedPath = "$($Global:gsGlobalSettingsPath)\$($Global:gsVALUESFolder)\Telegram_ChatId.dat"
[SecureString] $TelegramToken       = AlexkUtils\Get-VarFromAESFile -AESKeyFilePath $Global:gsGlobalKey1  -VarFilePath $Global:TelegramTokenExistedPath
[SecureString] $TelegramChatId      = AlexkUtils\Get-VarFromAESFile -AESKeyFilePath $Global:gsGlobalKey1  -VarFilePath $Global:TelegramChatIdExistedPath

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
