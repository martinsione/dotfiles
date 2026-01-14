#!/bin/bash
input=$(cat)

# Extract Claude Code context
CWD=$(echo "$input" | jq -r '.workspace.current_dir')
MODEL=$(echo "$input" | jq -r '.model.display_name')
MODEL_ID=$(echo "$input" | jq -r '.model.id')
OUTPUT_STYLE=$(echo "$input" | jq -r '.output_style.name')
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
USAGE=$(echo "$input" | jq '.context_window.current_usage')
TOTAL_INPUT=$(echo "$input" | jq -r '.context_window.total_input_tokens')
TOTAL_OUTPUT=$(echo "$input" | jq -r '.context_window.total_output_tokens')
SESSION_ID=$(echo "$input" | jq -r '.session_id')

# Calculate context percentage
if [ "$USAGE" != "null" ]; then
    CURRENT_TOKENS=$(echo "$USAGE" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    PERCENT_USED=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))
else
    PERCENT_USED=0
fi

# Calculate API cost based on model pricing
# Use environment variables if available, otherwise fall back to JSON data
INPUT_TOKENS=${CLAUDE_INPUT_TOKENS:-$TOTAL_INPUT}
OUTPUT_TOKENS=${CLAUDE_OUTPUT_TOKENS:-$TOTAL_OUTPUT}

# Fetch pricing once per session
PRICING_CACHE="$HOME/.claude/pricing.json"
SESSION_MARKER="$HOME/.claude/.pricing_session_${SESSION_ID}"

if [ ! -f "$SESSION_MARKER" ]; then
    # First run of this session - fetch pricing in background
    bash "$HOME/.claude/fetch-pricing.sh" &
    touch "$SESSION_MARKER"
fi

# Determine pricing based on model ID
# Try to read from pricing cache first, fallback to hardcoded values
if [ -f "$PRICING_CACHE" ]; then
    # Extract pricing from cache based on model ID
    case "$MODEL_ID" in
        *opus-4*)
            INPUT_PRICE=$(jq -r '.opus.input // 15' "$PRICING_CACHE")
            OUTPUT_PRICE=$(jq -r '.opus.output // 75' "$PRICING_CACHE")
            ;;
        *sonnet*)
            INPUT_PRICE=$(jq -r '.sonnet.input // 3' "$PRICING_CACHE")
            OUTPUT_PRICE=$(jq -r '.sonnet.output // 15' "$PRICING_CACHE")
            ;;
        *haiku*)
            INPUT_PRICE=$(jq -r '.haiku.input // 0.25' "$PRICING_CACHE")
            OUTPUT_PRICE=$(jq -r '.haiku.output // 1.25' "$PRICING_CACHE")
            ;;
        *)
            # Default to Sonnet pricing
            INPUT_PRICE=$(jq -r '.sonnet.input // 3' "$PRICING_CACHE")
            OUTPUT_PRICE=$(jq -r '.sonnet.output // 15' "$PRICING_CACHE")
            ;;
    esac
else
    # Fallback to hardcoded values if cache doesn't exist
    case "$MODEL_ID" in
        *opus-4*)
            INPUT_PRICE=15   # $15/MTok
            OUTPUT_PRICE=75  # $75/MTok
            ;;
        *sonnet*)
            INPUT_PRICE=3    # $3/MTok
            OUTPUT_PRICE=15  # $15/MTok
            ;;
        *haiku*)
            INPUT_PRICE=0.25    # $0.25/MTok
            OUTPUT_PRICE=1.25   # $1.25/MTok
            ;;
        *)
            # Default to Sonnet pricing
            INPUT_PRICE=3
            OUTPUT_PRICE=15
            ;;
    esac
fi

# Calculate cost (tokens / 1,000,000 * price per MTok)
if [ "$INPUT_TOKENS" != "null" ] && [ "$OUTPUT_TOKENS" != "null" ] && [ -n "$INPUT_TOKENS" ] && [ -n "$OUTPUT_TOKENS" ]; then
    # Use awk for floating point arithmetic
    COST=$(awk -v in_tok="$INPUT_TOKENS" -v out_tok="$OUTPUT_TOKENS" -v in_price="$INPUT_PRICE" -v out_price="$OUTPUT_PRICE" \
        'BEGIN { printf "%.2f", (in_tok / 1000000 * in_price) + (out_tok / 1000000 * out_price) }')
else
    COST="0.00"
fi

# Get current directory (basename)
DIR_NAME=$(basename "$CWD")

# Get git branch (skip optional locks for performance)
GIT_BRANCH=""
if git -C "$CWD" rev-parse --git-dir > /dev/null 2>&1; then
    GIT_BRANCH=$(git -C "$CWD" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git -C "$CWD" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
fi

# Build status line
STATUS="$DIR_NAME"

if [ -n "$GIT_BRANCH" ]; then
    STATUS="$STATUS on $GIT_BRANCH"
fi

STATUS="$STATUS | $MODEL"

if [ "$OUTPUT_STYLE" != "null" ] && [ "$OUTPUT_STYLE" != "default" ]; then
    STATUS="$STATUS ($OUTPUT_STYLE)"
fi

STATUS="$STATUS | ${PERCENT_USED}% context | \$$COST"

printf "%s" "$STATUS"

# Note: Companion script fetch-pricing.sh should exist at ~/.claude/fetch-pricing.sh
