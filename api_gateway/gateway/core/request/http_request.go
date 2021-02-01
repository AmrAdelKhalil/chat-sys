package request

import (
	"bytes"
	"fmt"
	AppCore "dolaway/module/gateway/core"
	AppLogger "dolaway/module/gateway/core/logger"
	"io/ioutil"
	"net"
	"net/http"
	"strings"
	"time"
)

func createRequest(r *http.Request, forwardPath AppCore.TargetPath, originalReq string, logger *AppLogger.Logger) (*http.Request, error) {
	newPath := forwardPath.Path + originalReq

	req_content_type := r.Header.Get("Content-Type")
	buf, err := ioutil.ReadAll(r.Body)
	if err != nil {
		logger.AddStep("createRequest", err.Error())
		return nil, err
	}
	req, err := http.NewRequest(r.Method, newPath, bytes.NewBuffer(buf))
	fmt.Println("%v", req)

	if err != nil {
		logger.AddStep("createRequest", err.Error())
		return nil, err
	}

	req.ContentLength = r.ContentLength
	req.Header.Set("Content-Type", req_content_type)

	logger.ForwardPath = newPath
	logger.AddStep("createRequest : Every Thing Is Good ", "")

	return req, nil
}

func sendRequest(w http.ResponseWriter, req *http.Request, router AppCore.Router, logger *AppLogger.Logger) int {
	client := CreateHttpClient(router)

	defer handelPanicRequest()
	resp, err := client.Do(req)
	if err != nil {
		logger.AddStep("HttpHandler", err.Error())
		logger.DestroyLogInstance()
		fmt.Println("not req")
		AppCore.ShowError(w, err, http.StatusBadGateway)
		return 0
	}

	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		logger.AddStep("HttpHandler", err.Error())
		logger.DestroyLogInstance()
		AppCore.ShowError(w, err, http.StatusBadGateway)
		return 0
	}

	headerResp := strings.Join(resp.Header["Content-Type"], "")
	w.Header().Set("Content-Type", headerResp)
	logger.AddStep("HttpHandler : Request Send Successfully", "")
	logger.EndTime = time.Now()
	logger.Status = true

	logger.DestroyLogInstance()
	w.WriteHeader(resp.StatusCode)
	w.Write([]byte(body))
	return 0
}

func handelPanicRequest() {
	if r := recover(); r != nil {
		fmt.Println("recovered from ", r)
	}
}

func CreateHttpClient(router AppCore.Router) *http.Client {
	timeOutValue := router.Settings.TimeOut
	timeout := time.Duration(timeOutValue * time.Second)
	keepAliveTimeout := 600 * time.Second
	var netTransport = &http.Transport{
		Dial: (&net.Dialer{
			Timeout:   timeout,
			KeepAlive: keepAliveTimeout,
		}).Dial,
		TLSHandshakeTimeout:   10 * time.Second,
		MaxIdleConns:          100,
		MaxIdleConnsPerHost:   100,
		ResponseHeaderTimeout: 120 * time.Second,
		ExpectContinueTimeout: 1 * time.Second,
	}

	client := &http.Client{
		Transport: netTransport,
		Timeout:   timeout}
	return client
}
