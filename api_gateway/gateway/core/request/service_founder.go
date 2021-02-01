package request

import (
	AppCore "dolaway/module/gateway/core"
	AppLogger "dolaway/module/gateway/core/logger"
	"net/http"
	"strings"
)

func checkServiceExist(r *http.Request, router AppCore.Router, originalPath string, logger *AppLogger.Logger) (AppCore.Services, error) {
	var service AppCore.Services

	servicePrefix := getOriginalPathPrefix(originalPath)
	service = look_up_service(servicePrefix, router.Services)

	if service.ServicePrefix == "" {
		logger.AddStep("notFoundService : Error in finding path", "")
	}

	logger.AddStep("checkServiceExist : Every Thing Is Good", "")
	return service, nil

}

func getOriginalPathPrefix(originalPath string) string {
	serviceNameArray := strings.Split(originalPath, "/")
	servicePrefix := serviceNameArray[1]
	return servicePrefix
}

func look_up_service(service_prefix string, services []AppCore.Services) AppCore.Services{
	var service AppCore.Services
	for _, v := range services {
		if v.ServicePrefix == service_prefix {
			service = v
		}
	}

	return service
}
