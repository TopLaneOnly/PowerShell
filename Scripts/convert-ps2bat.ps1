﻿<#
.SYNOPSIS
	Converts PowerShell scripts to batch files
.DESCRIPTION
	This script converts one or more PowerShell scripts to .bat batch files.
.PARAMETER Filepattern
	Specifies the file pattern
.EXAMPLE
	PS> ./convert-ps2bat *.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Filepattern = "")

function Convert-PowerShellToBatch
{
    param
    (
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [string]
        [Alias("FullName")]
        $Path
    )
 
    process
    {
        $encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Content -Path $Path -Raw -Encoding UTF8)))
        $newPath = [Io.Path]::ChangeExtension($Path, ".bat")
        "@echo off`npowershell.exe -NoExit -encodedCommand $encoded" | Set-Content -Path $newPath -Encoding Ascii
    }
}
 
try {
	if ($Filepattern -eq "") { $Filepattern = read-host "Enter path to the PowerShell script(s)" }

	$Files = get-childItem -path "$Filepattern"
	foreach ($File in $Files) {
		Convert-PowerShellToBatch "$File"
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
