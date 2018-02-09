# mmsPipeUsage

**Severity Level: Warning**

## Description

The use of the pipe "|" should be avoided in general.  It is an expensive process that is generally never the best option.  ```foreach($x in $y) { }``` or something similiar is always preferred.

This rules looks for any occurences of the pipe.

```
Get-Process | Stop-Process
```

A proper function declaration would look like so:

```
$procs = Get-Process
foreach($proc in $procs) {
    Stop-Process -ID $proc.ID
}
```

