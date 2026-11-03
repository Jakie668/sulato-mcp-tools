# Claude Code

Add the server (one line, user scope optional):

```bash
claude mcp add --transport http sulato https://sulatobiz.com/mcp
```

Share it with your team through the project `.mcp.json`:

```bash
claude mcp add --transport http --scope project sulato https://sulatobiz.com/mcp
```

Check it:

```bash
claude mcp list
```

Then ask, for example: "Price is 12,500,000 VND before VAT. Add 8% VAT and give me the total."

---

# Claude Code (tiếng Việt)

Thêm máy chủ bằng một dòng lệnh:

```bash
claude mcp add --transport http sulato https://sulatobiz.com/mcp
```

Chia sẻ cho cả nhóm qua `.mcp.json` của dự án:

```bash
claude mcp add --transport http --scope project sulato https://sulatobiz.com/mcp
```

Kiểm tra:

```bash
claude mcp list
```

Sau đó hỏi, ví dụ: "Giá 12.500.000 đ chưa VAT, tính VAT 8% và tổng thanh toán."
