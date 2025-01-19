# node
export PATH=/home/martin/.fnm:$PATH
eval "`fnm env`"

## python
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init - zsh)"
