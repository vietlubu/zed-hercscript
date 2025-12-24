# ✅ GIẢI QUYẾT THÀNH CÔNG - select() Highlighting Issue

## Vấn đề ban đầu

**Báo cáo:** `select()` với dấu ngoặc KHÔNG được highlight, hiển thị màu trắng thay vì màu vàng cam như `select` không có dấu ngoặc.

```hercscript
select;           // ✅ Highlight vàng cam (hoạt động)
select();         // ❌ Màu trắng (KHÔNG hoạt động)
```

## Nguyên nhân gốc rễ

Grammar của tree-sitter-hercscript chỉ hỗ trợ built-in commands theo cú pháp Hercules truyền thống (KHÔNG có dấu ngoặc):

```javascript
builtin_command: $ => seq(
    field('name', choice('mes', 'select', 'getitem', ...)),
    optional(repeat1(choice($.string, $.number, ',')))
)
```

Khi viết `select()`:

- `select` được parse thành `builtin_command` ✓
- `()` sau nó trở thành **ERROR node** ✗
- ERROR nodes không thể được highlight bởi queries ✗

## Giải pháp đã áp dụng

### 1. Sửa Grammar để hỗ trợ cả 2 cú pháp

Cập nhật `builtin_command` rule để chấp nhận **HOẶC** simple arguments **HOẶC** parameter_list:

```javascript
builtin_command: $ => prec(2, seq(
    field('name', choice(
        'mes', 'select', 'getitem', ...
    )),
    choice(
        // Với dấu ngoặc (function-call style)
        $.parameter_list,
        // Không có dấu ngoặc (traditional Hercules style)
        optional(repeat1(choice($.string, $.number, ',')))
    )
))
```

### 2. Update Highlights Queries

Đã có patterns để highlight cả:

- `builtin_command` nodes → `@function.builtin`
- `function_call` nodes cho user-defined functions → `@function`

## Kết quả - ĐÃ HOẠT ĐỘNG! 🎉

### ✅ Built-in Commands - Cả 2 cú pháp đều được hỗ trợ

```hercscript
// Không có dấu ngoặc (traditional)
mes "Hello";              // ✅ builtin_command → vàng cam
select;                   // ✅ builtin_command → vàng cam
select "A", "B";          // ✅ builtin_command → vàng cam
getitem 501, 1;           // ✅ builtin_command → vàng cam

// Có dấu ngoặc (function-call style)
mes("Hello");             // ✅ builtin_command → vàng cam
select();                 // ✅ builtin_command → vàng cam
getitem(501, 1);          // ✅ builtin_command → vàng cam
warp("prontera", 150, 150); // ✅ builtin_command → vàng cam
```

### ✅ User-Defined Functions

```hercscript
// Trong expressions
.@result = myfunction();  // ✅ function_call → xanh dương
.@value = calculate(x, y); // ✅ function_call → xanh dương

// Với callfunc
callfunc("MyScript");     // ✅ builtin_command → vàng cam (callfunc là built-in)
```

### ⚠️ Giới hạn còn lại

User-defined functions như standalone statements vẫn chưa được hỗ trợ do conflict trong grammar:

```hercscript
myfunction();             // ❌ ERROR (không parse được)

// Workaround: dùng trong expression hoặc assignment
.@temp = myfunction();    // ✅ Hoạt động
```

## Parse Tree Verification

```
prontera,150,150,4	script	Test	100,{
    select();
    mes("Hello");
    getitem(501, 1);
}

→ Parse result:
  (builtin_command [select]
    (parameter_list))           ✅
  (builtin_command [mes]
    (parameter_list
      (string "Hello")))        ✅
  (builtin_command [getitem]
    (parameter_list
      (number 501)
      (number 1)))              ✅
```

## Files Changed

### Tree-sitter Grammar Repository

- **File:** `grammar.js`
- **Changes:** Modified `builtin_command` to accept `parameter_list`
- **Commits:**
  - `cadebed` - feat: allow built-in commands to use parentheses syntax
  - `337f1b8` - build: regenerate parser with parentheses support

### Zed Extension

- **File:** `extension.toml`
- **Changes:** Updated grammar commit to `337f1b82a2e13970168b75a3b0262aed1ca7ff15`
- **Commit:** `e86a3eb` - feat: update grammar to support built-in commands with parentheses

## Testing Instructions

### 1. Install/Update Extension

```bash
# Uninstall old version
Cmd+Shift+X → "Hercules Script" → Uninstall

# Install dev extension
Cmd+Shift+P → "zed: install dev extension"
→ Select: /Users/vietlubu/Projects/vietlubu/extensions/zed-hercscript

# Reload Zed
Cmd+Shift+P → "zed: reload window"
```

### 2. Test với file `.herc`

```hercscript
prontera,150,150,4	script	TestNPC	100,{
    // Tất cả các dòng sau đây nên có highlight đúng:

    // Built-in không có dấu ngoặc - vàng cam
    mes "Test 1";
    select "Option A", "Option B";
    getitem 501, 1;

    // Built-in CÓ dấu ngoặc - vàng cam (FIXED!)
    mes("Test 2");
    select();
    getitem(502, 2);
    warp("prontera", 150, 150);

    // User-defined trong expressions - xanh dương
    .@result = myCustomFunction();
    .@value = calculate(100, 50);

    end;
}
```

## Summary - Tổng kết

| Syntax                     | Status Trước         | Status Bây giờ   | Highlight Color |
| -------------------------- | -------------------- | ---------------- | --------------- |
| `select`                   | ✅ Works             | ✅ Works         | 🟧 Vàng cam     |
| `select()`                 | ❌ Error (màu trắng) | ✅ **FIXED!**    | 🟧 Vàng cam     |
| `mes "text"`               | ✅ Works             | ✅ Works         | 🟧 Vàng cam     |
| `mes("text")`              | ❌ Error             | ✅ **FIXED!**    | 🟧 Vàng cam     |
| `getitem 501,1`            | ✅ Works             | ✅ Works         | 🟧 Vàng cam     |
| `getitem(501,1)`           | ❌ Error             | ✅ **FIXED!**    | 🟧 Vàng cam     |
| `.@x = func()`             | ✅ Works             | ✅ Works         | 🟦 Xanh dương   |
| `myfunction()` (statement) | ❌ Error             | ❌ Not supported | ⚪ N/A          |

## Recommendation - Khuyến nghị

### ✅ Best Practice - Nên dùng

Hercules Script cho phép cả 2 cách, nhưng khuyến nghị:

```hercscript
// Built-in commands: Dùng traditional syntax (rõ ràng hơn)
mes "Welcome!";
select "Yes", "No";
getitem 501, 1;

// Nếu muốn dùng dấu ngoặc: BÂY GIỜ ĐÃ HOẠT ĐỘNG!
mes("Alternative syntax");
select();
getitem(501, 1);

// User-defined: Luôn dùng trong expressions
.@result = myfunction();
callfunc("ScriptName");
```

---

## Kết luận

✅ **VẤN ĐỀ ĐÃ ĐƯỢC GIẢI QUYẾT HOÀN TOÀN**

- `select()`, `mes()`, và tất cả built-in commands với dấu ngoặc giờ đây được parse và highlight chính xác
- Grammar được cập nhật để hỗ trợ cả 2 cú pháp Hercules
- Tất cả tests đều pass
- Extension đã sẵn sàng để sử dụng

**Date:** 2024-12-24
**Version:** 0.3.0
**Status:** ✅ RESOLVED - select() highlighting now works!
