export GOOS=linux
export bfile="lambdaChallenge"
export ARTF="archive.zip"

all:
	go fmt *.go
	go build -o ${bfile} main.go	
	zip ${ARTF} ${bfile}
