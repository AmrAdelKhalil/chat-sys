package core

import (
	"encoding/json"
	"net/http"
)

type appError struct {
	Error      string `json:"error"`
	HttpStatus int    `json:"status"`
}
type errorResource struct {
	Data appError `json:"data"`
}

func ShowError(w http.ResponseWriter, err error, code int) {
	errObj := appError{
		Error:      err.Error(),
		HttpStatus: code,
	}
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	w.WriteHeader(code)

	if j, err := json.Marshal(errorResource{Data: errObj}); err == nil {
		w.Write(j)
	}
}
