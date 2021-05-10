package main

import (
	"errors"
	"fmt"
	"math/rand"
	"strconv"

	"github.com/aws/aws-lambda-go/lambda"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute"

	"log"
)

type Item struct {
	Word string
}

func init() {
}

func main() {
	lambda.Start(Handler)
}

func Handler() (string, error) {
	myitem, err := GetData()

	if err != nil {
		return "Something went wrong!", err
	}

	return myitem.Word, err
}

func GetData() (Item, error) {
	sess := session.Must(session.NewSessionWithOptions(session.Options{
		SharedConfigState: session.SharedConfigEnable,
	}))
	rand.Seed(3)
	// Create DynamoDB client
	svc := dynamodb.New(sess)
	table := "words"
	icount, err1 := svc.DescribeTable(&dynamodb.DescribeTableInput{
		TableName: aws.String(table),
	})
	if err1 != nil {
		log.Panic("DynamoDB table error: ", err1.Error())
	}
	rand.Seed(*icount.Table.ItemCount)
	id := rand.Int63n(*icount.Table.ItemCount)
	result, err := svc.GetItem(&dynamodb.GetItemInput{
		TableName: aws.String(table),
		Key: map[string]*dynamodb.AttributeValue{
			"Id": {
				N: aws.String(strconv.FormatInt(id, 10)),
			},
		},
	})
	if result.Item == nil {
		msg := fmt.Sprintf("Could not find '%d'", id)
		return Item{}, errors.New(msg)
	}
	item := Item{}

	err = dynamodbattribute.UnmarshalMap(result.Item, &item)
	if err != nil {
		log.Panic(fmt.Sprintf("Failed to unmarshal Record, %v", err))
	}
	return item, nil
}
