$string = (Get-Content -Path .\Demo\ScriptBlock.ps1 -Raw)
$ScriptBlock = [Scriptblock]::Create($string) 
$Asts = $ScriptBlock.Ast

[ScriptBlock]$VariablePredicate = {
    param (
        [System.Management.Automation.Language.Ast]$ast
    )
    [bool]$ReturnValue = $false

    If($ast -is [System.Management.Automation.Language.VariableExpressionAst]) {
        $ReturnValue = $true
    }
    return $ReturnValue
}

$asts.FindAll($VariablePredicate,$true)