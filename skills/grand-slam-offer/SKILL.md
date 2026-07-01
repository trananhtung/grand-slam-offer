---
name: grand-slam-offer
description: Dùng khi người dùng muốn tạo, xây dựng, thiết kế hoặc cải thiện một "Grand Slam Offer", lời chào hàng, gói bán, hoặc offer theo phương pháp "$100M Offers" của Alex Hormozi. Dẫn qua 8 bước (thị trường đói khát, định giá, phương trình giá trị, vấn đề–giải pháp, trim & stack, nâng cao, đặt tên, chấm điểm) ở chế độ hỏi–đáp hoặc tự động, ghi kết quả dần vào my-offer.md.
---

# Grand Slam Offer — Trợ lý tạo lời chào hàng "không thể chối từ"

Skill này giúp người dùng tạo ra một **Grand Slam Offer** — một lời chào hàng hấp dẫn đến mức khách hàng cảm thấy ngốc nếu từ chối — dựa trên phương pháp trong cuốn *$100M Offers* của Alex Hormozi.

Toàn bộ kiến thức chi tiết nằm trong thư mục `references/` của skill này. **Chỉ đọc file reference của bước đang làm** (progressive disclosure), đừng đọc hết một lúc.

## Hai chế độ chạy

Người dùng (qua slash command hoặc câu nói) sẽ cho biết chạy chế độ nào:

- **HỎI–ĐÁP (interactive)** — mặc định. Dẫn từng bước, ở mỗi bước hỏi người dùng 1–3 câu, chốt, ghi file, xác nhận rồi mới đi tiếp. KHÔNG tự trả lời thay họ.
- **TỰ ĐỘNG (auto)** — hỏi đúng 1 câu gom thông tin ban đầu, rồi tự chạy trọn 8 bước không hỏi thêm; tự suy luận, tự đặt giả định (đánh dấu rõ), tự chấm điểm.

Nếu không rõ chế độ nào, hỏi người dùng chọn trước khi bắt đầu.

## Quy tắc chung (áp dụng cho cả 2 chế độ)

1. **File offer.** Mặc định `my-offer.md` trong thư mục làm việc hiện tại.
   - Nếu chưa tồn tại: tạo mới bằng cách copy nội dung từ `assets/mau-offer.md` (trong thư mục skill này).
   - Nếu đã tồn tại: đọc để biết đã làm tới đâu, rồi tiếp tục / cập nhật đúng mục.
2. **Ghi dần.** Sau MỖI bước, cập nhật đúng mục tương ứng trong file offer. Không đợi tới cuối mới ghi.
3. **Ngôn ngữ.** Trả lời và viết nội dung bằng **tiếng Việt**. Giữ nguyên các thuật ngữ gốc khi phù hợp: "Grand Slam Offer", "Value Equation", "Trim & Stack", "MAGIC".
4. **Bám phương pháp, không bịa số liệu.** Dựa trên khung của Hormozi. Nếu đưa ví dụ minh hoạ có con số, ghi rõ đó là ví dụ.
5. **Không phán như tư vấn tài chính/pháp lý.** Đây là khung marketing.

## 8 bước (thứ tự bắt buộc)

Làm lần lượt. Mỗi bước: đọc reference tương ứng, thực hiện, ghi vào file offer.

| Bước | Tên | File reference |
|------|-----|----------------|
| 0 | Định hướng & Kết quả mơ ước | `references/00-tong-quan.md` |
| 1 | Thị trường đói khát | `references/01-thi-truong.md` |
| 2 | Tính phí xứng đáng (định giá) | `references/02-dinh-gia.md` |
| 3 | Phương trình Giá trị | `references/03-value-equation.md` |
| 4 | Vấn đề & Giải pháp | `references/04-van-de-giai-phap.md` |
| 5 | Cắt bỏ & Chắt lọc (Trim & Stack) | `references/05-trim-stack.md` |
| 6 | Nâng cao (Khan hiếm/Cấp bách/Bonus/Bảo đảm) | `references/06-nang-cao.md` |
| 7 | Đặt tên (MAGIC) | `references/07-dat-ten.md` |
| 8 | Chấm điểm & Hoàn thiện | `references/08-cham-diem.md` |

> Bước 0 gồm phần khởi động: xác định kết quả mơ ước (dream outcome) của khách hàng — nền tảng cho mọi bước sau. Ở chế độ tự động, đây cũng là lúc dùng thông tin từ câu hỏi gom đầu vào.

## Luồng cụ thể

### Khi chạy HỎI–ĐÁP
1. Chào ngắn, giải thích sẽ đi qua 8 bước, hỏi tên/đường dẫn file offer (mặc định `my-offer.md`), tạo file.
2. Với mỗi bước 0→8: đọc reference, giải thích ngắn (2–4 câu), hỏi 1–3 câu, chờ trả lời, chốt, ghi file, tóm tắt "đã ghi gì", hỏi "tiếp tục sang bước sau?".
3. Cho phép người dùng quay lại sửa bất kỳ bước nào.
4. Kết thúc bằng bước 8 (chấm điểm) + gợi ý cải thiện.

### Khi chạy TỰ ĐỘNG
1. Hỏi **1 câu duy nhất** gom thông tin (sản phẩm/dịch vụ, khách hàng, giá hiện tại, mục tiêu). Nếu command đã kèm mô tả thì bỏ qua bước hỏi.
2. Tạo file offer.
3. Tự chạy bước 0→8 liên tục, không dừng hỏi. Với mỗi bước: đọc reference, tự điền nội dung tốt nhất, ghi file.
4. Khi thiếu dữ liệu: đặt giả định hợp lý, đánh dấu bằng dòng `> Giả định: ...` để người dùng dễ thấy và chỉnh.
5. Nơi nhiều lựa chọn: sinh 3–5 phương án, chọn tốt nhất, liệt kê phần còn lại làm gợi ý.
6. Sau bước 8: in bản tóm tắt offer, danh sách giả định đã đặt, và mời người dùng chỉnh bất kỳ mục nào.

## Kết quả cuối

Một file offer hoàn chỉnh với đủ các mục, kèm điểm Value Equation và checklist các yếu tố nâng cao. Nhắc người dùng đây là bản nháp chiến lược để họ tinh chỉnh và kiểm chứng với thị trường thật.

---
*Phương pháp dựa trên cuốn "$100M Offers" của Alex Hormozi. Skill này diễn giải lại khung/quy trình bằng lời riêng để hướng dẫn, không sao chép nguyên văn nội dung sách. Khuyến khích đọc bản gốc để hiểu sâu.*
