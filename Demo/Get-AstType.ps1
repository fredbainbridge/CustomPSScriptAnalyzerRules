function Get-AstType {
	<#
		.SYNOPSIS
			Returns all of the types of AST objects in a script.
		.DESCRIPTION
			Parses the contents of a provided script and gets a list of all the AST object types.
		.EXAMPLE
			Get-AstType -ScriptPath .\MyScript.ps1
		.NOTES
			Author: Thomas Rayner (@MrThomasRayner), workingsysadmin.com
		.LINK
			http://workingsysadmin.com
	#>
	
	[CmdletBinding()]
	[OutputType([PSCustomObject[]])]
	param (
	    [Parameter(Mandatory)]
	    [ValidateNotNullOrEmpty()]
	    [string]$ScriptPath
	)
	process {
		if(Test-Path $ScriptPath) {
			try {
				$ast = [System.Management.Automation.Language.Parser]::ParseFile( $ScriptPath, [ref]$null, [ref]$null )
				$ast.FindAll( { $args[0] -ne $null }, $true )  |
					ForEach-Object {
						$PSItem.GetType()
					} | Select-Object
			}
			catch {
				$PSCmdlet.ThrowTerminatingError( $_ )
			}
		}
		else {
			Write-Verbose "File not found."
		}
	}
}

$x | Out-Null

function   Get-mmsWdiget {
	
}