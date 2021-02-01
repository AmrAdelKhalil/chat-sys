package logger

import (
	"time"
	"encoding/json"
	"log"
)

type Logger struct {
	OriginalPath string
	ForwardPath  string
	Steps        []Steps
	Status       bool
	StartTime    time.Time
	EndTime      time.Time
}

type Steps struct {
	Step  string
	Error string
}


func GetLogInstance() *Logger {
	return new(Logger)
}

func (logger *Logger) DestroyLogInstance() {
	b, _ := json.Marshal(logger)
	log.Print(string(b))
}

func (logger *Logger) InitLog(originalPath string) {
	logger.OriginalPath = originalPath
	logger.StartTime = time.Now()
	logger.Status = false
}

func (logger *Logger) AddStep(step string, err string) {
	StepData := Steps{
		Step:  step,
		Error: err,
	}
	logger.Steps = append(logger.Steps, StepData)
}
