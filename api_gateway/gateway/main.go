package main

import (
	initApp "dolaway/module/gateway/core/init"
	requestHandler "dolaway/module/gateway/core/request"
	"fmt"
	"net/http"
	"time"
)

func main() {
	fmt.Println("start App .. ")
	router := http.NewServeMux()
	Root := initApp.ReadConfig()

	router.Handle("/", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		requestHandler.HttpHandler(w, r, Root)
	}))

	srv := &http.Server{
		Addr:         ":" + Root.Router.Port,
		Handler: router,
		ReadTimeout:  120 * time.Second,
		WriteTimeout: 120 * time.Second,
	}
	fmt.Println("ListenAndServe HTTP 80")

	srv.ListenAndServe()

}
