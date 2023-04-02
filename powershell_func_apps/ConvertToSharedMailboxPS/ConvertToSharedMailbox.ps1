using namespace System.Net
using namespace System.Web


# param($req, $TriggerMetadata)

# $ErrorActionPreference = 'Stop'

# # Load request body
# $requestBody = Get-Content $req -Raw | ConvertFrom-Json
# $userId = $requestBody.userId


function ConvertToSharedMailbox([string]$userId) {
    # Set your PowerShell credentials for Exchange Online
    $Username = $env:EXCHANGE_USERNAME
    $Password = $env:EXCHANGE_PASSWORD | ConvertTo-SecureString -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($Username, $Password)

    try {
        # Import Exchange Online Management module
        Import-Module ExchangeOnlineManagement -ErrorAction Stop

        # Connect to Exchange Online
        Connect-ExchangeOnline -Credential $credential -ErrorAction Stop

        # Convert user mailbox to shared mailbox
        #Set-Mailbox -Identity $userId -Type Shared -ErrorAction Stop
        $result = Get-Mailbox -Identity $userId

        # Disconnect from Exchange Online
        Disconnect-ExchangeOnline -Confirm:$false -ErrorAction Stop

        # Return success response
        # $response = @{
        #     StatusCode = 200
        #     Body = "User account successfully converted to shared mailbox."
        # }

        return $result
    } catch {
        # Return error response
        # $response = @{
        #     StatusCode = 500
        #     Body = "An error occurred: $($_.Exception.Message)"
        # }
        return _$
    }

    #Push-OutputBinding -Name res -Value ([HttpResponseContext]$response)
}