# SwapCudaVersionPrompt.ps1
# Usage: Run as administrator. It will ask you for the CUDA version you'd like to use.

$targetVersion = Read-Host "Enter the desired CUDA version (e.g., 11.3)"
$envPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
$cudaPath = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v$targetVersion"
$binPath = "$cudaPath\bin"
$libnvvpPath = "$cudaPath\libnvvp"

if (-Not (Test-Path $cudaPath)) {
    Write-Host "ERROR: CUDA version $targetVersion is not installed at expected location: $cudaPath"
    exit
}

# Update CUDA_PATH
[System.Environment]::SetEnvironmentVariable("CUDA_PATH", $cudaPath, "Machine")
Write-Host "✅ Updated CUDA_PATH to $cudaPath"

# Update system Path

# Remove target version's bin/libnvvp if they exist
$filteredPaths = $envPath.Split(";") | Where-Object {
    ($_ -ne $binPath) -and ($_ -ne $libnvvpPath)
}

# Insert target paths at the front
$newPaths = @($binPath, $libnvvpPath)
$updatedPath = ($newPaths + $filteredPaths) -join ";"

# Save updated path
[System.Environment]::SetEnvironmentVariable("Path", $updatedPath, "Machine")

Write-Host "✅ Updated system Path to prioritize CUDA $targetVersion"
Write-Host ""
Write-Host "Please restart your terminal and run 'nvcc --version' to verify the change."