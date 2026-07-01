# Grand Slam Offer — Plugin cho Claude Code

Plugin giúp bạn tạo một **Grand Slam Offer** hoàn chỉnh — lời chào hàng hấp dẫn đến mức khách hàng cảm thấy *ngốc nếu từ chối* — dựa trên phương pháp trong cuốn ***$100M Offers*** của **Alex Hormozi**.

Claude sẽ dẫn bạn qua **8 bước** đúng theo khung của cuốn sách và ghi kết quả dần vào một file `my-offer.md`. Có **2 chế độ**: hỏi–đáp từng bước, hoặc để AI tự làm trọn gói.

> 🇻🇳 Nội dung plugin bằng **tiếng Việt** (giữ nguyên các thuật ngữ gốc: *Grand Slam Offer, Value Equation, Trim & Stack, MAGIC*).

---

## ✨ Tính năng

- **8 bước có hệ thống**: Thị trường đói khát → Định giá → Phương trình Giá trị → Vấn đề & Giải pháp → Trim & Stack → Nâng cao (Khan hiếm/Cấp bách/Bonus/Bảo đảm) → Đặt tên (MAGIC) → Chấm điểm.
- **2 chế độ chạy:**
  - `/grand-slam-offer` — **Hỏi–đáp**: Claude dẫn từng bước, hỏi bạn 1–3 câu mỗi bước, bạn xác nhận rồi đi tiếp.
  - `/grand-slam-offer-auto` — **Tự động**: Claude hỏi đúng 1 câu gom thông tin rồi tự làm hết 8 bước, tự đặt giả định (đánh dấu rõ), tự chấm điểm.
- **Kết quả lưu ra file** `my-offer.md` build dần — bạn giữ lại, chỉnh sửa, tái sử dụng.
- **Chấm điểm & checklist** ở bước cuối để tìm điểm yếu và cải thiện.

---

## 📦 Cài đặt

### Cách 1 — Cài từ GitHub qua marketplace (khuyến nghị)

Trong Claude Code, chạy 2 lệnh:

```
/plugin marketplace add trananhtung/grand-slam-offer
/plugin install grand-slam-offer@grand-slam-offer
```

Sau đó khởi động lại phiên (hoặc mở phiên mới) để nạp plugin.

### Cách 2 — Cài từ thư mục local (khi bạn đã clone repo)

```
/plugin marketplace add /đường-dẫn/tới/grand-slam-offer
/plugin install grand-slam-offer@grand-slam-offer
```

### Cách 3 — Cài thủ công (personal skill + commands)

Nếu không dùng marketplace, copy trực tiếp:

```bash
# skill
cp -r skills/grand-slam-offer ~/.claude/skills/grand-slam-offer
# commands
cp commands/grand-slam-offer.md      ~/.claude/commands/grand-slam-offer.md
cp commands/grand-slam-offer-auto.md ~/.claude/commands/grand-slam-offer-auto.md
```

Rồi mở phiên Claude Code mới.

---

## 🚀 Cách dùng

### Chế độ Hỏi–đáp

```
/grand-slam-offer
```

Claude sẽ:
1. Hỏi tên/đường dẫn file offer (mặc định `my-offer.md`) và tạo file.
2. Dẫn bạn qua 8 bước; mỗi bước hỏi vài câu, ghi kết quả vào file, rồi hỏi có tiếp không.
3. Kết thúc bằng chấm điểm + gợi ý cải thiện.

Bạn có thể yêu cầu quay lại sửa bất kỳ bước nào bất cứ lúc nào.

### Chế độ Tự động

```
/grand-slam-offer-auto
```

Hoặc kèm mô tả luôn để bỏ qua bước hỏi:

```
/grand-slam-offer-auto Shop POD bán áo/mug in chân dung thú cưng cho chủ chó mèo trên Temu, giá hiện tại $19, muốn nâng lên gói quà cao cấp.
```

Claude sẽ tự chạy hết 8 bước, tự đặt giả định (đánh dấu `> Giả định:` trong file để bạn rà lại), tự chấm điểm, rồi mời bạn tinh chỉnh.

> 💡 Bạn cũng có thể không dùng slash command — chỉ cần nói *"giúp tôi tạo một offer theo kiểu Hormozi"* thì skill sẽ tự kích hoạt.

> ℹ️ **Lưu ý tên lệnh:** khi cài **qua marketplace (Cách 1/2)**, lệnh có tiền tố tên plugin:
> `/grand-slam-offer:grand-slam-offer` và `/grand-slam-offer:grand-slam-offer-auto`.
> Khi cài **thủ công (Cách 3)**, lệnh gọn hơn: `/grand-slam-offer` và `/grand-slam-offer-auto`.

---

## 🧭 8 bước tạo Grand Slam Offer

| Bước | Tên | Nội dung |
|------|-----|----------|
| 0 | Định hướng | Xác định kết quả mơ ước (Dream Outcome) của khách |
| 1 | Thị trường đói khát | Chọn ngách theo 4 tiêu chí: đau, sức mua, dễ nhắm, tăng trưởng |
| 2 | Định giá | Thoát bẫy hàng hoá đại trà, đi hướng cao cấp/phân hoá |
| 3 | Phương trình Giá trị | (Kết quả mơ ước × Khả năng đạt được) / (Độ trễ × Công sức) |
| 4 | Vấn đề & Giải pháp | Liệt kê mọi trở ngại → đảo thành giải pháp |
| 5 | Trim & Stack | Cắt thứ giá-trị-thấp/chi-phí-cao, xếp chồng value stack |
| 6 | Nâng cao | Khan hiếm, Cấp bách, Bonus, Cam kết bảo đảm |
| 7 | Đặt tên | Công thức MAGIC |
| 8 | Chấm điểm | Rubric Value Equation + checklist + 3 việc cải thiện |

Ví dụ minh hoạ xuyên suốt trong plugin dùng ngành **Print-on-demand / Temu** (shop in chân dung thú cưng).

---

## 🗂 Cấu trúc plugin

```
grand-slam-offer/
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── commands/
│   ├── grand-slam-offer.md        # chế độ hỏi–đáp
│   └── grand-slam-offer-auto.md   # chế độ tự động
├── skills/
│   └── grand-slam-offer/
│       ├── SKILL.md               # điều phối 2 chế độ + 8 bước
│       ├── references/            # kiến thức chi tiết từng bước (00–08)
│       └── assets/
│           └── mau-offer.md       # template hồ sơ offer
└── README.md
```

---

## 📚 Nguồn & Bản quyền

- Phương pháp dựa trên cuốn ***$100M Offers: How To Make Offers So Good People Feel Stupid Saying No*** của **Alex Hormozi** (Acquisition.com, 2021).
- Plugin này **diễn giải lại khung/quy trình bằng lời riêng** để hướng dẫn thực hành; **không sao chép nguyên văn** nội dung sách. Mọi ý tưởng, công thức (Value Equation, MAGIC…) thuộc về tác giả gốc.
- Khuyến khích bạn **mua và đọc bản gốc** để hiểu sâu.
- Đây là công cụ hỗ trợ tư duy marketing, **không phải tư vấn tài chính/pháp lý**. Hãy kiểm chứng offer với thị trường thật.

Mã nguồn plugin phát hành theo giấy phép **MIT** (xem `LICENSE`). Giấy phép MIT áp dụng cho phần code/nội dung hướng dẫn do tác giả plugin viết, không mở rộng tới tác phẩm gốc của Alex Hormozi.

---

*Tạo với ❤️ để giúp người bán hàng Việt tạo ra những offer khó chối từ.*
