﻿<#
.SYNOPSIS
	Connects to the VPN
.DESCRIPTION
	This script tries to connect to the VPN.
.EXAMPLE
	PS> ./connect-vpn
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

try {
	$Connections = (Get-VPNConnection)
	foreach($Connection in $Connections) {
		if ($Connection.ConnectionStatus -eq "Disconnected") {
			& "$PSScriptRoot/give-reply.ps1" "Connecting to VPN $($Connection.Name)..."
			& rasdial.exe "$($Connection.Name)"
			if ($lastExitCode -ne "0") { throw "Cannot establish connection" }
			& "$PSScriptRoot/give-reply.ps1" "Connected now."
			exit 0 # success
		} elseif ($Connection.ConnectionStatus -eq "Connected") { throw "Already connected to VPN $($Connection.Name)" }
	}
	throw "No VPN connection available"
} catch {
	& "$PSScriptRoot/give-reply.ps1" "Sorry: $($Error[0])"
	exit 1
}
