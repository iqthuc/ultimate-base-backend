#  Về cơ bản flow sẽ theo clean architecture (copy từ https://github.com/khannedy/golang-clean-architecture)
![Flow](flow.png)

## Giải thích
``` 
Phía Upstream (1->3)
1. Request từ bên ngoài (http, gRPC, Message queue, ...) đến Delivery
2. Delivery chuyển đổi request thành các Model để chuẩn hóa dữ liệu
3. Delivery gọi Use Case, truyền vào các Model dã được chuyển đổi

```

```
Xử lí nghiệp vụ - business logic (4->6)
4. Use Case sử dụng dữ liệu từ Model, tạo ra Entity phục vụ cho xử lí dữ liệu
5. Use Case gọi đến Repository, truyền Entity để thao tác với dữ liệu
6. Repository sử dụng Entity để tạo truy vấn DB
```

```
Dữ liệu và lưu trữ
7. Repository tương tác với Database, thực thi các query
```

```
Phía downstream (8->11)
8. Sau khi xử lí và/hoặc lấy dữ liệu, Use Case tạo lại các Model (từ Entity hoặc kết quả)
9. Use Case gọi Gateway, truyền Model để thực hiện giao tiếp với hệ thống bên ngoài (nếu có)
10. Gateway xây dựng request (http, gRPC, ...) dựa vào Model
11. Gateway thực hiện gửi request đến hệ thống DownStream
```

## Flow mẫu với tính năng Login
```
1. Client gửi Request để Login -> gọi đến route tương ứng
2. Controller:
    - nhận thông tin Request
    - chuyển nó sang Model tương ứng
    - gọi tới Use Case
    - trả kết quả về cho Client
3. Use Case sẽ xử lí các logic ở đây, bao gồm:
    - validate request,
    - mở/đóng db transaction
    - gọi tới repository để lấy dữ liệu
    - phân tích kết quả và tạo đối tượng User entity
    - tạo một UserEvent model, gửi nó tới message queue
    - trả về một kết quả dưới dạng một model response 
4. Repository: thực hiện các thao tác với dữ liệu và trả về kết quả

5. Message queue flow
    - producer nằm ở layer Gateway (giao tiếp với hệ thống bên ngoài, ở đây là kafka)
        - khi có request login và xác nhận thành công, producer sẽ gửi event tới một topic 'users' trong kafka
    - consumer nằm ở layer delivery (tức nhận request đến và gọi use case xử lí)
        - consumer sẽ polling message từ kafka về để xử lí

```

```
Setup message queue (ở đây dùng kafka)
- tạo các producer
- tạo các consumer
- khởi chạy các consumers, các consumers này là các channel liên tục polling message từ kafka
```

## Mục tiêu
- tách biệt rõ trách nhiệm: mỗi layer chỉ làm một việc
- dễ kiểm thử
- dễ mở rộng và bảo trì
- tuân thủ SOLID: các layer không biết chi tiết về nhau, chỉ giao tiếp qua interface

## Lưu ý:
- Model nên tách biệt với Entity, tránh tái sử dụng gây lệ thuộc giữa các layer
- Use Case nên thuần túy, không phụ thuộc vào framework, library nào
- Delivery, Gateway và Repository implement các interface do Use Case định nghĩa
- Có thể inject Config toàn cục nếu cần nhưng nên hạn chế rò rỉ vào domain

## Giải thích flow từ Clean Architecture 

![Clean Architecture](clean-architecture.png)

- Entities
    - đại diện cho Enterprise Business Rules
    - gắn với bản chất của hệ thống
    - biểu diễn bằng Entity - các Object trung tâm (vd: Order, Product, User)
    - vd: với Order entity thì mỗi đơn hàng phải có ít nhất một sản phẩm, sản phẩm giá khong được âm, ...
    - không phụ thuộc vào bất kì thứ gì cả
- Use Cases
    - đại diện cho Application Business Rules, mô tả hành vi của hệ thống
    - là cách app điều phối (orchestration), xử lí Business logic
    - sử dụng entity để thực thi các hành động cụ thể
    - vd: đặt hàng, hủy đơn, thanh toán

  => Domain = Entity + Use Case
    - là phần cốt lõi, nơi mô hình hóa thế giới thật của ứng dụng
    - không nên phụ thuộc vào bất kì framework, database, protocol nào

- Controllers: tương đương handler, delivery (nhận request và gọi Use Case để xử lí)
- Presenters: chuẩn hóa output (sang json, html, ...)
- Gateways: đóng vai trò trung gian, kết nối với các hệ thống bên ngoài (Database, external API)
  
  => Adapters: các lớp chuyển đổi giúp vòng trong tách biệt hoàn toàn với vòng ngoài
-  Frameworks & Drivers: các hệ thống, service độc lập