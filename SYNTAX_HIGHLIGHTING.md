# Syntax Highlighting Guide

## Function Highlighting Behavior

This extension provides syntax highlighting for Hercules Script with special handling for built-in functions and user-defined functions.

### Built-in Commands (Without Parentheses)

Hercules Script traditionally uses built-in commands **without parentheses**:

```hercscript
mes "Hello World";
select "Option 1", "Option 2";
getitem 501, 1;
warp "prontera", 150, 150;
```

✅ These will be highlighted as **built-in functions** (typically in yellow/orange color).

### Function Calls (With Parentheses)

When using parentheses syntax for function calls:

```hercscript
myfunction();
calculateDamage(100, 50);
callfunc("MyFunction", arg1, arg2);
```

#### User-Defined Functions
- ✅ Will be highlighted as **regular functions** (typically in blue/cyan color)
- Examples: `myfunction()`, `calculateDamage()`, `customScript()`

#### Built-in Functions with Parentheses
- ⚠️ **Limited support**: The grammar currently does not fully support built-in commands with parentheses
- `mes()`, `select()`, etc. may not parse correctly if used with parentheses
- **Recommendation**: Use the traditional Hercules syntax without parentheses for built-in commands

### Summary

| Syntax Style | Built-in Commands | User-Defined Functions |
|--------------|-------------------|------------------------|
| Without parentheses | ✅ `mes "text";` | ❌ Not supported |
| With parentheses | ⚠️ Limited support | ✅ `myfunction();` |

### Best Practices

1. **Use traditional Hercules syntax for built-in commands:**
   ```hercscript
   mes "Welcome!";
   select "Yes", "No";
   getitem 501, 1;
   ```

2. **Use parentheses for user-defined functions:**
   ```hercscript
   myfunction();
   callfunc("CustomScript");
   ```

3. **Mix both styles appropriately:**
   ```hercscript
   prontera,150,150,4	script	MyNPC	100,{
       mes "Starting quest...";  // Built-in without parentheses
       .@result = checkQuestStatus();  // User-defined with parentheses
       if (.@result) {
           mes "Quest complete!";
           getitem 501, 1;
       }
   }
   ```

## Color Reference

The exact colors depend on your Zed theme, but typically:

- **Keywords** (if, else, for, while, switch): Purple/Magenta
- **Built-in functions**: Yellow/Orange
- **User-defined functions**: Blue/Cyan
- **Strings**: Green
- **Numbers**: Light blue/Cyan
- **Comments**: Gray/Dimmed

## Supported Built-in Commands

The extension recognizes hundreds of Hercules built-in commands including:

- **Dialog**: mes, mesf, next, close, menu, select, prompt, input
- **Items**: getitem, delitem, countitem, equip, unequip
- **Character**: warp, heal, jobchange, resetlvl, resetstatus
- **Quests**: setquest, erasequest, completequest, questprogress
- **NPCs/Monsters**: monster, killmonster, summon, mobcount
- **And many more...**

See the [grammar definition](https://github.com/vietlubu/tree-sitter-hercscript) for the complete list.
