#!/bin/bash

# Force Reinstall Zed Hercules Script Extension
# This script completely removes and reinstalls the extension to clear any cache

echo "🧹 Force reinstalling Zed Hercscript Extension..."
echo ""

# Get the extension directory
EXTENSION_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "📂 Extension directory: $EXTENSION_DIR"
echo ""

# Find Zed extensions directory
ZED_EXTENSIONS="$HOME/.config/zed/extensions"
if [ -d "$HOME/Library/Application Support/Zed/extensions" ]; then
    ZED_EXTENSIONS="$HOME/Library/Application Support/Zed/extensions"
fi

echo "🗑️  Step 1: Removing old extension from Zed..."
if [ -d "$ZED_EXTENSIONS/hercscript" ]; then
    rm -rf "$ZED_EXTENSIONS/hercscript"
    echo "   ✅ Removed old extension"
else
    echo "   ℹ️  No existing extension found"
fi

# Also check for installed extensions
if [ -d "$ZED_EXTENSIONS/installed/hercscript" ]; then
    rm -rf "$ZED_EXTENSIONS/installed/hercscript"
    echo "   ✅ Removed from installed directory"
fi

echo ""
echo "🧹 Step 2: Clearing Zed cache..."

# Clear language server cache
if [ -d "$HOME/Library/Caches/Zed" ]; then
    rm -rf "$HOME/Library/Caches/Zed/languages"
    echo "   ✅ Cleared macOS language cache"
fi

if [ -d "$HOME/.cache/zed" ]; then
    rm -rf "$HOME/.cache/zed/languages"
    echo "   ✅ Cleared Linux language cache"
fi

echo ""
echo "✅ Cleanup complete!"
echo ""
echo "📋 Next steps to install the extension:"
echo ""
echo "1. Open Zed editor"
echo "2. Press Cmd+Shift+P (or Ctrl+Shift+P on Linux)"
echo "3. Type: 'zed: install dev extension'"
echo "4. Select this folder: $EXTENSION_DIR"
echo "5. Press Cmd+Shift+P again"
echo "6. Type: 'zed: reload window'"
echo ""
echo "🧪 After reloading, test with this code:"
echo ""
cat << 'EOF'
prontera,150,150,4	script	Test	100,{
    // All of these should be YELLOW/ORANGE:

    select();                                      // ✅ Statement
    switch(select("I'd rather not:What's up?")) {  // ✅ Expression (FIXED!)
        case 1: break;
        case 2: break;
    }
    .@x = select("Yes:No");                       // ✅ Assignment
    if (select("A:B") == 1) { }                   // ✅ Condition

    end;
}
EOF
echo ""
echo "🎯 If select in switch(select()) is STILL white after this:"
echo "   The issue may be with Zed's grammar loading mechanism."
echo "   Try restarting Zed completely (Quit and reopen)."
echo ""
