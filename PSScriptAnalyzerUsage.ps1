#Install Analyzer Rules (they are already in VS Code)
(Get-Module -Name PSScriptAnalyzer).Path

#Not in VS Code
Install-Module psscriptanalyzer -Scope currentuser 
Get-Module -Name PSScriptAnalyzer


#Get rules available to you by default (what comes out of the box)
Get-ScriptAnalyzerRule | ft Name, CommonName, Description

#Function Prefix Example
$params = @{
    Path            = '.\ScriptAnalyzerRules\Tests\Rules'
    CustomRulePath  = '.\ScriptAnalyzerRules\Rules\mmsPSScriptAnalyzerRules'
    IncludeRule     = 'Measure-mmsFunctionPrefix'
}
Invoke-ScriptAnalyzer @params

#Short Variable Name Example
$params = @{
    Path            = '.\ScriptAnalyzerRules\Tests\Rules'
    CustomRulePath  = '.\ScriptAnalyzerRules\Rules\mmsPSScriptAnalyzerRules'
    IncludeRule     = 'Measure-mmsShortVariable'
}
Invoke-ScriptAnalyzer @params


#Pipe Prefix Example
$params = @{
    Path            = '.\ScriptAnalyzerRules\Tests\Rules'
    CustomRulePath  = '.\ScriptAnalyzerRules\Rules\mmsPSScriptAnalyzerRules'
    IncludeRule     = 'Measure-mmsPipeUsage'
}
Invoke-ScriptAnalyzer @params

#run all rules
Invoke-ScriptAnalyzer -Path .\ScriptAnalyzerRules\Tests -CustomRulePath .\ScriptAnalyzerRules\Rules\ -RecurseCustomRulePath -Recurse

#run all rules with verbose output
Invoke-ScriptAnalyzer -Path .\ScriptAnalyzerRules\Tests -CustomRulePath .\ScriptAnalyzerRules\Rules\ -RecurseCustomRulePath -Recurse -Verbose

