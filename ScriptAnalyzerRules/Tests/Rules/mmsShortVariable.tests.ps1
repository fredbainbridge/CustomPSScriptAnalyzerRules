Import-Module PSScriptAnalyzer
$directory = Split-Path -Parent $MyInvocation.MyCommand.Path
$rootDirectory = Split-Path -Parent (Split-Path -Parent $directory)
$ViolationMessage = "Short variable names can make for hard to read code."
$violations = Invoke-ScriptAnalyzer $directory\mmsShortVariable.ps1 -CustomRulePath $rootDirectory\Rules\mmsPSScriptAnalyzerRules\mmsPSScriptAnalyzerRules.psm1 -IncludeRule Measure-mmsShortVariable
$noViolations = Invoke-ScriptAnalyzer $directory\mmsShortVariableNoViolations.ps1 -CustomRulePath $rootDirectory\Rules\mmsPSScriptAnalyzerRules\mmsPSScriptAnalyzerRules.psm1 -IncludeRule Measure-mmsShortVariable

Describe "mmsShortVariable" {
    Context "When there are violations." {
        It "Has one mmsShortVariable violation." {
            $violations.count | Should Be 1
        }
        
        It "Has the correct description message" {
            $violations[0].Message | Should Match $ViolationMessage
        }
    }
    Context "When there are no violations." {
        It "Has no mmsShortVariable violations." {
            $noViolations | should be $null
        }
    }
}