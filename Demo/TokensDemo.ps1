$err = $Null
$tokens = $Null
$Name = 'tag'
 
[System.Management.Automation.Language.Parser]::ParseInput('dir|echo', $name, [ref]$tokens,[ref]$err)
$tokens[1].Extent
#is not
[System.Management.Automation.PSParser]::Tokenize("dir|echo",[ref]$Null)

#Token types
[System.Management.Automation.Language.TokenKind]::pipe

# No extent information, just information as to where it is located.

# this is just here so I can f12 it during the demo.
Measure-mmsPipeUsage