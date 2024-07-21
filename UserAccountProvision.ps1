<#
Name: John Asare
Date: 2024-07-20

User account provision. Read more about this script at https://github.com/asarejohn001/UserAccountProvisioning
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
$csvPath = "/path/to/your/users.csv"

# Import the CSV file
$users = Import-Csv -Path $csvPath

# Loop through each user in the CSV
foreach ($user in $users) {
    # Create a password profile for the user
    $passwordProfile = @{
        forceChangePasswordNextSignIn = $true
        password = "InitialPassword123!" # You can generate a more secure password or handle this as needed
    }

    # Generate user principal name (UPN) and mail nickname
    $upn = "$($user.FirstName).$($user.LastName)@yourdomain.com"
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
        hireDate = $user.EmployeeHireDate
        officeLocation = $user.OfficeLocation
        passwordProfile = $passwordProfile
    }

    New-MgUser -BodyParameter $userDetails
}

# Output success message
Write-Host "Users have been created successfully."
