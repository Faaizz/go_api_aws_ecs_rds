package handle

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/julienschmidt/httprouter"

	"github.com/faaizz/go_api_aws_ecs_rds/controller"
)

func BookRead(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
	idStr := ps.ByName("id")
	id, err := sanitizeID(idStr)
	if err != nil {
		log.Println(err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	book, err := controller.BC.ReadBook(id)
	if err != nil {
		log.Println(err)
		http.Error(w, "could not read book", http.StatusInternalServerError)
		return
	}

	w = addHeaders(w)
	json.NewEncoder(w).Encode(book)
}
