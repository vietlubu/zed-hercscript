# 🚀 QUICK FIX - Cập nhật Extension ngay lập tức

## Vấn đề: `switch(select("..."))` - select vẫn màu trắng

File `highlights.scm` đã được fix nhưng Zed cần reinstall để load grammar mới.

## ✅ Giải pháp - 3 bước đơn giản:

### Bước 1: Uninstall extension cũ
1. Mở Zed
2. Nhấn `Cmd+Shift+X` (hoặc click Extensions icon)
3. Tìm "**Hercules Script**"
4. Click "**Uninstall**"

### Bước 2: Install dev extension mới
1. Nhấn `Cmd+Shift+P` (Command Palette)
2. Gõ: `zed: install dev extension`
3. Chọn folder:
   ```
   /Users/vietlubu/Projects/vietlubu/extensions/zed-hercscript
   ```
4. Nhấn Enter

### Bước 3: Reload window
1. Nhấn `Cmd+Shift+P` lần nữa
2. Gõ: `zed: reload window`
3. Nhấn Enter

---

## 🧪 Test ngay

Tạo file test `.herc`:

```hercscript
prontera,150,150,4	script	Test	100,{
    // Tất cả select đều phải VÀNG CAM:

    select();                                      // ✅
    switch(select("I'd rather not:What's up?")) {  // ✅ FIXED!
        case 1:
            mes("Option 1");
            break;
        case 2:
            mes("Option 2");
            break;
    }

    .@x = select("Yes:No");                       // ✅
    if (select("Continue:Stop") == 1) { }         // ✅

    end;
}
```

### Kết quả mong đợi:
- ✅ `select` trong `select()` → **VÀNG CAM**
- ✅ `select` trong `switch(select(...))` → **VÀNG CAM**
- ✅ `select` trong `.@x = select(...)` → **VÀNG CAM**
- ✅ `select` trong `if (select(...))` → **VÀNG CAM**
- ✅ `mes` trong `mes("...")` → **VÀNG CAM**

---

## 🔧 Nếu vẫn chưa được

### Option 1: Dùng script tự động
```bash
cd /Users/vietlubu/Projects/vietlubu/extensions/zed-hercscript
./force-reinstall.sh
```

Sau đó làm theo hướng dẫn trên màn hình.

### Option 2: Restart hoàn toàn Zed
1. **Quit Zed** hoàn toàn (Cmd+Q)
2. Mở lại Zed
3. Lặp lại 3 bước ở trên

### Option 3: Clear cache thủ công
```bash
# Xóa cache Zed
rm -rf ~/Library/Caches/Zed/languages

# Xóa extension cũ
rm -rf ~/Library/Application\ Support/Zed/extensions/hercscript
rm -rf ~/Library/Application\ Support/Zed/extensions/installed/hercscript

# Sau đó install lại dev extension (Bước 2 ở trên)
```

---

## 📊 So sánh Trước/Sau

| Code | Trước | Sau Fix |
|------|-------|---------|
| `select()` | 🟧 Vàng cam | 🟧 Vàng cam |
| `switch(select())` | ⚪ **Trắng** ❌ | 🟧 **Vàng cam** ✅ |
| `.@x = select()` | ⚪ **Trắng** ❌ | 🟧 **Vàng cam** ✅ |
| `if (select())` | ⚪ **Trắng** ❌ | 🟧 **Vàng cam** ✅ |

---

## ❓ Tại sao phải reinstall?

Vấn đề là file `grammars/highlights.scm` có pattern:
```scheme
(identifier) @variable  # Pattern này override mọi thứ khác!
```

Pattern này capture TẤT CẢ identifiers và override các patterns cụ thể hơn như `@function.builtin`.

**Fix đã áp dụng:** Xóa pattern tổng quát này. Bây giờ built-in functions được highlight đúng trong MỌI context.

---

## 📝 Changelog

**Commit:** `25af1b6` - 2024-12-24
- ✅ Xóa pattern `(identifier) @variable`
- ✅ Sync file `highlights.scm` đúng
- ✅ `select()` bây giờ highlight đúng trong expressions

**Grammar version:** `a0e884d11ecaefb036e117db18569d2c4bc93ddf`

---

## 🎯 Kết luận

Sau khi reinstall, **TẤT CẢ** built-in commands (`select`, `mes`, `getitem`, v.v.) sẽ được highlight VÀNG CAM trong MỌI context:
- ✅ Statements: `select();`
- ✅ Switch: `switch(select())`
- ✅ Assignments: `.@x = select()`
- ✅ Conditions: `if (select())`
- ✅ Expressions: `func(select())`

**BẮT ĐẦU TỪ BƯỚC 1 NGAY BÂY GIỜ!** ⬆️
