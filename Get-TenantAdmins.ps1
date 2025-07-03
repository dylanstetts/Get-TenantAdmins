# Connect to Microsoft Graph
Connect-MgGraph -Scopes "RoleManagement.Read.Directory", "User.Read.All"

# Get all directory roles
$roles = Get-MgDirectoryRole

# Prepare results
$adminUsers = @()

foreach ($role in $roles) {
    $members = Get-MgDirectoryRoleMember -DirectoryRoleId $role.Id
    foreach ($member in $members) {
        try {
            $user = Get-MgUser -UserId $member.Id -ErrorAction Stop
            $adminUsers += [PSCustomObject]@{
                RoleName           = $role.DisplayName
                DisplayName        = $user.DisplayName
                UserPrincipalName  = $user.UserPrincipalName
                UserId             = $user.Id
            }
        } catch {
            # If user not found, log only the role and GUID
            $adminUsers += [PSCustomObject]@{
                RoleName           = $role.DisplayName
                DisplayName        = "N/A"
                UserPrincipalName  = "N/A"
                UserId             = $member.Id
            }
        }
    }
}

# Export to CSV
$adminUsers | Export-Csv -Path "AdminUsers.csv" -NoTypeInformation
