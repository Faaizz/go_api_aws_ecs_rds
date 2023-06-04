package handle

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"time"

	"github.com/julienschmidt/httprouter"
)

var Port string

func View(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	c := &http.Client{
		Timeout: 10 * time.Second,
	}
	req, err := c.Get(fmt.Sprintf("http://localhost:%s/api/v1/book", Port))
	if err != nil {
		log.Println(err)
		fmt.Fprintf(w, "<h1>Something went wrong</h1>")
		return
	}

	defer req.Body.Close()
	bodyB, err := io.ReadAll(req.Body)
	if err != nil {
		log.Println(err)
		fmt.Fprintf(w, "<h1>Something went wrong</h1>")
		return
	}
	body := string(bodyB)

	fmt.Fprintf(w, "<h1>Hello World</h1><div>%s</div>", body)
}
