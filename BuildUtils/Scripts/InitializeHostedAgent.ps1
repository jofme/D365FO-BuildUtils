 [Cmdletbinding()]
Param(
    [Parameter(Mandatory=$true, HelpMessage="Path to source root")]
    [string]$SourceRoot=$null,

    [Parameter(Mandatory=$false, HelpMessage="Licenses file directory")]
    [string]$LicensePath='License'
)

function Load-Module ($m) {
    if (!(Get-Module | Where-Object {$_.Name -eq $m})) {
        if (Get-Module -ListAvailable | Where-Object {$_.Name -eq $m}) {
            Import-Module $m -Verbose
        }
        else {
            if (Find-Module -Name $m | Where-Object {$_.Name -eq $m}) {
                Install-Module -Name $m -Force -Verbose -Scope CurrentUser
                Import-Module $m -Verbose
            }
        }
    }
}

Load-Module "d365fo.tools"
Write-Output "##vso[task.setvariable variable=licenseExists]$(Test-Path -Path "$($sourceRoot)/$($LicensePath)/*.txt")" 
