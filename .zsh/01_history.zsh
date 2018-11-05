# vim: ft=zsh ts=2 sw=2

##########################################################################
# options for history
##########################################################################
# if history is full, remove dups first (HISTSIZE must be > SAVEHIST)
setopt HIST_EXPIRE_DUPS_FIRST
# don't find dups with ctrl+r
setopt HIST_FIND_NO_DUPS 
# don't put command in the history if it starts with a space
setopt HIST_IGNORE_SPACE
# merge histories of multiple zsh-sessions
setopt APPEND_HISTORY 
# remove blanks to a minimum before saving in history
setopt HIST_REDUCE_BLANKS
# shares history before session gets closed
setopt SHARE_HISTORY

export HISTFILE=~/.history
export HISTSIZE=35000
export SAVEHIST=30000

# duplicates are ignored for search
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true
# searching ab c will search for *ab*c*
HISTORY_SUBSTRING_SEARCH_FUZZY=true
