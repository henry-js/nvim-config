if ($IsWindows) {
winget install Neovim.Neovim
} 
else if ($IsLinux) {
    
} else {
    Write-Host "MacOS is not supported"
    Exit;
}
