package request

import (
	"fmt"
	AppCore "dolaway/module/gateway/core"
	AppLogger "dolaway/module/gateway/core/logger"
	"net/http"
)

func HttpHandler(w http.ResponseWriter, r *http.Request, root AppCore.JsonRoot) int {

	originalPath := r.URL.Path

	logger := AppLogger.GetLogInstance()
	logger.InitLog(originalPath)
	
	service, _ := checkServiceExist(r, root.Router, originalPath, logger)

	var req *http.Request

	defaultForwardPath := service.TargetPath

	req, err := createRequest(r, defaultForwardPath, originalPath, logger)
	if err != nil {
		logger.AddStep("HttpHandler", err.Error())
		logger.DestroyLogInstance()
		fmt.Println("not createRequest")
		AppCore.ShowError(w, err, http.StatusBadGateway)
		return 0
	}

	res := sendRequest(w, req, root.Router, logger)

	return res
}
