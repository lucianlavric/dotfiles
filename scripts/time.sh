#!/bin/bash
CATEGORIES=(
    "WORK"
    "VIM"
    "WASTE" 
    "STOP"
)

selected=$(printf "%s\n" "${CATEGORIES[@]}" | sk --margin 10% --color="bw" --bind 'q:abort')
sk_status=$?

if [[ $sk_status -ne 0 || -z "$selected" ]]; then
    exit 0
fi

if [[ "$selected" == "STOP" ]]; then
    tmux set -g status-right ""
else
    tmux set -g status-right "$selected"
    
    if [[ "$selected" == "WASTE" ]]; then
        hostess rm studio.youtube.com > /dev/null 2>&1
        hostess rm www.youtube.com > /dev/null 2>&1
        hostess rm www.reddit.com > /dev/null 2>&1
        hostess rm www.x.com > /dev/null 2>&1
        hostess rm www.linkedin.com > /dev/null 2>&1
        hostess rm www.privatemail.com > /dev/null 2>&1
    else 
        hostess add studio.youtube.com 127.0.0.1 > /dev/null 2>&1
        hostess add www.youtube.com 127.0.0.1 > /dev/null 2>&1
        hostess add www.reddit.com 127.0.0.1 > /dev/null 2>&1
        hostess add www.x.com 127.0.0.1 > /dev/null 2>&1
        hostess add www.linkedin.com 127.0.0.1 > /dev/null 2>&1
        hostess add www.privatemail.com 127.0.0.1 > /dev/null 2>&1
    fi
fi
