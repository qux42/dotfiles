
##########################################################################
# Profiling slow zsh-startup
##########################################################################
PROFILING=0

if [[ $PROFILING >0 ]]; then
  zmodload zsh/zprof
fi
#########################################################################
bindkey -e

bindkey -M viins  'jj' vi-cmd-mode
bindkey -M vicmd  '^[[8~' end-of-line
bindkey -M vicmd  '^[[7~' beginning-of-line
bindkey -M vicmd  '^[[3~' delete-char
bindkey -M vicmd  '^?' backward-delete-char

bindkey -M viins '^[.' insert-last-word
bindkey -M viins "^[0" digit-argument
bindkey -M viins "^[1" digit-argument
bindkey -M viins "^[2" digit-argument
bindkey -M viins "^[3" digit-argument
bindkey -M viins "^[4" digit-argument
bindkey -M viins "^[5" digit-argument
bindkey -M viins "^[6" digit-argument
bindkey -M viins "^[7" digit-argument
bindkey -M viins "^[8" digit-argument
bindkey -M viins "^[9" digit-argument
bindkey -M viins "^[^M" self-insert-unmeta


PATH=$PATH:~/.local/bin:~/.cabal/bin



## backspace and ^h working even after
## returning from command mode
#bindkey '^?' backward-delete-char
#bindkey '^h' backward-delete-char

## ctrl-w removed word backwards
#bindkey '^w' backward-kill-word

## ctrl-r starts searching history backward
#bindkey '^r' history-incremental-search-backward
##########################################################################
#
##########################################################################
autoload -U promptinit && promptinit
if prompt -l | grep -q samuel ; then
	prompt samuel
fi

#########################################################################
export EDITOR='nvim'


_custom_zsh_config_base="${${(%):-%x}:A:h}"

# bail out if global config is disabled
[[ $_custom_zsh_config_base == /etc/* && $_custom_zsh_no_global == 1 ]] && return

# bail out if we are already loaded
if (( _custom_zsh_config_loaded )); then
	print -P '%B%F{red}The custom ZSH config is already loaded (probably from the global zshrc)%f%b'
	print -P "%B%F{red}The local version ($_custom_zsh_config_base) has NOT been loaded%f%b"
	print -P '%B%F{yellow}To disable this warning, run the following command:%f%b'
	print -P "%B%F{green}echo '_custom_zsh_no_global=1' >>! ~/.zshenv%f%b"
	return
fi
_custom_zsh_config_loaded=1

# load all our config files
for file ($_custom_zsh_config_base/.zsh/*.zsh(N)); do
	source $file
done

## complete not just at the end
setopt complete_in_word
#
#
#
#
## print a errormessage when commands dosent match any files (echo hund*)
setopt no_match
### print a error message when in case of errorous patterns like: echo [-
setopt bad_pattern
### X='*' echo $x                   <-- i would see all files if thise were on
unsetopt glob_subst
unsetopt ksh_glob             # i dont do korn shell
unsetopt ksh_arrays           # i dont do korn shell
unsetopt ksh_autoload         # i dont do korn shell
### some historic korn shell compatibility stuff, i dont do korn shell
setopt prompt_subst         # enable fancy substitution syntax in shell prompts
setopt no_check_jobs        # don't warn me about background processes when exiting
setopt no_hup               # don't kill background processes when exiting
unsetopt rm_star_silent       # warn me when i do rm *
### dont lower the priority of processes i send to the background
unsetopt bg_nice
###dont spam console when bg-processes finish, show the message on return or ctrl-c
unsetopt notify
unsetopt globdots             # rm * should not remove .somefile
unsetopt csh_junkie_history   # i dont do c shell
unsetopt csh_junkie_loops     # i dont do c shell
unsetopt csh_null_glob        # i dont do c shell
unsetopt csh_junkie_quotes    # i dont do c shell
#


##########################################################################
#  was set before but i think i don't need it!
##########################################################################

#Paths and exports
fpath=(~/.zsh $fpath)

. /usr/share/z/z.sh

# restore terminal state after exiting a program
ttyctl -f



cdUndoKey() {
  popd
  zle       reset-prompt
  echo
  ls
  zle       reset-prompt
}

cdParentKey() {
  pushd ..
  zle      reset-prompt
  echo
  ls
  zle       reset-prompt
}

zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[^[[D'      cdParentKey
bindkey '^[^[[C'      cdUndoKey

##########################################################################
# Profiling slow zsh-startup
##########################################################################
if [[ $PROFILING >0 ]]; then
  zprof
fi


