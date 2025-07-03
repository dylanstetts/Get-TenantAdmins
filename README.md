# Get-TenantAdmins
This PowerShell script connects to Microsoft Graph and exports a list of users assigned to directory roles (admin roles) in your tenant. The output includes each user's **Role Name**, **Display Name**, **User Principal Name (UPN)**, and **User ID**, and is saved to a CSV file for auditing or reporting purposes.

---

## Prerequisites

- PowerShell 5.1 or later
- [Microsoft Graph PowerShell SDK](https://learnftgraph/installation

Install the SDK if you haven’t already:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

## Required Permissions

The script requires the following Graph API permissions:

- RoleManagement.Read.Directory
- User.Read.All

You will be prompted to sign in and consent to these scopes when running the script.

# Output

The script generates a file named AdminUsers.csv in the current directory with the following columns:

- RoleName
- DisplayName
- UserPrincipalName
- UserId

## Example Use Case

This script is ideal for compliance audits, security reviews, or any scenario where you need to report on users with elevated privileges in your Microsoft 365 environment.
