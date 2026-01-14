#!/bin/bash

# Fetch Claude model pricing from models.dev and cache it
PRICING_CACHE="$HOME/.claude/pricing.json"

mkdir -p "$HOME/.claude"

fetch_pricing() {
    # Fetch the models.dev anthropic page
    HTML=$(curl -s -L --max-time 10 "https://models.dev/anthropic" 2>/dev/null)

    [ -z "$HTML" ] && return 1

    # Extract pricing - look for patterns like "$15.00 / 1M" near model names
    OPUS_INPUT=$(echo "$HTML" | grep -i "opus" -A 30 | grep -oE '\$[0-9]+\.?[0-9]*' | head -1 | tr -d '$')
    OPUS_OUTPUT=$(echo "$HTML" | grep -i "opus" -A 30 | grep -oE '\$[0-9]+\.?[0-9]*' | head -2 | tail -1 | tr -d '$')

    SONNET_INPUT=$(echo "$HTML" | grep -i "sonnet-4" -A 30 | grep -oE '\$[0-9]+\.?[0-9]*' | head -1 | tr -d '$')
    SONNET_OUTPUT=$(echo "$HTML" | grep -i "sonnet-4" -A 30 | grep -oE '\$[0-9]+\.?[0-9]*' | head -2 | tail -1 | tr -d '$')

    HAIKU_INPUT=$(echo "$HTML" | grep -i "haiku" -A 30 | grep -oE '\$[0-9]+\.?[0-9]*' | head -1 | tr -d '$')
    HAIKU_OUTPUT=$(echo "$HTML" | grep -i "haiku" -A 30 | grep -oE '\$[0-9]+\.?[0-9]*' | head -2 | tail -1 | tr -d '$')

    # Use defaults for missing values
    cat > "$PRICING_CACHE" << EOF
{
  "opus": { "input": ${OPUS_INPUT:-15}, "output": ${OPUS_OUTPUT:-75} },
  "sonnet": { "input": ${SONNET_INPUT:-3}, "output": ${SONNET_OUTPUT:-15} },
  "haiku": { "input": ${HAIKU_INPUT:-0.25}, "output": ${HAIKU_OUTPUT:-1.25} },
  "last_updated": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF
}

fetch_pricing || {
    # Fallback to defaults if fetch fails and no cache exists
    [ ! -f "$PRICING_CACHE" ] && cat > "$PRICING_CACHE" << 'EOF'
{
  "opus": { "input": 15, "output": 75 },
  "sonnet": { "input": 3, "output": 15 },
  "haiku": { "input": 0.25, "output": 1.25 },
  "last_updated": "default"
}
EOF
}
