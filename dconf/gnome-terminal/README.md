https://askubuntu.com/questions/967517/how-to-backup-gnome-terminal-emulator-settings

# Backup
```
dconf dump /org/gnome/terminal/ > gnome_terminal_settings_backup.txt
```

# Reset
```
dconf reset -f /org/gnome/terminal/
```

# Restore
```
dconf load /org/gnome/terminal/ < gnome_terminal_settings_backup.txt
```
