# Managing User Accounts with PowerShell

## UserAccountProvisioning
The [UserAccountProvision script](UserAccountProvision.ps1) will create multiple user accounts in your Microsft Entra.
The script will:
1. Install [Microsoft Graph](https://learn.microsoft.com/en-us/powershell/microsoftgraph/installation?view=graph-powershell-1.0). If you already have it installed, you can skip or comment it out.
2. Import the Microsft Graph module.
3. Defined the permission scope you need to create the user accounts.
4. [Connect](https://learn.microsoft.com/en-us/powershell/microsoftgraph/get-started?view=graph-powershell-1.0) to tenant.
5. Saved the csv file containing the new hire info into a variable.
> [!IMPORTANT]  
> Make sure you change the path to where you have saved your csv file.

## Deprovision