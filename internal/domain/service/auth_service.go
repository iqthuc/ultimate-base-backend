package service

type AuthService interface {
	HashPassword(password string) (string, error)
	VerifyPassword(hashedPassword, password string) bool
}
