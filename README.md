# Managing User Accounts with PowerShell

## UserAccountProvisioning
The [UserAccountProvision script](UserAccountProvision.ps1) will create multiple user accounts in your Microsft Entra.
The script will:
1. Install [Microsoft Graph](https://learn.microsoft.com/en-us/powershell/microsoftgraph/installation?view=graph-powershell-1.0). If you already have it installed, you can skip or comment it out.
2. Import the Microsft Graph module.
3. Define the permission scope you need to create the user accounts.
4. [Connect](https://learn.microsoft.com/en-us/powershell/microsoftgraph/get-started?view=graph-powershell-1.0) to tenant.
5. Saved the CSV file containing the new hire info into a variable.
6. Declare a path to log any errors and success. This will help the investigation task.
> [!IMPORTANT]  
> Make sure you change the path to where you saved your CSV file and created your Txt file for the logs.
7. Create a variable to import the CSV file.
8. Another variable to track errors so we can create a log file later.
9. Loops through the [csv file](New%20Hires.csv) and create each user account using the information from the file.
10. Disconnects from Microsoft Graph

## Deprovision
The [Deprovision User Account script](DeprovisionUserAccount.ps1) will delete the user's account from Microsoft Entra. The script will:
1. Repeat steps 1 to 8 from the [User Account Provision script](UserAccountProvision.ps1).
2. Loop through the [CSV file](offboard.csv)containing the UPN.
3. Delete each user account.
4. Log into the [log file](Log.txt).
