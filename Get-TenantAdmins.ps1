# Connect to Microsoft Graph with the required scopes
Connect-MgGraph -Scopes "RoleManagement.Read.Directory", "User.Read.All"

# Get all directory roles
$roles = Get-MgDirectoryRole

# Prepare an array to store results
$adminUsers = @()

foreach ($role in $roles) {
    $members = Get-MgDirectoryRoleMember -DirectoryRoleId $role.Id
    foreach ($member in $members) {
        # Get user details
        $user = Get-MgUser -UserId $member.Id
        $adminUsers += [PSCustomObject]@{
            RoleName           = $role.DisplayName
            DisplayName        = $user.DisplayName
            UserPrincipalName  = $user.UserPrincipalName
            UserId             = $user.Id
        }
    }
}

# Export to CSV
$adminUsers | Export-Csv -Path "AdminUsers.csv" -NoTypeInformation
