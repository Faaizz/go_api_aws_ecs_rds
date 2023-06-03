package handle

import (
	"fmt"
	"log"
	"net/http"

	"github.com/julienschmidt/httprouter"

	"github.com/faaizz/go_api_aws_ecs_rds/controller"
)

func BookIndex(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	bs, err := controller.GetBooks()
	if err != nil {
		log.Println(err)
		http.Error(w, "could not get books", http.StatusInternalServerError)
		return
	}

	fmt.Fprintf(w, "%+v", bs)
}
