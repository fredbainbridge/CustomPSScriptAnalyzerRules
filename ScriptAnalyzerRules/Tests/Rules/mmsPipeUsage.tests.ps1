Import-Module PSScriptAnalyzer
$directory = Split-Path -Parent $MyInvocation.MyCommand.Path
$rootDirectory = Split-Path -Parent (Split-Path -Parent $directory)
$ViolationMessage = "You should not be using the pipe."
$violations = Invoke-ScriptAnalyzer $directory\mmsPipeUsage.ps1 -CustomRulePath $rootDirectory\Rules\mmsPSScriptAnalyzerRules\mmsPSScriptAnalyzerRules.psm1 -IncludeRule Measure-mmsPipeUsage
$noViolations = Invoke-ScriptAnalyzer $directory\mmsPipeUsageNoViolations.ps1 -CustomRulePath $rootDirectory\Rules\mmsPSScriptAnalyzerRules\mmsPSScriptAnalyzerRules.psm1 -IncludeRule Measure-mmsPipeUsage

Describe "mmsPipeUsage" {
    Context "When there are violations." {
        It "Has one mmsFunctionPrefix violation." {
            $violations.count | Should Be 1
        }
        
        It "Has the correct description message" {
            $violations[0].Message | Should Match $ViolationMessage
        }
    }
    Context "When there are no violations." {
        It "Has no mmsFunctionPrefix violations." {
            $noViolations | should be $null
        }
    }
}