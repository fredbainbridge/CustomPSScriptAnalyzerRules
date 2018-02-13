Import-LocalizedData -BindingVariable Messages
Function Measure-mmsFunctionPrefix {
    [CmdletBinding()]
    [OutputType([Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord[]])]
    Param (
        [Parameter(Mandatory=$true)]
        [System.Management.Automation.Language.ScriptBlockAst]
        $ScriptBlockAst
    )
    Begin {
        $Results = @()
    }
    Process {
        #Filter for just Functions
        [ScriptBlock]$FunctionPredicate = {
            param (
                [System.Management.Automation.Language.Ast]$ast
            )
            [bool]$ReturnValue = $false

            If($ast -is [System.Management.Automation.Language.FunctionDefinitionAst]) {
                $ReturnValue = $true
            }
            return $ReturnValue
        }
        #Use the AST filter to find the functions in the scriptblock
        [System.Management.Automation.Language.Ast[]]$FunctionBlockAsts 
        $FunctionBlockAsts = $ScriptBlockAst.FindAll($FunctionPredicate,$true)        
        foreach($ast in $FunctionBlockAsts) {
            if(-not ($Ast.Name -cmatch '^[A-Z][A-Za-z+]{1,}-mms[A-Z][a-z]{2,}')) {
                $Result = [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord] @{
                    "Message"  = $Messages.MeasureFunctionPrefix;
                    "Extent"   = $Ast.Extent;
                    "RuleName" = $PSCmdlet.MyInvocation.MyCommand.Name.Replace("Measure-","");
                    "Severity" = "Error"  
                }
                $Results += $Result
            }
        }
    }
    End {
        $Results
    }
}
Function Measure-mmsPipeUsage {
    [CmdletBinding()]
    [OutputType([Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord[]])]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.Language.Token[]]
        $Token
    )
    Begin {
        $results = @()
    }
    Process {
        foreach($t in $Token) {
            if($t.Kind -eq [System.Management.Automation.Language.TokenKind]::Pipe) {
                $result = [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord] @{
                    "Message"  = $Messages.MeasurePipeUsage;
                    "Extent"   = $t.Extent;
                    "RuleName" = $PSCmdlet.MyInvocation.MyCommand.Name.Replace("Measure-","");
                    "Severity" = "Warning"  
                }
                $results += $result
            }
        }
    }
    End {
        $results
    }
}
Function Measure-mmsShortVariable {
    [CmdletBinding()]
    [OutputType([Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord[]])]
    Param (
        [Parameter(Mandatory=$true)]
        [System.Management.Automation.Language.ScriptBlockAst]
        $ScriptBlockAst
    )
    Begin {
        $Results = @()
    }
    Process {
        #Filter for just Functions
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
        #Use the AST filter to find the functions in the scriptblock
        [System.Management.Automation.Language.Ast[]]$VariableBlockAsts 
        $VariableBlockAsts = $ScriptBlockAst.FindAll($VariablePredicate,$true)        
        foreach($ast in $VariableBlockAsts) {
            if($ast.Extent.Text.Length -lt 4) {
                $Result = [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord] @{
                    "Message"  = $Messages.MeasureShortVariable;
                    "Extent"   = $Ast.Extent;
                    "RuleName" = $PSCmdlet.MyInvocation.MyCommand.Name.Replace("Measure-","");
                    "Severity" = "Error"  
                }
                $Results += $Result
            }
        }
    }
    End {
        $Results
    }
}