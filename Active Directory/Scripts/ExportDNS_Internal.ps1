# ---------------------------------------------------
# Original Script: C:\scripts\esportDNS_internal.ps1
# Version: 1.0
# Author: Paul Lambert
# Date: 16/05/2024
# Description: Using PowerShell to export DNS records to "C:\temp\DNS\exportDNS_internal_A_records.csv"
# Comments: 
# ---------------------------------------------------

#VARIABLES
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$CSV = "C:\temp\DNS\exportDNS_internal_A_records.csv"

#parameters
$DNSServer = "ESTRANW1DC01"
$Zone1 = "barcodeblack.es"
$Zone2 = "barcodeblack.com"
$Zone3 = "barcodeblack.local"


#SCRIPT MAIN
clear
$DNS_Zones = @()
$DNS_Zones += $Zone1
$DNS_Zones += $Zone2
$DNS_Zones += $Zone3
$hosts = @()
$DNS_Zones | % {
    $zone = $_
    Write-Host "Getting DNS A records from $zone"  
    $DNS_A_records = @(Get-WmiObject -Class MicrosoftDNS_AType -NameSpace Root\MicrosoftDNS -ComputerName $DNSServer -Filter "ContainerName = `'$zone`'")
    $DNS_A_records | % {
        $hostA = "" | select "hostname","IPAddress","Timestamp","TTL"
        $hostA.hostname = $_.OwnerName
        $hostA.IPAddress = $_.IPAddress
		$hostA.Timestamp = $_.Timestamp
		$hostA.TTL = $_.TTL
        $hosts += $hostA
    }
}
$hosts = $hosts | Sort-Object @{Expression={[Version]$_.IPAddress}}
$hosts | Export-Csv $CSV -NoTypeInformation -Force
