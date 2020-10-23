#!/bin/bash

DEPLOY_REGIONS="$(buildkite-agent meta-data get "deploy-regions")"
echo "Deploy regions: $DEPLOY_REGIONS"
