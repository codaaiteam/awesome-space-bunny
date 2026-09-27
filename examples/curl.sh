#!/usr/bin/env bash
# Space Bunny Alpha via the hosted OpenAI-compatible API.
# Get a free key at https://spacebunnymodel.com/get-jev  and:  export SPACE_BUNNY_API_KEY=sb_live_...
set -euo pipefail
: "${SPACE_BUNNY_API_KEY:?set SPACE_BUNNY_API_KEY (free key at https://spacebunnymodel.com/get-jev)}"

echo "== chat =="
curl -s https://spacebunnymodel.com/api/v1/chat/completions \
  -H "Authorization: Bearer $SPACE_BUNNY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"space-bunny-alpha","messages":[{"role":"user","content":"Explain a 1M-token context window in 3 bullets."}]}' \
  | python3 -c 'import sys,json;print(json.load(sys.stdin)["choices"][0]["message"]["content"])'

echo; echo "== streaming =="
curl -sN https://spacebunnymodel.com/api/v1/chat/completions \
  -H "Authorization: Bearer $SPACE_BUNNY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"space-bunny-alpha","stream":true,"messages":[{"role":"user","content":"Write a haiku about a bunny coding in space."}]}'
