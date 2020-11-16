Function Get-ItRight2 {
    param(
        [parameter(Mandatory = $false)][string] $versionNumber
    )
    if (Get-Module -ListAvailable -Name adb.cicd.tools) {
        Write-Host "adb.cicd.tools module already installed"
    } 
    else {
        try {
            Install-Module adb.cicd.tools -Force -AllowPrerelease -MinimumVersion 0.2.136-ci 
        }
        catch [Exception] {
            Write-Host "oh dear install-module adb.cicd.tools failed, attempting to update PowerShellGet and trying again." -ForegroundColor Magenta
            $_
            try {
                Install-Module -Name PowerShellGet -Scope CurrentUser -Force -AllowClobber
                Install-Module adb.cicd.tools -Force -AllowPrerelease -MinimumVersion 0.2.136-ci 
            }
            catch [Exception] {
                Write-Host "oh dear install-module PowerShellGet failed" -ForegroundColor Black -ForegroundColor Red
                $_
                Throw
            }
        }
    }
}