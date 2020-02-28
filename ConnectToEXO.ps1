if (Get-Module -Name RegistryValue)
{
    Write-Host "Module is already imported. Proceeding with code..."
}

else 
{
    Write-Host "Importing Module"
    Import-Module .\RegistryValue.ps1    
}

Write-Host "Validating Console Prompting"
$RegistryExists = (Test-RegistryValue 'HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\' 'ConsolePrompting')

if ($RegistryExists) 

{
    Write-Host "Console Prompting Registry Exists"
} 

else 

{
    Write-Host "Registry Keys for console prompting do not exist. Creating Registy Keys for Console Prompting..."
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds" -Name ConsolePrompting -Value $true
}

$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking
