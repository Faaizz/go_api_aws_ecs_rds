package handle

import (
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/julienschmidt/httprouter"

	"github.com/faaizz/go_api_aws_ecs_rds/controller"
)

func BookCreate(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	title := r.FormValue("title")
	if title == "" {
		http.Error(w, "title is required", http.StatusBadRequest)
		return
	}
	author := r.FormValue("author")
	if author == "" {
		http.Error(w, "author is required", http.StatusBadRequest)
		return
	}
	yearStr := r.FormValue("year")
	if yearStr == "" {
		http.Error(w, "year is required", http.StatusBadRequest)
		return
	}
	year, err := strconv.Atoi(yearStr)
	if err != nil {
		log.Println(err)
		http.Error(w, "year must be a valid calendar year", http.StatusBadRequest)
		return
	}

	book, err := controller.CreateBook(title, author, year)
	if err != nil {
		log.Println(err)
		http.Error(w, "could not create book", http.StatusInternalServerError)
		return
	}

	fmt.Fprintf(w, "Book created: %+v\n", book)
}
