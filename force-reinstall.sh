#!/bin/bash

# Force Reinstall Zed Hercules Script Extension
# This script completely removes all traces and reinstalls the extension

set -e

echo "🧹 Force reinstalling Zed Hercscript Extension..."
echo ""

# Get the extension directory
EXTENSION_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "📂 Extension directory: $EXTENSION_DIR"
echo ""

# Find Zed directories
ZED_SUPPORT="$HOME/Library/Application Support/Zed"
ZED_CACHE="$HOME/Library/Caches/Zed"
ZED_EXTENSIONS="$ZED_SUPPORT/extensions"

if [ ! -d "$ZED_SUPPORT" ]; then
    # Try Linux paths
    ZED_SUPPORT="$HOME/.config/zed"
    ZED_CACHE="$HOME/.cache/zed"
    ZED_EXTENSIONS="$ZED_SUPPORT/extensions"
fi

echo "🗑️  Step 1: Removing ALL traces of hercscript extension..."

# Remove from installed
if [ -d "$ZED_EXTENSIONS/installed/hercscript" ]; then
    rm -rf "$ZED_EXTENSIONS/installed/hercscript"
    echo "   ✅ Removed from installed/"
fi

# Remove from work
if [ -d "$ZED_EXTENSIONS/work/hercscript" ]; then
    rm -rf "$ZED_EXTENSIONS/work/hercscript"
    echo "   ✅ Removed from work/"
fi

# Remove any hercscript in root extensions
if [ -d "$ZED_EXTENSIONS/hercscript" ]; then
    rm -rf "$ZED_EXTENSIONS/hercscript"
    echo "   ✅ Removed from extensions/"
fi

echo ""
echo "🧹 Step 2: Clearing ALL Zed caches..."

# Clear all Zed caches
if [ -d "$ZED_CACHE" ]; then
    rm -rf "$ZED_CACHE"/*
    echo "   ✅ Cleared all Zed caches"
fi

# Clear language-specific caches in support directory
if [ -d "$ZED_SUPPORT/languages" ]; then
    rm -rf "$ZED_SUPPORT/languages"
    echo "   ✅ Cleared languages cache"
fi

# Clear grammars cache if exists
if [ -d "$ZED_SUPPORT/grammars" ]; then
    rm -rf "$ZED_SUPPORT/grammars"
    echo "   ✅ Cleared grammars cache"
fi

# Clear tree-sitter cache if exists
if [ -d "$ZED_SUPPORT/tree-sitter" ]; then
    rm -rf "$ZED_SUPPORT/tree-sitter"
    echo "   ✅ Cleared tree-sitter cache"
fi

echo ""
echo "✅ Complete cleanup finished!"
echo ""
echo "⚠️  IMPORTANT: Now you MUST do the following:"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1️⃣  QUIT Zed COMPLETELY"
echo "    Press: Cmd+Q (or File > Quit)"
echo "    DO NOT just close the window!"
echo ""
echo "2️⃣  Wait 3 seconds"
echo ""
echo "3️⃣  Open Zed again"
echo ""
echo "4️⃣  Install dev extension:"
echo "    Press: Cmd+Shift+P"
echo "    Type: zed: install dev extension"
echo "    Select: $EXTENSION_DIR"
echo ""
echo "5️⃣  Reload window:"
echo "    Press: Cmd+Shift+P"
echo "    Type: zed: reload window"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🧪 After reload, test with this code:"
echo ""
cat << 'EOF'
prontera,150,150,4	script	Test	100,{
    // All select must be YELLOW/ORANGE:

    select();                                      // ✅
    switch(select("I'd rather not:What's up?")) {  // ✅ THIS ONE!
        case 1: break;
        case 2: break;
    }
    .@x = select("Yes:No");                       // ✅
    if (select("A:B") == 1) { }                   // ✅

    end;
}
EOF
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🔍 If STILL not working after all this:"
echo ""
echo "   The issue is likely with how Zed loads grammar queries."
echo "   Please report this as a bug with:"
echo "   - Zed version"
echo "   - macOS/Linux version"
echo "   - Screenshot showing the issue"
echo ""
echo "💡 You can check Zed logs at:"
echo "   $ZED_SUPPORT/logs/"
echo ""

# Pause to make sure user reads this
read -p "Press Enter to confirm you'll follow the steps above... "

echo ""
echo "✅ Ready! Now QUIT ZED COMPLETELY (Cmd+Q) and follow the steps!"
echo ""
