package controller

import (
	"fmt"
	"os"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB
var dbHost string
var dbPort string
var dbUser string
var dbPassword string
var dbName string
var sslMode string

func init() {
	dbHost = os.Getenv("DB_HOST")
	if dbHost == "" {
		dbHost = "localhost"
	}
	dbPort = os.Getenv("DB_PORT")
	if dbPort == "" {
		dbPort = "5432"
	}
	sslMode = os.Getenv("DB_SSLMODE")
	if sslMode == "" {
		sslMode = "disable"
	}

	dbUser = os.Getenv("DB_USER")
	if dbUser == "" {
		panic("DB_USER environment variable required but not set")
	}
	dbPassword = os.Getenv("DB_PASSWORD")
	if dbPassword == "" {
		panic("DB_PASSWORD environment variable required but not set")
	}
	dbName = os.Getenv("DB_NAME")
	if dbName == "" {
		panic("DB_NAME environment variable required but not set")
	}

}

func SetupDB() (*gorm.DB, error) {
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=%s TimeZone=Europe/Berlin",
		dbHost, dbUser, dbPassword, dbName, dbPort, sslMode)
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	return db, err
}
