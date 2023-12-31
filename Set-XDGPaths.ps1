[Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', '%USERPROFILE%\.config\', 'User')
[Environment]::SetEnvironmentVariable('XDG_DATA_HOME', '%USERPROFILE%\.local\share', 'User')
[Environment]::SetEnvironmentVariable('XDG_STATE_HOME', '%USERPROFILE%\.local\state', 'User')
[Environment]::SetEnvironmentVariable('NVIM_LOG_FILE', '%USERPROFILE%\.local\state\nvim', 'User')
