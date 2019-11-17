function Import-FitekDimension {
    <#
    .SYNOPSIS
        DimensionsImport.v2
    .DESCRIPTION
        Imports dimensions to fitek to particular company based on provided AuthToken
    .PARAMETER Data
        Array of objects with dimension information:
        Name      : Description
        EndDate   : 2019-11-02
        StartDate : 2019-11-02
        Code      : Code
    .EXAMPLE
        Import-FitekDimension -Id 'Dep' -AuthToken 'SOME_TOKEN' -Data $data
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [object]
        $Data,

        [Parameter(Mandatory = $true)]
        [string]
        [Alias('Id')]
        $DimensionId,

        [Parameter(Mandatory = $false)]
        [string]
        $AuthToken,

        [Parameter(Mandatory = $false)]
        [switch]
        $PropagateToChild = $false,

        [Parameter(Mandatory = $false)]
        [switch]
        $DeleteUnused = $false
    )

    process {
        $apiUri = $MyInvocation.MyCommand.Module.PrivateData.ApiUri
        $url = "{0}/dstream/ExportService/ErpDataExchangeService.svc/DimensionsImport.v2?AuthToken={1}&propagateToChild={2}&deleteUnused={3}" -f $apiUri, $AuthToken, $PropagateToChild, $DeleteUnused

        $request = New-Object psobject -Property @{
            Dimensions = $Data
            Id         = [GUID]::NewGuid().Guid
            ParentCode = $DimensionId
        }

        $body = ($request | ConvertTo-Json)

        try {
            $result = Invoke-RestMethod $url -Method Post -ContentType "application/json; charset=utf-8" -Body $body
            $result.ImportResponse
        } catch {
            Write-Error $_.Exception
        }
    }
}

function Import-FitekVatCode {
    <#
    .SYNOPSIS
        VatCodesImport.v2
    .DESCRIPTION
        Imports VAT codes to particular company based on provided AuthToken
    .PARAMETER Data
        Array of objects with VAT information:
        Code      : Code
        Name      : Description
        EndDate   : 2019-11-02
        StartDate : 2019-11-02
        AuthToken : AuthToken
        IsDefault : false/true
        VatRate   : 14.0
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [object]
        $Data,

        [Parameter(Mandatory = $true)]
        [string]
        $AuthToken,

        [Parameter(Mandatory = $false)]
        [switch]
        $PropagateToChild = $false,

        [Parameter(Mandatory = $false)]
        [switch]
        $DeleteUnused = $false
    )

    process {
        $apiUri = $MyInvocation.MyCommand.Module.PrivateData.ApiUri
        $url = '{0}/dstream/ExportService/ErpDataExchangeService.svc/VatCodesImport.v2?AuthToken={1}&propagateToChild={2}&deleteUnused={3}' -f $apiUri, $AuthToken, $PropagateToChild, $DeleteUnused

        $request = New-Object psobject -Property @{
            Id = [GUID]::NewGuid().Guid
            VatCodes = $Data
        }

        $body = ($request | ConvertTo-Json)

        try {
            $result = Invoke-RestMethod $url -Method Post -ContentType "application/json; charset=utf-8" -Body $body
            $result.ImportResponse
        } catch {
            Write-Error $_.Exception
        }
    }
}
