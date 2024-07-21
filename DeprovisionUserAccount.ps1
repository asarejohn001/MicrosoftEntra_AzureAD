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
$csvPath = "./offboard.csv"

# Path to the error log file
$errorLogPath = "./Log.txt"

# Import the CSV file
$users = Import-Csv -Path $csvPath

# Initialize error count
$errorCount = 0

function Update-LogFile {
    param (
        [string]$message,
        [string]$logFilePath
    )
    $dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$dateTime - $message"
    Add-Content -Path $logFilePath -Value $logMessage
}

# Loop through each user in the CSV
foreach ($user in $users) {
    try {
        # Delete the user
        Remove-MgUser -UserId $user.UserPrincipalName -Confirm:$false
        $successMessage = "Deleted user: $($user.UserPrincipalName)"
        Update-LogFile -message $successMessage -logFilePath $errorLogPath
        Write-Host "User accounts deleted, check log file"

    } catch {
        $errorMessage - "Failed to delete user: $($user.UserPrincipalName)"
        Update-LogFile -message $errorMessage -logFilePath $errorLogPath
        $errorCount++
        Write-Host "Failed to delete account, check log file"
    }
}

# Output final status
if ($errorCount -eq 0) {
    Write-Host "All users have been processed successfully."
} else {
    Write-Host "There were errors during user deletion. Please check the log file at $errorLogPath for details."
}
