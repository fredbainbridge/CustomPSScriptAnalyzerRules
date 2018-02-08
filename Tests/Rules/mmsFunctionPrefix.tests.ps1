Import-Module PSScriptAnalyzer
$directory = Split-Path -Parent $MyInvocation.MyCommand.Path
$rootDirectory = Split-Path -Parent (Split-Path -Parent $directory)
$ViolationMessage = "Custom functions should follow a naming standard like Verb-mmsNoun."
$violations = Invoke-ScriptAnalyzer $directory\mmsFunctionPrefix.ps1 -CustomRulePath $rootDirectory\Rules\mmsPSScriptAnalyzerRules\mmsPSScriptAnalyzerRules.psm1 -IncludeRule Measure-mmsFunctionPrefix
$noViolations = Invoke-ScriptAnalyzer $directory\mmsFunctionPrefixNoViolations.ps1 -CustomRulePath $rootDirectory\Rules\mmsPSScriptAnalyzerRules\mmsPSScriptAnalyzerRules.psm1 -IncludeRule Measure-mmsFunctionPrefix

Describe "mmsFunctionPrefix" {
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