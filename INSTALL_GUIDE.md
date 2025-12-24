# Installation Guide

## Quick Install

### macOS / Linux

```bash
cd zed-hercscript
chmod +x install.sh
./install.sh
```

Then reload Zed:
- Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Linux)
- Type: `zed: reload extensions`
- Press Enter

### Windows

1. Right-click `install.bat`
2. Select **"Run as administrator"**
3. Restart Zed

## Manual Installation

1. Copy or symlink `zed-hercscript` folder to:
   - **macOS**: `~/Library/Application Support/Zed/extensions/installed/hercscript`
   - **Linux**: `~/.local/share/zed/extensions/installed/hercscript`
   - **Windows**: `%LOCALAPPDATA%\Zed\extensions\installed\hercscript`

2. Reload Zed extensions

## Verify Installation

1. Open `example.txt`
2. Check bottom-right corner shows: **hercscript**
3. Verify syntax highlighting works

## Troubleshooting

### Extension not showing
- Make sure you reloaded extensions
- Check Zed logs: `Cmd+Shift+P` → "zed: open log"

### Syntax highlighting not working
- Verify the file has `.txt` extension
- Check the language indicator shows "hercscript"
- Try closing and reopening the file

### Uninstall

```bash
./install.sh --uninstall
```

Or manually delete:
```bash
rm -rf ~/Library/Application\ Support/Zed/extensions/installed/hercscript
```
