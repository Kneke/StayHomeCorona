package common

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

func LoadEnv(envVar string) string {
	err := godotenv.Load("local.env")
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	return os.Getenv(envVar)
}
