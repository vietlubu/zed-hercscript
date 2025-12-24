# Syntax Highlighting Update - Final Status

## Vấn đề đã được giải quyết

### ✅ Highlight cho User-Defined Functions

**Trước đây:**
- Chỉ có built-in commands (không có dấu ngoặc) được highlight
- User-defined functions với dấu ngoặc `myfunction()` KHÔNG được highlight

**Bây giờ:**
- ✅ User-defined functions được highlight như `@function` (màu xanh dương/cyan)
- ✅ Built-in commands vẫn được highlight như `@function.builtin` (màu vàng cam)

## Cách hoạt động

### 1. Built-in Commands (Traditional Hercules Syntax)
```hercscript
mes "Hello";           // ✅ Highlight vàng cam (built-in)
select;                // ✅ Highlight vàng cam (built-in)
getitem 501, 1;        // ✅ Highlight vàng cam (built-in)
warp "prontera", 150, 150;  // ✅ Highlight vàng cam (built-in)
```

### 2. User-Defined Functions (With Parentheses)
```hercscript
myfunction();          // ✅ Highlight xanh dương (user-defined)
calculateDamage();     // ✅ Highlight xanh dương (user-defined)
callfunc("Script");    // ✅ Highlight xanh dương (user-defined)
```

### 3. Control Flow Keywords
```hercscript
if (.@x > 0) { }       // ✅ Highlight tím (keyword)
while (.@i < 10) { }   // ✅ Highlight tím (keyword)
switch (.@opt) { }     // ✅ Highlight tím (keyword)
for (.@i = 0; .@i < 10; .@i++) { }  // ✅ Highlight tím (keyword)
```

## Giới hạn hiện tại

### ⚠️ Built-in Commands với Dấu Ngoặc (Limited Support)

Do cách grammar được thiết kế để match với cú pháp Hercules chính thống:

```hercscript
mes();                 // ❌ KHÔNG parse được (ERROR)
select();              // ❌ KHÔNG parse được (ERROR)
getitem();             // ❌ KHÔNG parse được (ERROR)
```

**Lý do:** Grammar của Hercules Script được thiết kế để built-in commands dùng **KHÔNG có dấu ngoặc**. Đây là cú pháp chính thống của Hercules.

## Best Practices - Khuyến nghị sử dụng

### ✅ ĐÚNG - Nên dùng

```hercscript
prontera,150,150,4	script	MyNPC	100,{
    // Built-in commands: KHÔNG dấu ngoặc
    mes "Welcome!";
    select "Option 1", "Option 2";
    getitem 501, 1;

    // User-defined functions: CÓ dấu ngoặc
    .@result = myCustomFunction();
    processQuestReward();
    callfunc("AnotherScript");

    // Control flow
    if (.@result) {
        mes "Success!";
    }

    end;
}
```

### ❌ TRÁNH - Không nên dùng

```hercscript
// KHÔNG dùng dấu ngoặc cho built-in commands
mes();                 // ❌ Sẽ lỗi parse
select();              // ❌ Sẽ lỗi parse
getitem(501, 1);       // ❌ Sẽ lỗi parse
```

## Technical Details - Chi tiết kỹ thuật

### Highlights Query Pattern Order

File `highlights.scm` sử dụng pattern matching theo thứ tự:

1. **Fallback pattern** (áp dụng cho TẤT CẢ function calls):
   ```scheme
   (function_call (identifier) @function)
   ```

2. **Built-in specific patterns** (override cho built-ins):
   ```scheme
   (function_call
     (identifier) @function.builtin
     (#match? @function.builtin "^(mes|select|getitem|...)$"))
   ```

3. **Kết quả:**
   - Built-in functions → match cả 2 patterns, nhưng `@function.builtin` được ưu tiên
   - User-defined functions → chỉ match pattern 1, được highlight như `@function`

## Files Updated

### Tree-sitter Grammar Repository
- `queries/highlights.scm` - Added user-defined function pattern
- Commit: `89a272e25e75bed7388b616afd78736ad24b4a13`

### Zed Extension
- `extension.toml` - Updated grammar commit reference
- `grammars/highlights.scm` - Synced with tree-sitter repository
- `SYNTAX_HIGHLIGHTING.md` - Complete documentation
- `test-highlight.herc` - Demo/test file
- Commits: `055b346`, `baedd52`

## Testing

Để test highlighting, sử dụng file `test-highlight.herc` trong extension directory:

```bash
# Open in Zed
zed extensions/zed-hercscript/test-highlight.herc
```

Hoặc tạo file test của riêng bạn với extension `.herc`

## Màu sắc theo Theme

Màu sắc cụ thể phụ thuộc vào theme của Zed, nhưng thường:

| Element | Capture | Màu thường thấy |
|---------|---------|----------------|
| Built-in functions | `@function.builtin` | Vàng cam (Orange/Yellow) |
| User functions | `@function` | Xanh dương (Blue/Cyan) |
| Keywords | `@keyword` | Tím (Purple/Magenta) |
| Strings | `@string` | Xanh lá (Green) |
| Numbers | `@number` | Xanh nhạt (Light Blue) |
| Comments | `@comment` | Xám (Gray) |

## Kết luận

✅ **Hoàn thành:**
- User-defined functions bây giờ được highlight đúng cách
- Built-in commands vẫn giữ highlight riêng biệt
- Documentation đầy đủ về cách sử dụng

⚠️ **Lưu ý:**
- Tuân thủ cú pháp Hercules chính thống: built-ins không có dấu ngoặc
- User-defined functions nên dùng có dấu ngoặc để dễ phân biệt

📚 **Tài liệu tham khảo:**
- `SYNTAX_HIGHLIGHTING.md` - Hướng dẫn chi tiết
- `test-highlight.herc` - File demo/test
- [Tree-sitter Grammar](https://github.com/vietlubu/tree-sitter-hercscript)
- [Zed Extension](https://github.com/vietlubu/zed-hercscript)

## Next Steps - Cài đặt/Update

1. **Uninstall extension cũ** (nếu có):
   - Mở Zed → `Cmd+Shift+X`
   - Tìm "Hercules Script" → Uninstall

2. **Install dev extension mới:**
   - `Cmd+Shift+P` → `zed: install dev extension`
   - Chọn: `/Users/vietlubu/Projects/vietlubu/extensions/zed-hercscript`

3. **Reload Zed:**
   - `Cmd+Shift+P` → `zed: reload window`

4. **Test:**
   - Mở file `.herc` bất kỳ
   - Kiểm tra highlighting cho cả built-in và user-defined functions

---

**Date:** 2024-12-24
**Version:** 0.3.0
**Status:** ✅ Complete
