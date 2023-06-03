package controller

import (
	"github.com/faaizz/go_api_aws_ecs_rds/model"
)

func GetBooks() ([]model.Book, error) {
	var books []model.Book
	tx := DB.Find(&books)
	return books, tx.Error
}

func CreateBook(title, author string, year int) (model.Book, error) {
	book := model.Book{
		Title:  title,
		Author: author,
		Year:   year,
	}

	tx := DB.Create(&book)
	return book, tx.Error
}

func ReadBook(id uint) (model.Book, error) {
	var book model.Book
	tx := DB.First(&book, id)
	return book, tx.Error
}

func UpdateBook(id uint, title, author string, year int) (model.Book, error) {
	var book model.Book
	tx := DB.First(&book, id)
	if tx.Error != nil {
		return book, tx.Error
	}

	book.Title = title
	book.Author = author
	book.Year = year
	tx = DB.Save(&book)

	return book, tx.Error
}

func DeleteBook(id uint) error {
	tx := DB.Delete(&model.Book{}, id)
	return tx.Error
}
