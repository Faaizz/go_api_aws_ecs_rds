package handle

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/julienschmidt/httprouter"

	"github.com/faaizz/go_api_aws_ecs_rds/controller"
	"github.com/faaizz/go_api_aws_ecs_rds/model"
)

func BookUpdate(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
	br := &model.BookRequest{}

	err := json.NewDecoder(r.Body).Decode(br)
	if err != nil {
		log.Println(err)
		http.Error(w, "could not decode request body", http.StatusBadRequest)
		return
	}

	err = br.Validate()
	if err != nil {
		log.Println(err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	idStr := ps.ByName("id")
	id, err := sanitizeID(idStr)
	if err != nil {
		log.Println(err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	book, err := controller.UpdateBook(id, br.Title, br.Author, br.Year)
	if err != nil {
		log.Println(err)
		http.Error(w, "failed to update book", http.StatusInternalServerError)
		return
	}

	w = addHeaders(w)
	json.NewEncoder(w).Encode(book)
}
