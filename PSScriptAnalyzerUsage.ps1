#Install Analyzer Rules (they are already in VS Code)
(Get-Module -Name PSScriptAnalyzer).Path

#Get rules available to you by default
Get-ScriptAnalyzerRule | ft Name, CommonName, Description

Invoke-ScriptAnalyzer -Path .\ScriptAnalyzerRules\Tests -CustomRulePath .\ScriptAnalyzerRules\Rules\ -RecurseCustomRulePath -Recurse

Invoke-ScriptAnalyzer -Path .\ScriptAnalyzerRules\Tests -CustomRulePath .\ScriptAnalyzerRules\Rules\ -RecurseCustomRulePath -Recurse -Verbose

