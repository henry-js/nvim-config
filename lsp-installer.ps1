function Add-ToPath {
    param (
        [string]$ContainingFolder
    )

    $paths = [System.Environment]::GetEnvironmentVariable('Path', 'User') -split ';' | Where-Object { $_ -ne "" }
    $exists = ($paths -like "$ContainingFolder*")[0]

    $userProf = $env:USERPROFILE -replace "\\", '\\'

    $ContainingFolder = $ContainingFolder -replace $userProf, '%USERPROFILE%'
    if (-not $exists) {
        $paths += $ContainingFolder
        $pathsString = $paths -join ';'
        [System.Environment]::SetEnvironmentVariable('Path', $pathsString, 'User')
        Write-Host "Added '$ContainingFolder' to user `$PATH"
    }
    else {
        Write-Host "'$exists' already exists in user `$PATH"
    }
}

function ReadAndFixEnvVars() {

    Write-Host "Fixing user `$PATH variable"
    $paths = $paths = [System.Environment]::GetEnvironmentVariable('Path', 'User') -split ';' | Where-Object { $_ -ne "" }
    $newVals = $paths | ForEach-Object {
        $localAppData = $env:LOCALAPPDATA -replace "\\", '\\'
        $userProf = $env:USERPROFILE -replace "\\", '\\'
        switch -Regex ($_) {
            $localAppData { $_ -replace $localAppData, "%LOCALAPPDATA%"; break }
            $userProf { $_ -replace $userProf, "%USERPROFILE%"; break }
            Default {
                $_
            }
        }
    }
    $changedCount = 0
    for ($i = 0; $i -lt $newVals.Count; $i++) {
        if ( $paths[$i] -ne $newVals[$i]) {
            Write-Host $paths[$i] -NoNewline -ForegroundColor Red
            Write-Host " => " -NoNewline
            Write-Host $newVals[$i] -ForegroundColor Green
            $changedCount += 1;
        }
    }

    $continue = Read-Host -Prompt "Do you want to save these new values? (y/n)"

    if ($continue -ne 'y') {
        Write-Host "Goodbye!"
        break;
    }
    else {
        $newPath = $newVals -join ';'
        [System.Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
    }
}

function global:Add-ZippedLsp() {
    param(
        [string]$Uri,
        [string]$Name,
        [string]$BinFolder
    )
    $root = "$HOME\.lsps"
    if (-not (Test-Path $root)) { mkdir $root -Verbose }
    else { Write-Host ".lsps folder exists in $HOME" -ForegroundColor Green }

    $OutFile = Join-Path $root "$Name.zip"
    Invoke-WebRequest -Uri $Uri -OutFile $OutFile
    $DestinationPath = Join-Path $root $Name
    Expand-Archive -Path $OutFile -DestinationPath $DestinationPath -Force
    Remove-Item $OutFile
    $ContainingFolder = Join-Path $DestinationPath $BinFolder
    Add-ToPath -ContainingFolder $ContainingFolder
}

if (-not $IsWindows) { Write-Host "this script supports windows only"; Exit }

[hashtable[]]$ParamsList = @();
# lua_ls
$ParamsList += @{
    Name      = "lua-language-server"
    Uri       = "https://github.com/LuaLS/lua-language-server/releases/latest/download/lua-language-server-3.7.4-win32-x64.zip"
    BinFolder = "bin"
}
# Add-ZippedLsp -Uri $Uri -Name $lspFolder -BinFolder "bin"


# PowerShellEditorServices
$ParamsList += @{
    Name      = "PowerShellEditorServices"
    Uri       = "https://github.com/PowerShell/PowerShellEditorServices/releases/latest/download/PowerShellEditorServices.zip"
    BinFolder = "PowerShellEditorServices"
}

# Add-ZippedLsp -Uri $Uri -Name $lspFolder -BinFolder $lspFolder

# Omnisharp
$ParamsList += @{
    Name      = "OmniSharp"
    Uri       = "https://github.com/OmniSharp/omnisharp-roslyn/releases/latest/download/omnisharp-win-x64-net6.0.zip"
    BinFolder = $null
}

$ParamsList | ForEach-Object -Parallel {
    Add-ZippedLsp @_
}
# ReadAndFixEnvVars
