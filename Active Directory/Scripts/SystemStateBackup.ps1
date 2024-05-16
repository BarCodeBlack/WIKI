# ----------------------------------------------------------------------------------------------------
# Location: 	C:\Windows\Scripts\
# Version: 	1.2
# Author: 	Paul Lambert
# Date: 	21/03/2024
# Description:	Script to perform a daily systsemstate backup on domain controllers to local disk
# Comments: 	Target of backup C:\WindowsImageBackup
# Conditions: 	Not applicable
# ----------------------------------------------------------------------------------------------------

SET LOGFILE=C:\Logs\SystemStateBackup.log

CLS

WBADMIN DELETE CATALOG -quiet >%LOGFILE%

Remove-Item -PATH C:\WindowsImageBackup\$env:COMPUTERNAME -Recurse >>%LOGFILE%

WBADMIN START SYSTEMSTATEBACKUP -backupTarget:C: -quiet >>%LOGFILE%


$SmtpServer = "185.132.180.41"
$To = "<Email addresseses>"
$From = "<Email addresseses>"
$Event =  Get-WinEvent -LogName Microsoft-Windows-Backup -MaxEvents 3 | Where-Object { $_.Id -eq '4' }

# Store the newest log into email body 
$EmailBody= "** Script generado en $env:COMPUTERNAME cada vez que se realiza un SystemState Backup **" + "`r`n`t" + " " + "`r`n`t" + $Event.Message + "`r`n`t" + $Event.TimeCreated

# Email subject 
$EmailSubj= "AXA AD - $env:COMPUTERNAME - SystemState Backup" 

# Create SMTP client 
$SMTPClient = New-Object Net.Mail.SMTPClient($SmtpServer)   
# $SMTPClient.EnableSSL = $true  

# Get the credetials 
# $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($UserName, $PassWord);  

# Create mailmessage object  
$emailMessage = New-Object System.Net.Mail.MailMessage 
$emailMessage.From = "$From" 
Foreach($EmailTo in $To) 
{ 
 $emailMessage.To.Add($EmailTo) 
} 
$emailMessage.Subject = $EmailSubj 
$emailMessage.Body = $EmailBody 

# Send email 
$SMTPClient.Send($emailMessage)

EXIT
