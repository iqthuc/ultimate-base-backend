# hyper-super-ultimate-mega-ultra-promax-plus-infinity-project
- Đây là project backend được xây dựng theo kiến trúc Clean Architecture và nguyên tắc Domain-Driven Design.
- Các file mẫu sử dụng Go
- Mô tả tổng quát các thành phần có thể có, triển khai các code Go mẫu tiêu chuẩn, tách biệt để có thể tái sử dụng ngay

## Cấu trúc cơ bản Project - chi tiết tại (docs/architecture.md)
```
backend/
├── api/                     # API definitions
├── cmd/                     # entry points
├── configs/                 # Configuration management
├── internal/                # private codes
├── migrations/              # database migrations
├── pkg/                     # public, reusable utilities
├── scripts/                 # helper scripts
├── test/                    # test files
├── deployments/             # deployment configurations
├── docs/                    # documentation
...
```

## giải thích Makefile
```bash
# Chạy API server
make run
# Chạy worker
make worker
# Chạy migrations
make migrate-up
```

## License
MIT
