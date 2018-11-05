# vim: ft=zsh ts=2 sw=2

##########################################################################
# zgen for installing plugins
##########################################################################
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
	echo "Creating a zgen save"
	zgen load mafredri/zsh-async
	zgen load zsh-users/zsh-syntax-highlighting
	zgen load zsh-users/zsh-completions src
	zgen load zsh-users/zsh-history-substring-search
	zgen load zsh-users/zsh-history-substring-search
	zgen oh-my-zsh plugins/command-not-found
	zgen load trapd00r/LS_COLORS
	zgen load zsh-users/zsh-autosuggestions

	zgen load sindresorhus/pure
	zgen save
fi
