# Bước 5 — Cắt bỏ & Chắt lọc (Trim & Stack)

## Ý tưởng cốt lõi

Ở B4 bạn có một danh sách dài giải pháp. Nếu bỏ hết vào offer, bạn sẽ tốn kém và loãng thông điệp. Trim & Stack giúp chọn **đúng** những giải pháp tạo giá trị cảm nhận cao nhất với chi phí thấp nhất, rồi **xếp chồng** chúng thành một gói hấp dẫn.

Làm 2 việc: **Trim (cắt bỏ)** rồi **Stack (xếp chồng)**.

## Bước 5a — Trim: cắt bỏ theo ma trận Giá trị × Chi phí

Với mỗi giải pháp ở B4, chấm 2 trục:
- **Giá trị cảm nhận với khách:** Cao / Thấp
- **Chi phí cung cấp cho bạn** (tiền, thời gian, công): Cao / Thấp

```
                 Giá trị CAO          Giá trị THẤP
Chi phí THẤP   ★ GIỮ (mỏ vàng)       ◦ Có thể giữ làm bonus
Chi phí CAO    ◐ Giữ chọn lọc         ✗ CẮT BỎ
```

- **Giữ trước hết:** *Giá trị cao — Chi phí thấp* (đây là "mỏ vàng": khách thấy đáng giá, bạn tốn ít).
- **Cân nhắc giữ:** *Giá trị cao — Chi phí cao* — giữ nếu là điểm bán chính, nhưng đừng nhiều.
- **Cắt bỏ:** *Giá trị thấp — Chi phí cao* — loại ngay.
- *Giá trị thấp — Chi phí thấp:* có thể gộp làm phần thưởng nhỏ (bonus) ở B6.

> Nghịch lý: một offer đắt tiền có thể có **chi phí cung cấp thấp** nếu phần lớn giá trị đến từ thông tin, mẫu sẵn, quy trình, cộng đồng, cam kết — thứ nhân bản được. Ưu tiên loại giá trị này.

## Bước 5b — Stack: xếp chồng thành gói + neo giá trị

Gộp các giải pháp giữ lại thành một "ngăn xếp giá trị" (value stack), mỗi dòng là một thành phần, và **gán giá trị ước tính** cho từng dòng. Tổng lại để tạo **mỏ neo giá trị** cao hơn nhiều so với giá bán.

Ví dụ trình bày:

```
Những gì bạn nhận được:
1. [Thành phần lõi] ................................ trị giá $X
2. [Giải pháp giá-trị-cao/chi-phí-thấp #1] ......... trị giá $X
3. [Giải pháp #2] .................................. trị giá $X
4. [Giải pháp #3] .................................. trị giá $X
-------------------------------------------------
Tổng giá trị: $TỔNG
Giá của bạn hôm nay: chỉ $GIÁ  (bằng một phần nhỏ tổng giá trị)
```

Nguyên tắc: **Tổng giá trị ngăn xếp ≫ Giá bán**. Khoảng cách này chính là "cú hời" khách cảm nhận.

## Câu hỏi cho người dùng
1. Trong danh sách giải pháp ở B4, cái nào giá trị cao mà bạn cung cấp lại rẻ/dễ? (giữ)
2. Cái nào tốn kém mà giá trị thấp? (cắt)
3. Ta gán giá trị ước tính bao nhiêu cho mỗi thành phần giữ lại?

Chế độ tự động: tự phân loại toàn bộ giải pháp vào ma trận, cắt nhóm giá-trị-thấp/chi-phí-cao, xếp chồng phần còn lại và gán giá trị ước tính (ghi rõ là ước tính minh hoạ).

## Ví dụ POD/Temu (value stack)

```
Gói "Chân dung Corgi Để Đời":
1. Áo/mug in chân dung thú cưng chất lượng cao ......... $39
2. Bản mockup xem trước + duyệt trước khi in .......... $19
3. Chỉnh & nâng cấp ảnh miễn phí ...................... $15
4. 3 phương án bố cục thiết kế để chọn ................ $20
5. Đóng gói quà + thiệp cá nhân hoá ................... $12
--------------------------------------------------------
Tổng giá trị: $105  →  Giá hôm nay: $49
```

## Ghi vào file offer

```markdown
## 5. Trim & Stack
**Đã cắt:** ...(giá trị thấp / chi phí cao)...
**Value Stack:**
| Thành phần | Giá trị ước tính |
|-----------|------------------|
| ... | $... |
| **Tổng giá trị** | **$...** |
| **Giá bán** | **$...** |
```

Xong bước 5 → chuyển sang `references/06-nang-cao.md`.
