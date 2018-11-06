DIRSTACKSIZE=20

unsetopt AUTO_PUSHD
## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS

setopt PUSHD_SILENT PUSHD_TO_HOME

## This reverts the +/- operators.
setopt PUSHD_MINUS

DIRSTACKFILE="$HOME/.zsh/cache/dirstack/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} > $DIRSTACKFILE
}
