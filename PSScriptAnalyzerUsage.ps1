(Get-Module -Name PSScriptAnalyzer).Path
#Get rules available to you by default
Get-ScriptAnalyzerRule | ft Name, CommonName, Description

Invoke-ScriptAnalyzer -Path .\Tests -CustomRulePath .\Rules\ -RecurseCustomRulePath -Recurse

Invoke-ScriptAnalyzer -Path .\Tests -CustomRulePath .\Rules\ -RecurseCustomRulePath -Recurse -Verbose
