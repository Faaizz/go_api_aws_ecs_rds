package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/julienschmidt/httprouter"

	"github.com/faaizz/go_api_aws_ecs_rds/controller"
	"github.com/faaizz/go_api_aws_ecs_rds/handle"
	"github.com/faaizz/go_api_aws_ecs_rds/middleware"
	"github.com/faaizz/go_api_aws_ecs_rds/model"
)

func main() {
	db, err := controller.SetupDB()
	if err != nil {
		panic(err)
	}
	db.AutoMigrate(&model.Book{})
	controller.DB = db

	bc := controller.Book{}
	controller.BC = &bc

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	handle.Port = port

	router := httprouter.New()

	viewPath := "/view"
	router.GET(viewPath, handle.View)

	apiPath := "/api/v1"

	healthPath := apiPath + "/healthz"
	router.GET(healthPath, handle.Health)

	bookPath := apiPath + "/book"
	router.GET(bookPath, handle.BookIndex)
	router.POST(bookPath, middleware.BasicAuth(handle.BookCreate))
	router.PUT(bookPath+"/:id", middleware.BasicAuth(handle.BookUpdate))
	router.DELETE(bookPath+"/:id", middleware.BasicAuth(handle.BookDelete))
	router.GET(bookPath+"/:id", middleware.BasicAuth(handle.BookRead))

	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), router))
}
