# https://github.com/PowerShell/PSScriptAnalyzer/blob/development/Tests/Engine/CommunityAnalyzerRules/CommunityAnalyzerRules.psm1
# https://github.com/PowerShell/PSScriptAnalyzer/tree/development/Tests/Engine/CommunityAnalyzerRules

$filepath = 'C:\source\repos\CustomPSScriptAnalyzerRules\Demo\BreakingTheCommunityRules.ps1'
$communityrulepath = 'C:\source\repos\CustomPSScriptAnalyzerRules\ScriptAnalyzerRules\Rules\CommunityAnalyzerRules'
Invoke-ScriptAnalyzer -Path $filepath -CustomRulePath $communityrulepath -RecurseCustomRulePath
Invoke-ScriptAnalyzer -Path $filepath -CustomRulePath $communityrulepath -RecurseCustomRulePath -IncludeRule Measure-Backtick
Invoke-ScriptAnalyzer -Path $filepath -CustomRulePath $communityrulepath -RecurseCustomRulePath -IncludeRule Measure-SomethingElse
$x = "line" `
 , "continuation"

 if($true) {
    if($true) {
        return
    }
    return
}

Write-Host "234"
Get-WmiObject -Class Win32_PageFile