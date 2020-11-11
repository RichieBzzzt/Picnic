Function Get-ItRight {
    param(
        [parameter(Mandatory = $false, ParameterSetName = 'Bearer')][string] $bearerToken,
        [parameter(Mandatory = $true, ParameterSetName = 'AADwithOrgId')][string] $applicationId,
        [parameter(Mandatory = $true, ParameterSetName = 'AADwithOrgId')][string] $secret,
        [parameter(Mandatory = $true, ParameterSetName = 'AADwithOrgId')][string] $tenantId
    )

    if ([string]::IsNullOrEmpty($bearerToken)) {
        if ($PSCmdlet.ParameterSetName -eq "AADwithOrgId") {
            Write-Host "&&&& Connecting via Connect-DataBricks Using Service Principal &&&&"
        }
        else {
            $myBearerTokenFile = ".\myBearerToken.txt"
            $myBearerTokenFileExists = Test-Path $myBearerTokenFile
            If ($myBearerTokenFileExists -eq $True) {
                $BearerToken = Get-Content -Path $myBearerTokenFile -Raw
                Write-Host $BearerToken  
            }
            else {
                Write-Error "$myBearerTokenFile does not exist. Create and add a bearerToken from workspace to file."
                Throw
            }
            Write-Host "++++ Connecting via Connect-DataBricks Using a BearerToken ++++"
        }
    }
    else {
        Write-Host "++++ Connecting via Connect-DataBricks Using a BearerToken ++++"
    }
}

Get-ItRight