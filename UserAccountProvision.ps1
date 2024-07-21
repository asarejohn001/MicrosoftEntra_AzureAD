<#
Name: John Asare
Date: 2024-07-20

User account provision. Read more about this script at https://github.com/asarejohn001/UserAccountProvisioning
#>

# Install the AzureAD module if you haven't already
Install-Module AzureAD -Scope CurrentUser

# Import the Azure AD module
Import-Module AzureAD

# Connect to Azure AD
Connect-AzureAD

# Path to the CSV file
$csvPath = "C:\path\to\your\users.csv"

# Import the CSV file
$users = Import-Csv -Path $csvPath

# Loop through each user in the CSV
foreach ($user in $users) {
    # Create a password profile for the user
    $passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $passwordProfile.Password = "InitialPassword123!" # You can generate a more secure password or handle this as needed
    $passwordProfile.ForceChangePasswordNextLogin = $true

    # Generate user principal name (UPN) and mail nickname
    $upn = "$($user.FirstName).$($user.LastName)@yourdomain.com"
    $mailNickname = "$($user.FirstName)$($user.LastName)"

    # Create the user
    New-AzureADUser -DisplayName "$($user.FirstName) $($user.LastName)" `
                    -PasswordProfile $passwordProfile `
                    -UserPrincipalName $upn `
                    -MailNickname $mailNickname `
                    -AccountEnabled $false `
                    -JobTitle $user.JobTitle `
                    -CompanyName $user.CompanyName `
                    -Department $user.Department `
                    -EmployeeId $user.EmployeeID `
                    -EmployeeType $user.EmployeeType `
                    -HireDate $user.EmployeeHireDate `
                    -OfficeLocation $user.OfficeLocation `
                    -UsageLocation "US"
}

# Output success message
Write-Host "Users have been created successfully."

