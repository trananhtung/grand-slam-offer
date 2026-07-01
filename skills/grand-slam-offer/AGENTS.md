# AGENTS.md

`grand-slam-offer` là một Skill (chạy được trên **Codex** và **Claude Code**) giúp tạo một
**Grand Slam Offer** theo phương pháp *$100M Offers* của Alex Hormozi.

## Cách hoạt động

- Toàn bộ logic điều phối nằm ở **`SKILL.md`** — hãy đọc và làm theo nó.
- Kiến thức chi tiết từng bước ở **`references/00-08*.md`** (đọc dần theo bước, đừng đọc hết một lúc).
- Template hồ sơ offer ở **`assets/mau-offer.md`**; kết quả ghi vào `my-offer.md` ở thư mục làm việc.

## Hai chế độ

- **Hỏi–đáp (interactive):** dẫn từng bước, hỏi người dùng ở mỗi bước.
- **Tự động (auto):** hỏi 1 câu gom thông tin rồi tự chạy trọn 8 bước, tự đặt giả định (đánh dấu `> Giả định:`), tự chấm điểm.

Trên Codex, người dùng có thể gọi bằng slash command `/grand-slam-offer` hoặc `/grand-slam-offer-auto`
(cài từ `codex/prompts/`), hoặc chỉ cần nói "giúp tôi tạo một offer theo kiểu Hormozi".

## Ngôn ngữ
Nội dung bằng tiếng Việt; giữ nguyên thuật ngữ gốc (Grand Slam Offer, Value Equation, Trim & Stack, MAGIC).
