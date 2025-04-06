backend/
├── api/                     # Định nghĩa API
│   ├── proto/               # gRPC Protocol Buffers definitions
│   ├── openapi/             # OpenAPI/Swagger specifications
│   └── graphql/             # GraphQL schema definitions
│
├── cmd/                     # Điểm vào chương trình
│   ├── server/              # API server
│   │   └── main.go
│   └── worker/              # Background worker
│       └── main.go
│
├── configs/                 # Cấu hình ứng dụng
│   ├── config.yaml          # Cấu hình mặc định
│   ├── config.local.yaml    # Cấu hình môi trường cục bộ (gitignore)
│   └── config.docker.yaml   # Cấu hình cho môi trường docker
│
├── internal/                # Mã nguồn private của project
│   ├── domain/              # Domain layer, chứa core business logic
│   │   ├── entity/          # Domain entities
│   │   ├── repository/      # Repository interfaces
│   │   ├── service/         # Domain services
│   │   └── errors/          # Domain-specific errors
│   │
│   ├── usecase/             # Application use cases
│   │   ├── auth/            # Use cases xác thực
│   │   ├── user/            # Use cases người dùng
│   │   ├── product/         # Use cases sản phẩm
│   │   └── common/          # Interface chung cho use cases
│   │
│   ├── delivery/            # Delivery layer (API handlers)
│   │   ├── http/            # HTTP handlers
│   │   │   ├── middleware/  # HTTP middleware
│   │   │   ├── router.go    # HTTP router setup
│   │   │   └── handlers/    # HTTP handlers theo domain
│   │   ├── grpc/            # gRPC handlers
│   │   │   └── services/    # gRPC service implementations
│   │   └── graphql/         # GraphQL handlers
│   │       ├── resolvers/   # GraphQL resolvers
│   │       └── schema.go    # GraphQL schema configuration
│   │
│   ├── infrastructure/      # Implementations của interfaces
│       ├── repository/      # Repository implementations
│       │   ├── postgres/    # PostgreSQL repositories
│       │   └── mongodb/     # MongoDB repositories
│       ├── cache/           # Cache implementations
│       │   ├── redis/       # Redis cache implementation
│       │   └── memcached/   # Memcached implementation
│       ├── messaging/       # Messaging implementations
│       │   ├── kafka/       # Kafka producer/consumer
│       │   └── rabbitmq/    # RabbitMQ producer/consumer
│       ├── auth/            # Auth implementations
│       │   ├── jwt/         # JWT authentication
│       │   └── oauth/       # OAuth clients
│       ├── search/
│       │   └── elasticsearch/
│       ├── logging/         # Logging implementation (e.g., using Zap, Logrus)
│       ├── monitoring/      # Monitoring & metrics implementation (e.g., using Viper)
│       └── config/          # Configuration loading
│
├── migrations/              # Database migrations
│   ├── postgres/
│   │   ├── 00001_init.up.sql
│   │   └── 00001_init.down.sql
│   └── mongodb/
│       ├── 00001_init.js
│       └── 00001_rollback.js
│
├── pkg/
│   ├── logger/              # Logging utilities
│   ├── errors/              # Common error types
│   ├── validator/           # Validation utilities
│   ├── auth/                # Authentication utilities
│   └── tracer/              # Distributed tracing utilities
│
├── scripts/                 # Helper scripts
│   ├── build.sh             # Build script
│   ├── test.sh              # Test script
│   ├── migrate.sh           # Database migration script
│   └── seed.sh              # Database seeding script
│
├── test/                    # Test files
│   ├── integration/         # Integration tests
│   ├── e2e/                 # End-to-end tests
│   └── mocks/               # Mock implementations
│
├── deployments/             # Deployment configurations
│   ├── docker/              # Docker configurations
│   │   ├── Dockerfile
│   │   ├── Dockerfile.worker
│   │   └── docker-compose.yml
│   └── k8s/                 # Kubernetes manifests
│       ├── api/             # API server manifests
│       ├── worker/          # Worker manifests
│       └── infrastructure/  # Infrastructure components
│
├── .github/                 # CI/CD configurations
│   └── workflows/
│       ├── build.yml
│       ├── test.yml
│       └── deploy.yml
│
├── docs/                    # Documentation
│   ├── architecture.md      # Architecture documentation
│   ├── api.md               # API documentation
│   └── development.md       # Development guide
│
├── .gitignore
├── go.mod
├── go.sum
├── Makefile                 # Command shortcuts
└── README.md
