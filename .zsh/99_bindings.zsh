# vim: ft=zsh ts=2 sw=2

# for neo layout
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kdch1]}" delete-char

# zsh-history-substring-search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey -M menuselect '^ ' accept-and-infer-next-history

# Options for Plugin zsh-users/zsh-autosuggestions
bindkey '^e' autosuggest-execute
