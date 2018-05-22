#Install Analyzer Rules (they are already in VS Code) The latest PowerShell extension has the latest release of PSSA in it.
Invoke-ScriptAnalyzer #this loads the module if not already
(Get-Module -Name PSScriptAnalyzer).Path

#Not in VS Code
Install-Module psscriptanalyzer -Scope currentuser 
Get-Module -Name PSScriptAnalyzer

#Compile manually
#https://github.com/PowerShell/PSScriptAnalyzer/ 

#What comes out of the box?
Get-Command -Module PSScriptAnalyzer


#Get rules available to you by default (what comes out of the box)
Get-ScriptAnalyzerRule | ft RuleName, CommonName, Description

#Function Prefix Example
$params = @{
    Path            = '.\ScriptAnalyzerRules\Tests\Rules'
    CustomRulePath  = '.\ScriptAnalyzerRules\Rules\mmsPSScriptAnalyzerRules'
    IncludeRule     = 'Measure-mmsFunctionPrefix'
}
Invoke-ScriptAnalyzer @params

#want more? Look at the community rules.  Warning, they can annoy you. These are excellent references for creating your own rules.
#https://github.com/PowerShell/PSScriptAnalyzer/tree/development/Tests/Engine/CommunityAnalyzerRules

#Community Rules Example
Get-ScriptAnalyzerRule -CustomRulePath '.\ScriptAnalyzerRules\Rules\CommunityAnalyzerRules'

$params = @{
    Path            = '.\Demo\BreakingTheCommunityRules.ps1'
    CustomRulePath  = '.\ScriptAnalyzerRules\Rules\CommunityAnalyzerRules'
}
Invoke-ScriptAnalyzer @params

#Short Variable Name Example
$params = @{
    Path            = '.\ScriptAnalyzerRules\Tests\Rules'
    CustomRulePath  = '.\ScriptAnalyzerRules\Rules\mmsPSScriptAnalyzerRules'
    IncludeRule     = 'Measure-mmsShortVariable'
}
Invoke-ScriptAnalyzer @params

#Break a script into AST Components.
. .\Demo\Get-AstType.ps1
Get-AstType -ScriptPath .\Demo\ScriptBlock.ps1  #make changes and run the script again.


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

