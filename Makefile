export GOOS=linux
export connect="connect"
export disconnect="disconnect"
export word="word"
export ARTF="archive.zip"

all:
	go fmt *.go
	go build -o ${connect} connect/connect.go
	zip ${connect} ${connect}.zip
	go build -o ${word} getword/word.go
	zip ${word} ${word}.zip
	go build -o ${disconnect} connect/disconnect.go	
	zip ${disconnect} ${disconnect}.zip

install:
	aws lambda create-function --function-name lambdaChallenge-${connect} --runtime go1.x --role simplehttplambda --handler Handler --zip-file "fileb://./connect/${connect}.zip"
	aws lambda create-function --function-name lambdaChallenge-${word} -worde go1.x --role simplehttplambda --handler Handler --zip-file "fileb://./getword/${word}.zip"
	aws lambda create-function --function-name lambdaChallenge-${disconnect} --runtime go1.x --role simplehttplambda --handler Handler --zip-file "fileb://./disconnect/${disconnect}.zip"
