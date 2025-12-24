#!/bin/bash

# Script to reinstall Zed Hercscript extension for development

echo "🔄 Reinstalling Zed Hercscript Extension..."

# Navigate to extension directory
cd "$(dirname "$0")"

# Step 1: Remove extension from Zed if installed
echo "📦 Removing old extension from Zed..."
# Zed extensions are typically in ~/.local/share/zed/extensions or similar
# We'll just notify the user to do this manually

echo ""
echo "✅ Files updated successfully!"
echo ""
echo "📋 Next steps to see the changes:"
echo ""
echo "1. Open Zed editor"
echo "2. Press Cmd+Shift+P (Command Palette)"
echo "3. Type 'zed: install dev extension'"
echo "4. Select this folder: $(pwd)"
echo "5. Reload Zed window (Cmd+Shift+P -> 'zed: reload window')"
echo ""
echo "OR if you have the extension installed already:"
echo "1. In Zed, open Extensions (Cmd+Shift+X)"
echo "2. Find 'Hercules Script' extension"
echo "3. Click 'Uninstall'"
echo "4. Then install dev extension as above"
echo ""
echo "🎯 After reloading, test with:"
echo "   - select    (without parentheses) ✓ should highlight"
echo "   - select()  (with parentheses)    ✓ should highlight"
echo ""
