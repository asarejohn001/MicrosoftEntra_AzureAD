<#
Name: John Asare
Date: 2024-07-20

Description: Go to https://github.com/asarejohn001/MicrosoftEntra_AzureAD to learn more about this script
#>

# Import the Microsoft Graph PowerShell module
Import-Module Microsoft.Graph

# Define the scopes (permissions) needed for the connection
$scopes = @(
    "User.ReadWrite.All",
    "Directory.ReadWrite.All"
)

# Connect to Microsoft Graph
Connect-MgGraph -Scopes $scopes

# Path to the CSV file
$csvPath = "/path/to/your/users_to_delete.csv"
# Path to the error log file
$errorLogPath = "/path/to/delete_error.log"

# Import the CSV file
$users = Import-Csv -Path $csvPath

# Initialize error count
$errorCount = 0

# Loop through each user in the CSV
foreach ($user in $users) {
    try {
        # Delete the user
        Remove-MgUser -UserId $user.UserPrincipalName -Confirm:$false
        Write-Host "Deleted user: $($user.UserPrincipalName)"
    } catch {
        # Log the error to a file and increment the error count
        $errorMessage = "Error deleting user $($user.UserPrincipalName): $($_.Exception.Message)"
        Add-Content -Path $errorLogPath -Value $errorMessage
        $errorCount++
        Write-Host $errorMessage
    }
}

# Output final status
if ($errorCount -eq 0) {
    Write-Host "All users have been deleted successfully."
} else {
    Write-Host "There were errors during user deletion. Please check the log file at $errorLogPath for details."
}
