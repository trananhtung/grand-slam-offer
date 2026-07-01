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
| Kiến trúc tương tác | Một skill "bộ não" duy nhất (chung bộ references) chạy được **2 chế độ**, mở qua 2 slash command mỏng |
| Đầu ra | Một file markdown `my-offer.md` được build dần qua từng bước |
| Hai chế độ | **Hỏi–đáp** (`/grand-slam-offer`): dẫn từng bước, hỏi người dùng. **Tự động** (`/grand-slam-offer-auto`): hỏi 1 câu gom thông tin rồi AI tự làm trọn 8 bước, ghi rõ giả định |
| Tên lệnh | `/grand-slam-offer` và `/grand-slam-offer-auto` |
| Ví dụ minh họa | Ngành Print-on-demand / Temu |
| Bản quyền | Không chép nguyên văn sách; chỉ mã hóa khung/ý tưởng bằng lời tự viết, có ghi nguồn |

## Nguyên tắc thiết kế

- **Một "bộ não", hai chế độ chạy**: toàn bộ trí tuệ/phương pháp nằm trong MỘT skill (chung bộ `references/`). Hai slash command chỉ là điểm vào mỏng, mỗi lệnh nói cho skill biết chạy chế độ nào (hỏi–đáp hay tự động). Không tách agent riêng, không có 8 lệnh cho 8 bước.
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
│   ├── grand-slam-offer.md              # chế độ HỎI–ĐÁP: khởi động skill, mode=interactive
│   └── grand-slam-offer-auto.md         # chế độ TỰ ĐỘNG: khởi động skill, mode=auto
├── skills/
│   └── grand-slam-offer/
│       ├── SKILL.md                     # nhạc trưởng: 2 chế độ + thứ tự bước + quy tắc ghi file
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

Cả hai chế độ dùng chung 8 bước và cùng ghi vào `my-offer.md` (tạo từ `assets/mau-offer.md` nếu chưa có; nếu đã có thì đọc để tiếp tục).

### Chế độ HỎI–ĐÁP — `/grand-slam-offer`

1. Gõ `/grand-slam-offer` (hoặc chỉ cần nói "giúp tôi tạo một offer" → skill tự kích hoạt nhờ `description`).
2. Skill hỏi tên/đường dẫn file offer (mặc định `my-offer.md`), tạo file từ template.
3. Dẫn qua **8 bước tuần tự**. Mỗi bước:
   - Đọc `references/NN-*.md` tương ứng.
   - Giải thích ngắn gọn "bước này là gì, vì sao quan trọng".
   - Hỏi 1–3 câu để thu thập đầu vào từ người dùng.
   - Chốt nội dung, **ghi vào đúng mục trong `my-offer.md`**.
   - Xác nhận với người dùng rồi mới sang bước sau (cho phép nhảy lùi/sửa).
4. Bước 8: chấm điểm offer theo Value Equation + checklist, đưa gợi ý cải thiện cụ thể.

### Chế độ TỰ ĐỘNG — `/grand-slam-offer-auto`

1. Gõ `/grand-slam-offer-auto`.
2. Skill hỏi **đúng 1 câu gom thông tin**: mô tả sản phẩm/dịch vụ, khách hàng mục tiêu, mức giá hiện tại, và mục tiêu (càng chi tiết càng tốt; thiếu cũng không sao).
3. Sau đó AI **tự chạy trọn 8 bước không hỏi thêm**:
   - Với mỗi bước, đọc reference, tự suy luận & điền nội dung.
   - Khi thiếu dữ liệu, tự đặt **giả định hợp lý** và **đánh dấu rõ** (ví dụ mục "> Giả định:" trong file) để người dùng dễ chỉnh.
   - Nơi có nhiều lựa chọn (tên offer, bonus…), AI tự sinh nhiều phương án rồi chọn phương án tốt nhất, giữ phần còn lại làm gợi ý.
   - Ghi toàn bộ vào `my-offer.md`.
4. Cuối cùng AI **tự chấm điểm** (bước 8), in bản tóm tắt offer + danh sách giả định đã đặt, rồi mời người dùng tinh chỉnh bất kỳ mục nào (không phải ngõ cụt).

### Cơ chế chọn chế độ (kỹ thuật)

Mỗi command truyền một tín hiệu chế độ cho skill (ví dụ command tự động ghi rõ: "Chạy skill grand-slam-offer ở CHẾ ĐỘ TỰ ĐỘNG"). `SKILL.md` có một mục "Hai chế độ" mô tả khác biệt hành vi; phần 8 bước dùng chung, chỉ khác ở chỗ *ai* cung cấp câu trả lời mỗi bước (người dùng vs AI tự suy luận) và mức độ dừng lại xác nhận.

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

Gồm: giới thiệu ngắn về Grand Slam Offer; cách cài (marketplace add + install); **cách chạy cả 2 chế độ** (`/grand-slam-offer` hỏi–đáp và `/grand-slam-offer-auto` tự động, kèm khi nào nên dùng chế độ nào); mô tả 8 bước; một ví dụ chạy thật rút gọn cho MỖI chế độ (ngành POD/Temu); đoạn hội thoại minh họa; mục "Nguồn & bản quyền" ghi rõ dựa trên sách của Hormozi và không sao chép nguyên văn; giấy phép.

## Ngoài phạm vi (YAGNI)

- Không có agent chấm điểm tách riêng (gộp vào bước 8 của skill).
- Chỉ 2 điểm vào (2 chế độ), KHÔNG có 8 slash command cho từng bước.
- Không tích hợp MCP/hook.
- Không đa ngôn ngữ (chỉ tiếng Việt).

## Tiêu chí hoàn thành

- Cài được plugin từ repo GitHub và chạy được cả `/grand-slam-offer` lẫn `/grand-slam-offer-auto` không lỗi.
- Chế độ hỏi–đáp dẫn hết 8 bước có dừng hỏi người dùng; chế độ tự động chạy trọn 8 bước chỉ sau 1 câu gom thông tin và ghi rõ giả định.
- Cả hai chế độ tạo/ghi được `my-offer.md`.
- Nội dung reference đủ để một người chưa đọc sách vẫn làm được offer.
- README đủ để người lạ tự cài và dùng.
- Không có đoạn sao chép nguyên văn từ sách; có ghi nguồn.
