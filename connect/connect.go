package main

import (
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(Handler)
}

func Handler() (string, error) {
	return "Conectado", nil
}