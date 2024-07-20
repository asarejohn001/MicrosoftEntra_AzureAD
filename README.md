# UserAccountProvisioning

This PowerShell scrip will create an account in your Office 365 tenant.
Here are the things it will do:
1. Create user account in Office 365 tenant using account properties from a csv
2. Edit the account's properties to match the info from the csv
3. Assign a temporary password and disable the account
4. Set the usage location
5. Assign Office 365 license
6. Add the account to a default group