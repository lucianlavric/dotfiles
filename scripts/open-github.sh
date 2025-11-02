#!/usr/bin/env bash
cd $(tmux display-message -p "#{pane_current_path}")
url=$(git remote get-url origin 2>/dev/null)

if [[ -z "$url" ]]; then
    echo "No git remote found"
    exit 1
fi

if [[ $url == *github.com* ]]; then
    if [[ $url == git@* ]]; then
        # Convert git@github.com:user/repo.git to https://github.com/user/repo
        url=$(echo "$url" | sed 's/git@/https:\/\//' | sed 's/\.com:/.com\//' | sed 's/\.git$//')
    else
        # Already https, just remove .git
        url="${url%.git}"
    fi
    open "$url"
else
    echo "This repository is not hosted on GitHub"
fi
