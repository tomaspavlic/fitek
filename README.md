[![GitHub release](https://img.shields.io/github/release/tomaspavlic/fitek.svg?style=for-the-badge)](https://github.com/tomaspavlic/fitek/releases/latest)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/Fitek.svg?style=for-the-badge)](https://www.powershellgallery.com/packages/Fitek)
![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge)

# [Fitek]([https://](https://github.com/tomaspavlic/fitek))

Fitek is a Windows PowerShell module to interact with Fitek via a REST API, while maintaining a consistent PowerShell look and feel.

## Installation

Install Fitek from the PowerShell Gallery! Install-Module requires PowerShellGet (included in PS v5, or download for v3/v4 via the gallery link)

```powershell
# One time only install:
Install-Module Fitek -Scope CurrentUser

# Check for updates occasionally:
Update-Module Fitek
```

## Examples

```powershell
# Import the module
Import-Module Fitek

$dimension1 = New-Object psobject -Property @{
    Name      = "Description"
    EndDate   = "2019-11-02T00:00:00.000Z"
    StartDate = "2019-11-02T00:00:00.000Z"
    Code      = "Code"
}

$dimensions = New-Object System.Collections.ArrayList($null)
$dimensions.Add($dimension1)

# Import dimension
Import-FitekDimension -AuthToken 'b12cf33b-0c4b-4d9e-9aa0-e238069b3fe7' -Data $dimensions -Id 'Dep'
```

### Disclaimer
This project was developed because of need to implement Fitek. I'm aware the module does not include all available endpoint functions.

> This is an open source project (under the MIT license), and all contributors are volunteers. All commands are executed at your own risk. Please have good backups before you start, because you can delete a lot of stuff if you're not careful.