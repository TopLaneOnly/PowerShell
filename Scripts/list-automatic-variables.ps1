﻿<#
.SYNOPSIS
	Lists all automatic variables of PowerShell
.DESCRIPTION
	This script lists all automatic variables of PowerShell.
.EXAMPLE
	PS> ./list-automatic-variables

	Variable                        Content
	--------                        -------
	$false                          False
	$HOME                           C:\Users\Markus
	...
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

function AddItem { param([string]$Variable, [string]$Content)
	new-object PSObject -property @{ 'Variable' = "$Variable"; 'Content' = "$Content" }
}

function ListAutomaticVariables {
	AddItem "`$args"			"$args"
	AddItem "`$ConsoleFileName"		"$ConsoleFileName"
	AddItem "`$Error[0]"			"$($Error[0])"
	AddItem "`$Event"			"$Event"
	AddItem "`$EventArgs"			"$EventArgs"
	AddItem "`$EventSubscriber"		"$EventSubscriber"
	AddItem "`$ExecutionContext"		"$ExecutionContext"
	AddItem "`$false"			"$false"
	AddItem "`$foreach"			"$foreach"
	AddItem "`$HOME"			"$HOME"
	AddItem "`$input"			"$input"
	AddItem "`$IsCoreCLR"			"$IsCoreCLR"
	AddItem "`$IsLinux"			"$IsLinux"
	AddItem "`$IsMacOS"			"$IsMacOS"
	AddItem "`$IsWindows"			"$IsWindows"
	AddItem "`$LastExitCode"		"$LastExitCode"
	AddItem "`$Matches"			"$Matches"
	AddItem "`$MyInvocation.PSScriptRoot" "$($MyInvocation.PSScriptRoot)"
	AddItem "`$MyInvocation.PSCommandPath" "$($MyInvocation.PSCommandPath)"
	AddItem "`$NestedPromptLevel"		"$NestedPromptLevel"
	AddItem "`$null"			"$null"
	AddItem "`$PID"				"$PID"
	AddItem "`$PROFILE"			"$PROFILE"
	AddItem "`$PSBoundParameters"		"$PSBoundParameters"
	AddItem "`$PSCmdlet"			"$PSCmdlet"
	AddItem "`$PSCommandPath"		"$PSCommandPath"
	AddItem "`$PSCulture"			"$PSCulture"
	AddItem "`$PSDebugContext"		"$PSDebugContext"
	AddItem "`$PSHOME"			"$PSHOME"
	AddItem "`$PSItem"			"$PSItem"
	AddItem "`$PSScriptRoot"		"$PSScriptRoot"
	AddItem "`$PSSenderInfo"		"$PSSenderInfo"
	AddItem "`$PSUICulture"			"$PSUICulture"
	AddItem "`$PSVersionTable.PSVersion"	"$($PSVersionTable.PSVersion)"
	AddItem "`$PSVersionTable.PSEdition"	"$($PSVersionTable.PSEdition)"
	AddItem "`$PSVersionTable.GitCommitId"	"$($PSVersionTable.GitCommitId)"
	AddItem "`$PSVersionTable.OS"		"$($PSVersionTable.OS)"
	AddItem "`$PSVersionTable.Platform"	"$($PSVersionTable.Platform)"
	AddItem "`$PSVersionTable.PSCompatibleVersions" "$($PSVersionTable.PSCompatibleVersions)"
	AddItem "`$PSVersionTable.PSRemotingProtocolVersion" "$($PSVersionTable.PSRemotingProtocolVersion)"
	AddItem "`$PSVersionTable.SerializationVersion" "$($PSVersionTable.SerializationVersion)"
	AddItem "`$PSVersionTable.WSManStackVersion" "$($PSVersionTable.WSManStackVersion)"
	AddItem "`$PWD"				"$PWD"
	AddItem "`$Sender"			"$Sender"
	AddItem "`$ShellId"			"$ShellId"
	AddItem "`$StackTrace"			"$StackTrace"
	AddItem "`$switch"			"$switch"
	AddItem "`$this"			"$this"
	AddItem "`$true"			"$true"
}

try {
	ListAutomaticVariables | format-table -property Variable,Content
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
