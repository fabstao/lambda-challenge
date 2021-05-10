#!/bin/bash
#
# TODO: parse DEPID

APIID=$1
DEPID=""
JSON1=$(aws apigatewayv2 --region us-east-1 create-deployment --api-id ${APIID})
parseJson(${JSON1})
aws apigatewayv2 --region us-east-1 create-stage --api-id ${APIID} --deployment-id ${DEPID} --stage-name test