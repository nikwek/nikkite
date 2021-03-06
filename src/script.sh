#!/bin/bash

# Note that we don't enable the 'e' option, which would cause the script to
# immediately exit if it fails
set -uo pipefail
TOKEN="75d179f07f79944943de79a95de748099ede30db"

# Query all agents and set the SUB string to the desired agent hostname
STR=$(curl -H "Authorization: Bearer $TOKEN" https://api.buildkite.com/v2/organizations/niks-playground/agents)
SUB="swarm-1-1"
read -r -d '' VAR << EOM
- command: echo "It worked!"
  label: ":sparkles:"
  agents:
      queue: "special"
EOM

# begin the pipeline.yml file
echo "steps:"

# add a new command step based on agent availability
if [[ "$STR" == *"$SUB"* ]]; then
    echo "$VAR"
else
    echo "  - command: echo \"Skipped\"" 
fi