package controller

import (
	"fmt"
	"os"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type IGormDB interface {
	AutoMigrate(dst ...interface{}) error
	Find(dst interface{}, conds ...interface{}) *gorm.DB
	Create(dst interface{}) *gorm.DB
	First(dst interface{}, conds ...interface{}) *gorm.DB
	Save(dst interface{}) *gorm.DB
	Delete(dst interface{}, conds ...interface{}) *gorm.DB
}

type IController interface {
	GetBooks() ([]model.Book, error)
	CreateBook(title, author string, year int) (model.Book, error)
	ReadBook(id uint) (model.Book, error)
	UpdateBook(id uint, title, author string, year int) (model.Book, error)
	DeleteBook(id uint) error
}

var DB IGormDB
var BC IController

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
