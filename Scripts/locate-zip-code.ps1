﻿<#
.SYNOPSIS
	Prints the geo location of a zip-code
.DESCRIPTION
	This script prints the geographic location of the given zip-code.
.PARAMETER CountryCode
	Specifies the country code
.PARAMETER ZipCode
	Specifies the zip code
.EXAMPLE
	PS> ./locate-zip-code
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$CountryCode = "", [string]$ZipCode = "")

try {
	if ($CountryCode -eq "" ) { $CountryCode = read-host "Enter the country code" }
	if ($ZipCode -eq "" ) { $ZipCode = read-host "Enter the zip code" }

	write-progress "Reading zip-codes.csv..."
	$Table = import-csv "$PSScriptRoot/../Data/zip-codes.csv"

	$FoundOne = 0
	foreach($Row in $Table) {
		if ($Row.country -eq $CountryCode) {
			if ($Row.postal_code -eq $ZipCode) {
				$Country=$Row.country
				$City = $Row.city
				$Lat = $Row.latitude
				$Lon = $Row.longitude
				write-output "* $Country $ZipCode $City is at $Lat°N, $Lon°W"
				$FoundOne = 1
			}
		}
	}

	if ($FoundOne) {
		exit 0 # success
	}
	throw "Zip-code $ZipCode in country $CountryCode not found"
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
