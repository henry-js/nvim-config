[Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', '%USERPROFILE%\.config\', 'User')
[Environment]::SetEnvironmentVariable('XDG_DATA_HOME', '%XDG_CONFIG_HOME%\.local\', 'User')
[Environment]::SetEnvironmentVariable('XDG_STATE_HOME', '%XDG_CONFIG_HOME%\.local\', 'User')
[Environment]::SetEnvironmentVariable('NVIM_LOG_FILE', '%XDG_CONFIG_HOME%\.local\nvim-data', 'User')
