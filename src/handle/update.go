package handle

import (
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/julienschmidt/httprouter"

	"github.com/faaizz/go_api_aws_ecs_rds/controller"
)

func BookUpdate(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
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

	idStr := ps.ByName("id")
	if idStr == "" {
		http.Error(w, "id is required", http.StatusBadRequest)
		return
	}
	idUint64, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		http.Error(w, "id must be a valid integer", http.StatusBadRequest)
		return
	}
	id := uint(idUint64)

	book, err := controller.UpdateBook(id, title, author, year)
	if err != nil {
		log.Println(err)
		http.Error(w, "failed to update book", http.StatusInternalServerError)
		return
	}

	fmt.Fprintf(w, "Updated book: %+v\n", book)
}
