package init

import (
	"dolaway/module/gateway/core"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
)

var Root core.JsonRoot


func ReadConfig() core.JsonRoot {
	//for fastening dev
	//os.Setenv("ENVIRONMENT", "dev")

	environment := os.Getenv("ENVIRONMENT")

	readConfigFile(environment)

	return Root
}

func readConfigFile(environment string) {
	file, e := ioutil.ReadFile("gateway/config/"+ environment+ "/config.json")
	if e != nil {
		fmt.Printf("File error: %v\n", e)
		os.Exit(1)
	}
	json.Unmarshal(file, &Root)
}
