# -------------------------------------------------------------------------------------------------
# Original Script: C:\Script\Check_Password_Age.ps1
# Version: 1.0
# Author: Paul Lambert
# Date: 16/05/2024
# Description: Script for checking password age for accounts that password never expires.
# Comments: 	Target of backup C:\WindowsImageBackup
# Conditions: 	Not applicable
# -------------------------------------------------------------------------------------------------

$SmtpServer="185.132.180.41"
$From="CheckPasswordAge@axa-assistance.es"
$emailaddress="sergio.escobar@axa-assistance.es, infrastructure@axa-assistance.es"

$Accounts=Get-ADUser -Properties Name, UserPrincipalName, DistinguishedName, Employeeid, PasswordNeverExpires, PasswordLastSet -Filter {PasswordNeverExpires -eq 'true' -and Enabled -eq 'true'}

Foreach ($Account in $Accounts) {

    $Name=(Get-ADUser $Account -properties * | ForEach-Object {$_.Name})
    
    $EmployeeID=(Get-ADUser $Account -properties * | ForEach-Object {$_.EmployeeID})

    $Pwdlastset=(Get-ADUser $Account -properties * | ForEach-Object {$_.PasswordLastSet})
    
    $today=Get-Date

    $Passwordage=(New-TimeSpan -start $Pwdlastset -End $today).Days

    if($passwordage -ge '365') {
    
       Add-Content C:\Script\PasswordAge.txt ("Nombre cuenta: " + $Name + " EmployeeID: " + $EmployeeID + " Edad contraseña: " + $Passwordage)
       Add-Content C:\Script\PasswordAge.txt ("--------------------------------------------------------------------------------------------------")

    }

}


#Email subject
$EmailSubj="Listado de cuentas que han alcanzado o superan los 365 dias de antigüedad de contraseña, considere renovar el password."

#Create, attach txt file and send an email object
$SMTPClient = New-Object Net.Mail.SMTPClient($SmtpServer)

$emailMessage = New-Object System.Net.Mail.MailMessage

$file= "C:\Script\PasswordAge.txt"

$emailMessage.Attachments.Add($file)

$EmailBody="Ver contenido adjunto"

$emailMessage.From = "$From"

Foreach($EmailTo in $emailaddress) 
{ 
    $emailMessage.To.Add($EmailTo) 
} 

$emailMessage.Subject = "$EmailSubj"
$emailMessage.Body = "$EmailBody"

$SMTPClient.Send($emailMessage)
