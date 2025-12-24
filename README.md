# Hercules Script Language Support for Zed

Comprehensive language support for Hercules (herc.ws) scripting language.

## Features

- **Syntax Highlighting** - Full syntax highlighting for Hercules script
- **Code Folding** - Fold code blocks
- **Auto-closing Brackets** - Automatic bracket, quote, and brace closing
- **Indentation** - Smart indentation for control structures

## Syntax Support

- Comments (`//`, `/* */`)
- Keywords (`if`, `else`, `switch`, `case`, `for`, `while`, etc.)
- Built-in commands (`mes`, `next`, `close`, `setquest`, `getexp`, etc.)
- Script definitions
- NPC definitions
- Variables (`.@local`, `$global`, `@temp`, `#account`)
- Strings and numbers
- Operators

## Installation

This extension is for the Zed editor. Install via Zed's extension manager.

## Grammar

This extension uses [tree-sitter-hercscript](https://github.com/vietlubu/tree-sitter-hercscript) for parsing.

## License

MIT
