# Changelog

All notable changes to the Hercules Script extension for Zed will be documented in this file.

## [0.3.0] - 2024-12-24

### Added
- Built-in command support for Hercules-style syntax without parentheses
- Support for commands like `mes "text";`, `next;`, `close;`
- Syntax highlighting for 60+ built-in commands
- Full parsing support for Hercules script structure

### Changed
- Replaced external scanner with simple regex for NPC names
- Updated tree-sitter grammar to v3334a0f
- Improved query files (highlights, indents, outline, textobjects)

### Fixed
- Query error with function_stmt vs function_call
- Parser errors with Hercules-style command syntax
- Include directive in scanner.c

## [0.2.0] - Initial Release

### Added
- Basic syntax highlighting
- Comment support
- Keyword highlighting
- Number and string literals
