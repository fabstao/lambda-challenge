#!/bin/bash
# *******************************************************
# Create WS Endpoint
# (C) Fabian Salamanca 2021
# $1 - arg - API ID
# $2 - arg - Connect Lambda Fun ARN
# $3 - arg - GetWord Lambda Fun ARN
# $4 - arg - Disconnect Lambda Fun ARN
# *******************************************************

APIID=$1

aws apigatewayv2 --region us-east-1 create-api --name "Random Words" --protocol-type WEBSOCKET --route-selection-expression '$request.body.getword'
aws apigatewayv2 create-integration --api-id ${APIID} --integration-type AWS_PROXY --integration-method POST --integration-uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/$2/invocations
aws apigatewayv2 create-integration --api-id ${APIID} --integration-type AWS_PROXY --integration-method POST --integration-uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/$3/invocations
aws apigatewayv2 create-integration --api-id ${APIID} --integration-type AWS_PROXY --integration-method POST --integration-uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/$4/invocations