# mmsFunctionPrefix

**Severity Level: Warning**

## Description

Custom functions should follow the defined naming standard in order to easily differentiate calls to custom functions vs non-custom functions.

The rule looks for any functions that do not fit the naming standard of Verb-mmsNoun.  The first character of the Verb must be capitalized.  The Noun must be at least 2 characters and 'mms' should prepend the noun in all cases.

```
function Show-Widget {
    Write-Verbose "This violates the rule."
}
```

A proper function declaration would look like so:

```
function Show-mmsWidget {
    Write-Verbose "This does not violate the rules."
}
```

