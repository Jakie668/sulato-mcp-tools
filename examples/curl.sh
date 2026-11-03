#!/usr/bin/env bash
# Gọi máy chủ MCP Sulato Công cụ kinh doanh bằng JSON-RPC qua HTTP (Streamable HTTP).
# Call the Sulato Business Tools MCP server with JSON-RPC over HTTP (Streamable HTTP).
#
# Usage: bash curl.sh
# Phản hồi có thể ở dạng JSON hoặc luồng sự kiện (SSE) tùy tiêu đề Accept.
set -euo pipefail

URL="https://sulatobiz.com/mcp"
H_CT="Content-Type: application/json"
H_AC="Accept: application/json, text/event-stream"

echo "== 1. initialize"
curl -sS "$URL" -H "$H_CT" -H "$H_AC" -d '{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "initialize",
  "params": {
    "protocolVersion": "2025-06-18",
    "capabilities": {},
    "clientInfo": { "name": "curl", "version": "1.0" }
  }
}'
echo

echo "== 2. notifications/initialized"
curl -sS "$URL" -H "$H_CT" -H "$H_AC" -d '{"jsonrpc":"2.0","method":"notifications/initialized"}' || true
echo

echo "== 3. tools/list (7 tools, kèm inputSchema)"
curl -sS "$URL" -H "$H_CT" -H "$H_AC" -d '{"jsonrpc":"2.0","id":2,"method":"tools/list"}'
echo

echo "== 4. tools/call calculate_vat"
# Tên tham số dưới đây theo inputSchema do tools/list ở bước 3 trả về.
# Argument names follow the inputSchema returned by tools/list in step 3.
# Ví dụ: giá 12.500.000 đ chưa VAT, cộng VAT 8%.
curl -sS "$URL" -H "$H_CT" -H "$H_AC" -d '{
  "jsonrpc": "2.0",
  "id": 3,
  "method": "tools/call",
  "params": {
    "name": "calculate_vat",
    "arguments": { "amount": 12500000, "vat_rate": 8, "direction": "add" }
  }
}'
echo
