#!/usr/bin/env bash
# Claude Code status line script

input=$(cat)

# --- Model ---
model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')

# --- Context window ---
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
remaining_pct=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
window_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')

# --- Rate limits (tokens before reset) ---
five_hour_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hour_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_day_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# --- Build progress bar (10 chars wide) ---
build_bar() {
    local pct="${1:-0}"
    local width=10
    local filled=$(echo "$pct $width" | awk '{printf "%d", ($1/100)*$2 + 0.5}')
    local empty=$((width - filled))
    local bar=""
    for i in $(seq 1 $filled); do bar="${bar}█"; done
    for i in $(seq 1 $empty); do bar="${bar}░"; done
    printf "%s" "$bar"
}

# --- ANSI colors ---
BOLD="\033[1m"
DIM="\033[2m"
GREEN="\033[32m"
BLUE="\033[34m"
YELLOW="\033[33m"
RED="\033[31m"
CYAN="\033[36m"
RESET="\033[0m"

# --- Model segment ---
printf "${BOLD}${BLUE}%s${RESET}" "$model"

# --- Context segment ---
if [ -n "$used_pct" ]; then
    bar=$(build_bar "$used_pct")
    used_int=$(printf "%.0f" "$used_pct")

    if [ "$used_int" -ge 80 ]; then
        bar_color="$RED"
    elif [ "$used_int" -ge 50 ]; then
        bar_color="$YELLOW"
    else
        bar_color="$GREEN"
    fi

    printf "  ${DIM}ctx${RESET} ${bar_color}%s${RESET} ${DIM}%s%%${RESET}" "$bar" "$used_int"
fi

# --- Rate limit / before reset ---
if [ -n "$five_hour_pct" ]; then
    rl_int=$(printf "%.0f" "$five_hour_pct")
    rl_bar=$(build_bar "$rl_int")

    if [ "$rl_int" -ge 80 ]; then
        rl_color="$RED"
    elif [ "$rl_int" -ge 50 ]; then
        rl_color="$YELLOW"
    else
        rl_color="$GREEN"
    fi

    reset_str=""
    if [ -n "$five_hour_reset" ]; then
        now=$(date +%s)
        diff=$((five_hour_reset - now))
        if [ "$diff" -gt 0 ]; then
            mins=$(( diff / 60 ))
            hrs=$(( mins / 60 ))
            mins=$(( mins % 60 ))
            if [ "$hrs" -gt 0 ]; then
                reset_str=" ${DIM}(resets in ${hrs}h${mins}m)${RESET}"
            else
                reset_str=" ${DIM}(resets in ${mins}m)${RESET}"
            fi
        fi
    fi

    printf "  ${DIM}5h${RESET} ${rl_color}%s${RESET} ${DIM}%s%%${RESET}%b" "$rl_bar" "$rl_int" "$reset_str"
fi

# --- Token usage segment (right side, plain number / shorthand total) ---
if [ "$window_size" -gt 0 ]; then
    # Format total_input_tokens with commas
    used_fmt="$(printf "%'d" "$total_input")"

    # Shorthand: 200000 → 200k, 1000000 → 1m
    if [ "$window_size" -ge 1000000 ]; then
        size_label="$(echo "$window_size" | awk '{printf "%.0fm", $1/1000000}')"
    elif [ "$window_size" -ge 1000 ]; then
        size_label="$(echo "$window_size" | awk '{printf "%.0fk", $1/1000}')"
    else
        size_label="${window_size}"
    fi

    # Color by usage percentage
    if [ -n "$used_pct" ]; then
        used_int=$(printf "%.0f" "$used_pct")
        if [ "$used_int" -ge 80 ]; then
            tok_color="$RED"
        elif [ "$used_int" -ge 50 ]; then
            tok_color="$YELLOW"
        else
            tok_color="$CYAN"
        fi
    else
        tok_color="$CYAN"
    fi

    tok_bar=$(build_bar "${used_pct:-0}")
    tok_pct_int=$(printf "%.0f" "${used_pct:-0}")
    printf "  ${tok_color}%s${RESET} ${DIM}/ %s${RESET} ${tok_color}%s${RESET} ${DIM}%s%%${RESET}" "$used_fmt" "$size_label" "$tok_bar" "$tok_pct_int"
fi
