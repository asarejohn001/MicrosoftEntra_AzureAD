<#
Name: John Asare
Date: 2024-07-20

User account provision. Read more about this script at https://github.com/asarejohn001/UserAccountProvisioning
#>

# Install the Microsoft.Graph if not already
#Install-Module Microsoft.Graph -Scope CurrentUser

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
$csvPath = "./New Hires.csv"

# Path to the error log file
$errorLogPath = "./Log.txt"

# Import the CSV file
$users = Import-Csv -Path $csvPath

# Initialize error count
$errorCount = 0

# Function to log errors with a timestamp
function Log-Error {
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
        # Create a password profile for the user
        $passwordProfile = @{
            forceChangePasswordNextSignIn = $true
            password = "InitialPassword123!" # You can generate a more secure password or handle this as needed
        }

        # Generate user principal name (UPN) and mail nickname
        $upn = "$($user.FirstName).$($user.LastName)@ajgroupservice.com"
        $mailNickname = "$($user.FirstName)$($user.LastName)"

        # Create the user
        $userDetails = @{
            accountEnabled = $true
            displayName = "$($user.FirstName) $($user.LastName)"
            mailNickname = $mailNickname
            userPrincipalName = $upn
            jobTitle = $user.JobTitle
            companyName = $user.CompanyName
            department = $user.Department
            employeeId = $user.EmployeeID
            employeeType = $user.EmployeeType
            officeLocation = $user.OfficeLocation
            passwordProfile = $passwordProfile
        }
        $newUser = New-MgUser -BodyParameter $userDetails
        $successMessage = "Created user: $($user.UserPrincipalName)"
        Log-Error -message $successMessage -logFilePath $errorLogPath
        Write-Host "successfully created accounts"

        # Delay for about 1 minite to ensure the account is fully created
        Start-Sleep -Seconds 60

        # Update the user's hire date in a subsequent PATCH request
        $hireDateDetails = @{
            hireDate = $user.EmployeeHireDate
        }
        Update-MgUser -UserId $newUser.Id -BodyParameter $hireDateDetails

    } catch {
        # Log the error to a file and increment the error count
        $errorMessage = "Error creating user $($user.FirstName) $($user.LastName): $($_.Exception.Message)"
        Log-Error -message $errorMessage -logFilePath $errorLogPath
        $errorCount++
        Write-Host "There were issues creating the accounts. Check the log file for more details"
        break
    }
}

# Output final status
if ($errorCount -eq 0) {
    Write-Host "All users have been created successfully."
} else {
    Write-Host "There were errors during user creation. Please check the log file at $errorLogPath for details."
}

# Disconnect from Microsoft Graph
Disconnect-Graph