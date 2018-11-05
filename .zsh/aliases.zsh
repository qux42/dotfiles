# praktische aliase
alias feh='feh --scale-down --geometry 1360x1024 --magick-timeout 2'
alias vim='nvim -p'
alias vgit='vim -c Gstatus'
alias cats='pygmentize -g -O colorful'

alias reboot='systemctl reboot'
alias halt='systemctl poweroff'
#alias mplayer='mplayer -vo vaapi -va vaapi'
alias ls='ls --color=auto'
alias files='ls | wc -l'
alias grep='grep --color=auto'
alias less='less -S -M'
alias df='df -h'
alias du1='/usr/bin/du -h -c  --max-depth=1 | sort -h'
alias du='/usr/bin/du -h -c  --max-depth=0  * | sort -h'
alias diff='colordiff'
alias mkdir='mkdir -p -v'
alias pg='ps -Af | grep $1'
alias 'dirs'='dirs -v'
alias 'passc'='pass -c'
alias  'anki'='anki -b ~/.anki'
# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
#music and video
alias -s flv=mplayer
alias -s mkv=mplayer
alias -s mp3=mplayer
alias -s m4a=mplayer
alias -s avi=mplayer
alias -s pdf=mupdf
#pictures
alias -s jpg=feh
alias -s jpeg=feh
alias -s png=feh
#textfiles
alias -s tex=vim
alias -s txt=vim
#archives
alias -s tar='tar xf'
alias -s bz='tar xf'
alias -s gz='tar xf'
alias -s tgz='tar xf'
alias -s bz2='tar xjvf'
alias -s rar='unrar x'
alias -s zip='7z x'
alias -s 7z='7z x'
#git
alias gitk='gitk --all'

#nice ls
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
alias llh='ls -lh --color=auto'
alias lah='ls -lah --color=auto'

# most
if (which most > /dev/null) ; then
	export PAGER='most'
	alias mountlm='mount -l | column -t | most'
else
	export PAGER='less'
fi

#colored manual
man() {
	env \
		LESS_GTERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}


alias sbt='TERM=xterm-color sbt'
