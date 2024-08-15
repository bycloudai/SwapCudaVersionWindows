# Optimized CUDA Version Switcher
# This script automates the process of switching between installed CUDA versions on Windows

param(
    [string]$Version,
    [switch]$ListVersions,
    [switch]$GetCurrent
)

# Function to get all installed CUDA versions
function Get-InstalledCUDAVersions {
    $cudaPath = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA"
    if (Test-Path $cudaPath) {
        return (Get-ChildItem $cudaPath -Directory).Name -replace '^v', ''
    }
    return @()
}

# Function to get current CUDA version
function Get-CurrentCUDAVersion {
    $cudaPath = [Environment]::GetEnvironmentVariable("CUDA_PATH", [EnvironmentVariableTarget]::Machine)
    if ($cudaPath) {
        return ($cudaPath -split 'v')[-1]
    }
    return $null
}

# Function to update environment variables
function Update-CUDAEnvironment($version) {
    $versionPath = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v$version"
    
    # Update CUDA_PATH variables
    [Environment]::SetEnvironmentVariable("CUDA_PATH", $versionPath, [EnvironmentVariableTarget]::Machine)
    [Environment]::SetEnvironmentVariable("CUDA_PATH_V$($version -replace '\.', '_')", $versionPath, [EnvironmentVariableTarget]::Machine)

    # Update Path variable
    $path = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
    $newPaths = @(
        "$versionPath\bin",
        "$versionPath\libnvvp"
    )
    
    $pathParts = $path -split ';' | Where-Object { $_ -notmatch 'NVIDIA GPU Computing Toolkit\\CUDA' }
    $newPath = ($newPaths + $pathParts) -join ';'
    
    [Environment]::SetEnvironmentVariable("Path", $newPath, [EnvironmentVariableTarget]::Machine)
}

# Function to switch CUDA version
function Switch-CUDAVersion($version) {
    $version = $version -replace '^v', ''
    $installedVersions = Get-InstalledCUDAVersions
    if ($version -in $installedVersions) {
        Update-CUDAEnvironment $version
        Write-Host "CUDA version switched to $version. Please restart your command prompt or applications for the changes to take effect."
    } else {
        Write-Host "Error: CUDA version $version is not installed."
        Write-Host "Installed versions: $($installedVersions -join ', ')"
        exit 1
    }
}

# Main script logic
$installedVersions = Get-InstalledCUDAVersions
if ($installedVersions.Count -eq 0) {
    Write-Host "No CUDA versions found. Please install CUDA Toolkit."
    exit 1
}

if ($ListVersions) {
    Write-Host "Installed CUDA versions:"
    $installedVersions | ForEach-Object { Write-Host $_ }
    exit 0
}

if ($GetCurrent) {
    $currentVersion = Get-CurrentCUDAVersion
    if ($currentVersion) {
        Write-Host "Current CUDA version: $currentVersion"
    } else {
        Write-Host "No CUDA version is currently set."
    }
    exit 0
}

if ($Version) {
    Switch-CUDAVersion $Version
} else {
    Write-Host "Available CUDA versions:"
    for ($i = 0; $i -lt $installedVersions.Count; $i++) {
        Write-Host "$($i + 1). $($installedVersions[$i])"
    }

    $selection = Read-Host "Enter the number of the CUDA version you want to switch to"
    $selectedVersion = $installedVersions[$selection - 1]

    if ($selectedVersion) {
        Switch-CUDAVersion $selectedVersion
    } else {
        Write-Host "Invalid selection. No changes made."
        exit 1
    }
}