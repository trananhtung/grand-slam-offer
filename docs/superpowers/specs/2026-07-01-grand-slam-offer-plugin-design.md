# Thiết kế: Plugin Claude Code "Grand Slam Offer"

**Ngày:** 2026-07-01
**Trạng thái:** Đã duyệt thiết kế, chờ viết plan
**Nguồn tham chiếu:** Alex Hormozi — *$100M Offers* (bản dịch tiếng Việt "Đề Xuất 100 Triệu Đô")

## Mục tiêu

Xây dựng một **plugin Claude Code** giúp người dùng tạo ra một **Grand Slam Offer** hoàn chỉnh bằng cách dẫn dắt họ qua đúng các bước trình bày trong cuốn sách. Plugin sẽ được đẩy lên GitHub với hướng dẫn sử dụng chi tiết bằng tiếng Việt.

## Quyết định đã chốt

| Hạng mục | Quyết định |
|----------|-----------|
| Nền tảng | Plugin Claude Code chuẩn (`.claude-plugin/plugin.json`) |
| Ngôn ngữ nội dung | Tiếng Việt (giữ thuật ngữ gốc: "Grand Slam Offer", "Value Equation", "MAGIC"…) |
| Kiến trúc tương tác | Một skill hội thoại duy nhất dẫn dắt trọn luồng + một slash command mỏng để khởi động |
| Đầu ra | Một file markdown `my-offer.md` được build dần qua từng bước |
| Tên lệnh | `/grand-slam-offer` |
| Ví dụ minh họa | Ngành Print-on-demand / Temu |
| Bản quyền | Không chép nguyên văn sách; chỉ mã hóa khung/ý tưởng bằng lời tự viết, có ghi nguồn |

## Nguyên tắc thiết kế

- **Không tách agent riêng, không nhiều slash command**: theo lựa chọn "một skill hội thoại". Toàn bộ trí tuệ nằm trong một skill; slash command chỉ là điểm vào mỏng.
- **Progressive disclosure**: `SKILL.md` giữ vai trò "nhạc trưởng" (ngắn gọn: thứ tự bước, quy tắc ghi file). Chi tiết từng bước nằm trong `references/` và chỉ được đọc khi tới bước đó.
- **Tự chứa kiến thức**: người dùng plugin KHÔNG có cuốn sách. Các file reference phải chứa đủ phương pháp luận (viết lại bằng lời tôi) để dẫn dắt một người chưa đọc sách.
- **An toàn bản quyền**: mã hóa *khung/quy trình/ý tưởng* (không được bảo hộ), không sao chép câu chữ của tác giả. Ghi nguồn rõ ràng.

## Cấu trúc repo

```
grand-slam-offer/                        # = plugin root
├── .claude-plugin/
│   ├── plugin.json                      # manifest plugin
│   └── marketplace.json                 # cho phép cài trực tiếp từ GitHub repo này
├── commands/
│   └── grand-slam-offer.md              # slash command mỏng: khởi động skill
├── skills/
│   └── grand-slam-offer/
│       ├── SKILL.md                     # nhạc trưởng: thứ tự bước + quy tắc ghi file
│       ├── references/
│       │   ├── 00-tong-quan.md          # tổng quan khung + Value Equation + ví dụ POD xuyên suốt
│       │   ├── 01-thi-truong.md         # Thị trường đói khát (starving crowd)
│       │   ├── 02-dinh-gia.md           # Tính phí xứng đáng (charge what it's worth)
│       │   ├── 03-value-equation.md     # Phương trình Giá trị
│       │   ├── 04-van-de-giai-phap.md   # Vấn đề & Giải pháp
│       │   ├── 05-trim-stack.md         # Cắt bỏ & Chắt lọc (Trim & Stack)
│       │   ├── 06-nang-cao.md           # Khan hiếm, Cấp bách, Phần thưởng, Bảo đảm
│       │   ├── 07-dat-ten.md            # Đặt tên (MAGIC)
│       │   └── 08-cham-diem.md          # Rubric chấm điểm + checklist hoàn thiện
│       └── assets/
│           └── mau-offer.md             # template hồ sơ offer (copy ra workspace)
├── README.md                            # hướng dẫn dùng chi tiết (tiếng Việt)
├── LICENSE                              # MIT (cho code plugin)
└── .gitignore
```

## Luồng người dùng (runtime)

1. Cài plugin qua marketplace GitHub, gõ `/grand-slam-offer` — hoặc chỉ cần nói "giúp tôi tạo một offer" thì skill tự kích hoạt (nhờ `description`).
2. Skill hỏi tên/đường dẫn file offer (mặc định `my-offer.md`), tạo từ `assets/mau-offer.md` nếu chưa có; nếu đã có thì đọc để tiếp tục.
3. Dẫn qua **8 bước tuần tự**. Mỗi bước:
   - Đọc `references/NN-*.md` tương ứng.
   - Giải thích ngắn gọn "bước này là gì, vì sao quan trọng".
   - Hỏi 1–3 câu để thu thập đầu vào từ người dùng.
   - Chốt nội dung, **ghi vào đúng mục trong `my-offer.md`**.
   - Xác nhận với người dùng rồi mới sang bước sau (cho phép nhảy lùi/sửa).
4. Bước 8: chấm điểm offer theo Value Equation (4 biến, thang 1–10) + checklist các yếu tố nâng cao, đưa gợi ý cải thiện cụ thể.
5. Kết quả: bản Grand Slam Offer hoàn chỉnh trong `my-offer.md`.

## Nội dung 8 bước (đặc tả nội dung reference)

Mỗi file reference gồm: (a) mục tiêu bước, (b) giải thích phương pháp bằng lời tôi, (c) danh sách câu hỏi để hỏi người dùng, (d) khung/công thức, (e) mini ví dụ POD/Temu, (f) mẫu đoạn ghi vào `my-offer.md`.

1. **`01-thi-truong.md` — Thị trường đói khát**: 4 tiêu chí chọn thị trường (đau đớn dữ dội, sức mua, dễ tiếp cận/định vị, đang tăng trưởng). Câu hỏi sàng lọc thị trường ngách. Cảnh báo bẫy "thị trường tồi".
2. **`02-dinh-gia.md` — Tính phí xứng đáng**: bẫy hàng hóa đại trà (commodity) → phân hóa; tâm lý giá cao ↔ giá trị cảm nhận; định giá cao cấp có chủ đích thay vì đua giá rẻ.
3. **`03-value-equation.md` — Phương trình Giá trị**: công thức `(Kết quả mơ ước × Khả năng đạt được cảm nhận) / (Độ trễ thời gian × Công sức & Hy sinh)`. Hướng dẫn tăng tử số, giảm mẫu số. Cho người dùng tự chấm 4 biến 1–10 để biết đòn bẩy nào cần cải thiện.
4. **`04-van-de-giai-phap.md` — Vấn đề & Giải pháp**: liệt kê MỌI trở ngại/nỗi sợ/rào cản khách gặp trên hành trình đạt kết quả mơ ước → đảo mỗi vấn đề thành một giải pháp (đặt tên giải pháp hấp dẫn).
5. **`05-trim-stack.md` — Cắt bỏ & Chắt lọc**: từ danh sách giải pháp, đánh giá theo (giá trị cho khách) × (chi phí cung cấp cho ta); giữ thứ giá trị-cao/chi-phí-thấp, cắt thứ giá trị-thấp/chi-phí-cao; xếp chồng (stack) thành gói, ước tính "tổng giá trị ngăn xếp" để neo giá.
6. **`06-nang-cao.md` — Nâng cao offer**: 
   - Khan hiếm (số lượng có hạn) — các dạng.
   - Cấp bách (thời hạn) — các dạng.
   - Phần thưởng thêm (bonus stack) — nguyên tắc trình bày bonus.
   - Cam kết bảo đảm — 4 loại (vô điều kiện, có điều kiện, chống-bảo-đảm, ngụ ý) và cách chọn.
7. **`07-dat-ten.md` — Đặt tên (MAGIC)**: công thức đặt tên offer theo 5 thành phần MAGIC (Magnet reason/Announce avatar/Give goal/Indicate time/Container word). Sinh vài phương án tên.
8. **`08-cham-diem.md` — Chấm điểm**: rubric chấm Value Equation + checklist (có đủ khan hiếm? cấp bách? bonus? bảo đảm? tên hấp dẫn?), điểm tổng và 3 gợi ý cải thiện ưu tiên cao.

## Template `my-offer.md`

Các mục tương ứng 8 bước, để trống chờ điền:
`# Grand Slam Offer của tôi` → Thị trường, Định giá, Value Equation (4 biến + điểm), Danh sách Vấn đề→Giải pháp, Bảng Trim & Stack, Khan hiếm/Cấp bách/Bonus/Bảo đảm, Tên offer, Điểm & việc cần cải thiện.

## `plugin.json` (phác thảo)

```json
{
  "name": "grand-slam-offer",
  "description": "Tạo Grand Slam Offer theo phương pháp $100M Offers của Alex Hormozi",
  "version": "0.1.0",
  "author": { "name": "trananhtung" }
}
```

## `marketplace.json` (phác thảo)

Cho phép: `/plugin marketplace add trananhtung/grand-slam-offer` rồi `/plugin install grand-slam-offer@grand-slam-offer`. Trỏ `source` tới plugin ở gốc repo (`./`).

*(Schema chính xác của plugin.json/marketplace.json sẽ được xác minh với tài liệu Claude Code trong bước implementation.)*

## README (hướng dẫn dùng chi tiết)

Gồm: giới thiệu ngắn về Grand Slam Offer; cách cài (marketplace add + install); cách chạy (`/grand-slam-offer`); mô tả 8 bước; một ví dụ chạy thật rút gọn (ngành POD/Temu); ảnh/đoạn hội thoại minh họa; mục "Nguồn & bản quyền" ghi rõ dựa trên sách của Hormozi và không sao chép nguyên văn; giấy phép.

## Ngoài phạm vi (YAGNI)

- Không có agent chấm điểm tách riêng (gộp vào bước 8 của skill).
- Không có nhiều slash command cho từng bước (chỉ 1 điểm vào).
- Không tích hợp MCP/hook.
- Không đa ngôn ngữ (chỉ tiếng Việt).

## Tiêu chí hoàn thành

- Cài được plugin từ repo GitHub và chạy `/grand-slam-offer` không lỗi.
- Skill dẫn hết 8 bước, tạo/ghi được `my-offer.md`.
- Nội dung reference đủ để một người chưa đọc sách vẫn làm được offer.
- README đủ để người lạ tự cài và dùng.
- Không có đoạn sao chép nguyên văn từ sách; có ghi nguồn.
