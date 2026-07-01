---
description: "Tạo Grand Slam Offer theo $100M Offers (Hormozi) — chế độ TỰ ĐỘNG, AI tự làm hết"
argument-hint: "[mô tả sản phẩm/khách hàng/giá — hoặc để trống rồi trả lời 1 câu hỏi]"
---

Người dùng muốn tạo một **Grand Slam Offer** ở **CHẾ ĐỘ TỰ ĐỘNG**.

Hãy dùng skill **`grand-slam-offer`** và chạy ở **CHẾ ĐỘ TỰ ĐỘNG (auto)**:

1. Nếu `$ARGUMENTS` đã có mô tả sản phẩm/dịch vụ, dùng luôn làm đầu vào. Nếu trống, hỏi **đúng 1 câu duy nhất** để gom thông tin: sản phẩm/dịch vụ, khách hàng mục tiêu, mức giá hiện tại, mục tiêu (càng chi tiết càng tốt; thiếu cũng không sao).
2. Sau đó **tự chạy trọn 8 bước, KHÔNG hỏi thêm**: tự suy luận và điền nội dung cho từng bước.
3. Khi thiếu dữ liệu, tự đặt **giả định hợp lý** và **đánh dấu rõ** trong file (dòng bắt đầu bằng `> Giả định:`).
4. Nơi có nhiều lựa chọn (tên offer, bonus…), tự sinh nhiều phương án rồi chọn phương án tốt nhất, giữ phần còn lại làm gợi ý.
5. Ghi toàn bộ vào file offer, tự chấm điểm ở bước 8, in bản tóm tắt + danh sách giả định, rồi mời người dùng tinh chỉnh.

File offer để ghi kết quả: `my-offer.md` trong thư mục hiện tại (trừ khi người dùng chỉ định khác).
