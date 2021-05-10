#!/bin/bash
# *******************************************************
# Create WS Endpoint
# (C) Fabian Salamanca 2021
# $1 - arg - API ID
# $2 - arg - Integration ID
# *******************************************************

APIID=$1

aws apigatewayv2 create-integration-response \
    --api-id ${APIID} \
    --integration-id $2 \
    --integration-response-key 'getword'
