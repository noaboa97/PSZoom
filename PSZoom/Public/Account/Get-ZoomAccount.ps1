<#

.SYNOPSIS
Get the details of the account.

.DESCRIPTION
Get the details of the account. You can only call this API if you have the approved partners permission to use a Master API.

.PARAMETER AccountId
The Account ID.

.PARAMETER ApiKey
The API Key.

.PARAMETER ApiSecret
The API Secret.

.LINK
https://marketplace.zoom.us/docs/api-reference/zoom-api/accounts/accountsettings
	
.EXAMPLE
Return the details of the Zoom Account.
Get-ZoomAccount

#>

function Get-ZoomAccount {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $False, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('id', 'account_id')]
        [string]$AccountId,

        [ValidateNotNullOrEmpty()]
        [string]$ApiKey,

        [ValidateNotNullOrEmpty()]
        [string]$ApiSecret
    )

    begin {
        #Generate Header with JWT (JSON Web Token) using the Api key/secret
        $Headers = New-ZoomHeaders -ApiKey $ApiKey -ApiSecret $ApiSecret
    }
    process {
        $request = [System.UriBuilder]"https://api.zoom.us/v2/accounts/$id"    
        $response = Invoke-ZoomRestMethod -Uri $request.Uri -Headers ([ref]$Headers) -Method GET -ApiKey $ApiKey -ApiSecret $ApiSecret
        
        Write-Output $response
    }	
}