# Sulato Business Tools (MCP server)

[Tiếng Việt](README.vi.md) | English

Sulato Business Tools is a free remote MCP server for Vietnamese businesses. It gives Claude, ChatGPT, Cursor, Claude Code and VS Code seven calculation tools: VAT, selling price, quotation, VietQR transfer content, referral commission and industry workflows. No sign-in, no stored data.

- Server address (Streamable HTTP): `https://sulatobiz.com/mcp`
- Setup guide: https://sulatobiz.com/ket-noi-ai
- Website: https://sulatobiz.com
- Display name: "Sulato Công cụ kinh doanh" (English: "Sulato Business Tools")

## Tools

| Tool | What it does | Example prompt |
| --- | --- | --- |
| `calculate_vat` | Adds or extracts VAT at 0, 5, 8 or 10%. | "Price is 12,500,000 VND before VAT. Add 8% VAT and give me the total." |
| `calculate_selling_price` | Turns a cost price into a selling price by margin or markup, with rounding and a VAT-inclusive price. | "Cost is 180,000 VND, I want a 35% margin, round to the nearest thousand, and show the price with 10% VAT." |
| `build_quote` | Builds a quotation frame: line items, discount, VAT, payment installments and the total written out in Vietnamese words. | "Draft a quote with 3 design items, 8% VAT, paid in 2 installments of 50/50." |
| `vietqr_payload` | Produces the VietQR (NAPAS standard) transfer content so you can generate the QR code. Bank account details are not stored. | "Create VietQR content for 5,000,000 VND, note 'Coc don 1024', account 0123456789 at Vietcombank." |
| `simulate_referral_commission` | Simulates referral commission across up to 3 levels, default 20%, 8% and 5%. | "On a 20,000,000 VND order, how much does each of the 3 levels earn with the default rates?" |
| `industry_workflow` | Operating workflow for 23 trades listed on the Sulato Business website. | "Give me the operating workflow of a spa, from the first inquiry to the customer coming back." |
| `about_sulato_business` | Answers what Sulato Business is and what it does for a business. | "What is Sulato Business and how can it help a small shop?" |

All tools compute on the server and return the result. They do not write to or read from any database.

## Add it to your AI app

### Claude (web and desktop)

1. Open **Customize > Connectors**.
2. Click **Add custom connector**.
3. Enter the URL `https://sulatobiz.com/mcp`. If the dialog asks for authentication, choose **No sign-in**. Click **Add**.
4. In a chat, open **+ > Connectors**, turn the connector on, then ask as usual.

On Team and Enterprise plans an Owner adds the connector from **Organization settings > Connectors**, then members turn it on in their chats.
Source: [Add a connector that isn't in the directory](https://claude.com/docs/connectors/custom/add-unlisted).

### ChatGPT (web)

1. Go to [chatgpt.com/plugins](https://chatgpt.com/plugins).
2. Click the plus button, then **Add custom MCP server**.
3. Enter the name "Sulato Business Tools" and the server URL `https://sulatobiz.com/mcp`.
4. Under authentication, choose **No authentication**. Read the warning, choose **I understand and want to continue**, then **Create as a plugin**.
5. Install the plugin. In a new chat, type `@` and pick the plugin.

OpenAI's current documentation describes this flow on the Plugins page and does not require Developer mode. Availability depends on your plan and your workspace policy.
Source: [Add custom MCP server (OpenAI)](https://developers.openai.com/api/docs/guides/custom-mcp-server).

### Claude Code

```bash
claude mcp add --transport http sulato https://sulatobiz.com/mcp
```

### Cursor

Add to `~/.cursor/mcp.json` (all projects) or `.cursor/mcp.json` (one project):

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

Add to `.vscode/mcp.json`:

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

Or run the command **MCP: Add Server**, choose **HTTP**, and paste the URL.

More ready-to-copy files are in [`examples/`](examples).

## Call it directly (JSON-RPC over HTTP)

```bash
# 1. initialize
curl -s https://sulatobiz.com/mcp \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"curl","version":"1.0"}}}'

# 2. list the 7 tools
curl -s https://sulatobiz.com/mcp \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":2,"method":"tools/list"}'
```

The full script, including a `tools/call` example, is [`examples/curl.sh`](examples/curl.sh). The input schema of every tool is returned by `tools/list`.

## Privacy

- Tools compute on the server and return the result. They do not call a database.
- No data you type is stored, including bank account details used for VietQR content.
- The server does not write request content to application logs.
- No account, no sign-in, free to use.

Privacy policy: https://sulatobiz.com/chinh-sach-rieng-tu · Terms of service: https://sulatobiz.com/dieu-khoan

## About

Sulato Business là hệ điều hành kinh doanh cho doanh nghiệp Việt, từ người kinh doanh một mình đến doanh nghiệp nhiều bộ phận. Khách hàng, công việc, dòng tiền và trợ lý Sulato AI chạy chung một hệ thống: CRM, báo giá, hợp đồng, đơn hàng, bán tại quầy, kho, công nợ, thu tiền VietQR và hoa hồng đối tác.

(English: Sulato Business is a business operating system for Vietnamese companies, from solo operators to multi-department businesses. Customers, work, cash flow and the Sulato AI assistant run on one system: CRM, quotations, contracts, orders, point of sale, inventory, receivables, VietQR collection and partner commission.)

Website: https://sulatobiz.com

## Contact

Questions and bug reports: [open a GitHub issue](https://github.com/Jakie668/sulato-mcp-tools/issues). Business enquiries: https://sulatobiz.com

## License

The documentation and examples in this repository are released under the [MIT License](LICENSE). The hosted service at `https://sulatobiz.com/mcp` is operated by Sulato Business under its [terms of service](https://sulatobiz.com/dieu-khoan).
