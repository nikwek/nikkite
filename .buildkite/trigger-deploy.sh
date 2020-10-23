#!/bin/bash

set -euo pipefail

# Set up a variable to hold the meta-data from your block step
DEPLOY_REGIONS="$(buildkite-agent meta-data get "deploy-regions")"

# Create a pipeline with your trigger step
PIPELINE="steps:
  - trigger: \"deploy-pipeline\"
    label: \"Trigger deploy\"
    build:
      meta_data:
        deploy-regions: $DEPLOY_REGIONS
"

# Upload the new pipeline and add it to the current build
echo "$PIPELINE" | buildkite-agent pipeline upload
