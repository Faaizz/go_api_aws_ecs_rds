package handle

import (
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/julienschmidt/httprouter"

	"github.com/faaizz/go_api_aws_ecs_rds/controller"
)

func BookRead(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
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

	book, err := controller.ReadBook(id)
	if err != nil {
		log.Println(err)
		http.Error(w, "could not read book", http.StatusInternalServerError)
		return
	}
	fmt.Fprintf(w, "Book: %+v\n", book)
}
