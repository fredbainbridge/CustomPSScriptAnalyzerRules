#Breaking down a script

#unfriendly way to show, still very useful.
$sb = [scriptblock] {dir c:\windows; echo 'test'}
$ast = $sb.Ast
$Elements = $ast.FindAll({$true},$true)
#$Elements[3].Extent #Position info

.\Get-AstType.ps1
Get-AstType -ScriptPath .\Demo\ScriptBlock.ps1

<#  Copy and paste this into the ScriptBlock.ps1 for demo purposes.
out-null | get-process
#comments here
Try {
    $x / 0
} 
catch {
    "The universe doesnt work like that."
}
#>