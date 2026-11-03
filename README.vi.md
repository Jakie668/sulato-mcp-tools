# Sulato Công cụ kinh doanh (máy chủ MCP)

Tiếng Việt | [English](README.md)

Sulato Công cụ kinh doanh là máy chủ MCP từ xa, miễn phí, dành cho doanh nghiệp Việt. Thêm một địa chỉ vào Claude, ChatGPT, Cursor, Claude Code hay VS Code là dùng được 7 công cụ: thuế GTGT, giá bán, khung báo giá, nội dung mã VietQR, hoa hồng giới thiệu và quy trình theo ngành nghề. Không cần đăng nhập, không lưu dữ liệu.

- Địa chỉ máy chủ (Streamable HTTP): `https://sulatobiz.com/mcp`
- Trang hướng dẫn: https://sulatobiz.com/ket-noi-ai
- Website: https://sulatobiz.com
- Tên hiển thị: "Sulato Công cụ kinh doanh" (tiếng Anh: "Sulato Business Tools")

## 7 công cụ

| Công cụ | Làm gì | Ví dụ câu hỏi |
| --- | --- | --- |
| `calculate_vat` | Cộng hoặc tách thuế GTGT 0, 5, 8, 10%. | "Giá 12.500.000 đ chưa VAT, tính VAT 8% và tổng thanh toán." |
| `calculate_selling_price` | Từ giá vốn ra giá bán theo biên lợi nhuận hoặc hệ số cộng thêm, làm tròn, kèm giá đã gồm VAT. | "Giá vốn 180.000 đ, muốn biên lợi nhuận 35%, làm tròn đến nghìn, cho cả giá gồm VAT 10%." |
| `build_quote` | Dựng khung báo giá có hạng mục, chiết khấu, VAT, đợt thanh toán và số tiền bằng chữ. | "Lập báo giá 3 hạng mục thiết kế, VAT 8%, thu 2 đợt 50/50." |
| `vietqr_payload` | Tạo nội dung mã VietQR chuyển khoản theo chuẩn NAPAS để bạn tạo mã QR; không lưu thông tin tài khoản. | "Tạo nội dung VietQR thu 5.000.000 đ, nội dung "Coc don 1024", tài khoản 0123456789 ngân hàng Vietcombank." |
| `simulate_referral_commission` | Mô phỏng hoa hồng giới thiệu tối đa 3 tầng, mặc định 20, 8 và 5%. | "Đơn 20.000.000 đ, hoa hồng giới thiệu 3 tầng theo mặc định, mỗi tầng nhận bao nhiêu?" |
| `industry_workflow` | Quy trình vận hành cho 23 nghề có trên website Sulato Business. | "Cho tôi quy trình vận hành của spa, từ lúc khách hỏi đến lúc khách quay lại." |
| `about_sulato_business` | Trả lời Sulato Business là gì và làm được gì cho doanh nghiệp của bạn. | "Sulato Business là gì, giúp được gì cho cửa hàng nhỏ?" |

Mọi công cụ tính ngay trên máy chủ rồi trả kết quả, không đọc hay ghi cơ sở dữ liệu.

## Thêm vào ứng dụng AI

### Claude (web và ứng dụng máy tính)

1. Mở **Customize > Connectors**.
2. Bấm **Add custom connector**.
3. Nhập địa chỉ `https://sulatobiz.com/mcp`. Nếu hộp thoại hỏi về xác thực, chọn **No sign-in**. Bấm **Add**.
4. Trong cuộc trò chuyện, mở **+ > Connectors**, bật connector rồi hỏi như bình thường.

Với gói Team và Enterprise, Owner thêm connector ở **Organization settings > Connectors**, sau đó các thành viên bật trong cuộc trò chuyện của mình.
Nguồn: [Add a connector that isn't in the directory](https://claude.com/docs/connectors/custom/add-unlisted).

### ChatGPT (web)

1. Vào [chatgpt.com/plugins](https://chatgpt.com/plugins).
2. Bấm nút dấu cộng, chọn **Add custom MCP server**.
3. Đặt tên "Sulato Business Tools", nhập địa chỉ máy chủ `https://sulatobiz.com/mcp`.
4. Ở phần xác thực, chọn **No authentication**. Đọc cảnh báo, chọn **I understand and want to continue**, rồi **Create as a plugin**.
5. Cài plugin. Trong cuộc trò chuyện mới, gõ `@` rồi chọn plugin.

Tài liệu hiện hành của OpenAI mô tả luồng này trên trang Plugins và không yêu cầu bật Developer mode. Việc có dùng được hay không phụ thuộc gói của bạn và chính sách của workspace.
Nguồn: [Add custom MCP server (OpenAI)](https://developers.openai.com/api/docs/guides/custom-mcp-server).

### Claude Code

```bash
claude mcp add --transport http sulato https://sulatobiz.com/mcp
```

### Cursor

Thêm vào `~/.cursor/mcp.json` (mọi dự án) hoặc `.cursor/mcp.json` (một dự án):

```json
{
  "mcpServers": {
    "sulato": {
      "url": "https://sulatobiz.com/mcp"
    }
  }
}
```

### VS Code

Thêm vào `.vscode/mcp.json`:

```json
{
  "servers": {
    "sulato": {
      "type": "http",
      "url": "https://sulatobiz.com/mcp"
    }
  }
}
```

Hoặc chạy lệnh **MCP: Add Server**, chọn **HTTP** rồi dán địa chỉ.

Các tệp mẫu sao chép được nằm trong thư mục [`examples/`](examples).

## Gọi trực tiếp (JSON-RPC qua HTTP)

```bash
# 1. initialize
curl -s https://sulatobiz.com/mcp \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"curl","version":"1.0"}}}'

# 2. liệt kê 7 công cụ
curl -s https://sulatobiz.com/mcp \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":2,"method":"tools/list"}'
```

Kịch bản đầy đủ, có thêm ví dụ `tools/call`, nằm ở [`examples/curl.sh`](examples/curl.sh). Lược đồ tham số của từng công cụ do `tools/list` trả về.

## Quyền riêng tư

- Công cụ tính trên máy chủ rồi trả kết quả, không gọi cơ sở dữ liệu.
- Không lưu dữ liệu bạn nhập, kể cả thông tin tài khoản ngân hàng khi tạo nội dung VietQR.
- Máy chủ không ghi nội dung yêu cầu vào log ứng dụng.
- Không cần tài khoản, không cần đăng nhập, dùng miễn phí.

Điều khoản và quyền riêng tư: https://sulatobiz.com/dieu-khoan

## Giới thiệu

Sulato Business là hệ điều hành kinh doanh cho doanh nghiệp Việt, từ người kinh doanh một mình đến doanh nghiệp nhiều bộ phận. Khách hàng, công việc, dòng tiền và trợ lý Sulato AI chạy chung một hệ thống: CRM, báo giá, hợp đồng, đơn hàng, bán tại quầy, kho, công nợ, thu tiền VietQR và hoa hồng đối tác.

Website: https://sulatobiz.com

## Liên hệ

Câu hỏi và báo lỗi: [mở một GitHub issue](https://github.com/Jakie668/sulato-mcp-tools/issues). Liên hệ kinh doanh: https://sulatobiz.com

## Giấy phép

Tài liệu và ví dụ trong kho này phát hành theo [giấy phép MIT](LICENSE). Dịch vụ chạy tại `https://sulatobiz.com/mcp` do Sulato Business vận hành theo [Điều khoản dịch vụ](https://sulatobiz.com/dieu-khoan).
