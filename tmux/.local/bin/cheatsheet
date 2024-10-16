#!/usr/bin/env zsh
languages=`echo "python rust golang lua cpp c typescript nodejs" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk tmux" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read "query?query: "

if `printf "$languages" | grep -qs $selected`; then
    tmux neww bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'` | less"
else
    tmux neww bash -c "curl cht.sh/$selected~$query | less"
fi
