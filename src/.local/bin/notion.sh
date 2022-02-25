#!/usr/bin/env bash

function main() {
  # | xargs removes trailing whitespace 
  local input=$((printf '%s' | dmenu -i -p "add todo: ") | xargs)

  # If input="" then return
  if [[ -z "$input" ]]; then
    return
  fi

  source $HOME/.config/zsh/config/.env

  curl -X POST https://api.notion.com/v1/pages \
    -H "Authorization: Bearer $NOTION_API_KEY" \
    -H "Content-Type: application/json" \
    -H "Notion-Version: 2021-08-16" \
    --data "{
      \"parent\": { \"database_id\": \"$NOTION_DATABASE_ID\" },
      \"properties\": {
        \"Name\": {
          \"title\": [
            {
              \"text\": {
                \"content\": \"$input\"
              }
            }
          ]
        }
      }
    }"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

