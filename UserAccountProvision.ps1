<#
Name: John Asare
Date: 2024-07-20

User account provision. Read more about this script at https://github.com/asarejohn001/UserAccountProvisioning
#>

# Install Microsoft Graph PowerShell module if you haven't already
#Install-Module Microsoft.Graph -Scope CurrentUser

# Import the Microsoft Graph PowerShell module
Import-Module Microsoft.Graph

# Define the scopes (permissions) needed for the connection
$scopes = @(
    "User.Read.All",
    "Group.Read.All",
    "Directory.Read.All",
    "Directory.AccessAsUser.All"
)

# Connect to Microsoft Graph
Connect-MgGraph -Scopes $scopes -NoWelcome

# Verify the connection
$tenantDetails = Get-MgOrganization
$tenantDetails.DisplayName
