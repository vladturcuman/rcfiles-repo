export MODULE_PATH=$HOME/.local/lib
export MODULE_PATH=$HOME/.local/lib/zsh/$ZSH_VERSION:$MODULE_PATH
export MODULE_PATH=$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting:$MODULE_PATH
export FPATH=$HOME/.local/share/zsh/site-functions:$HOME/.local/share/zsh/$ZSH_VERSION/functions/
. "$HOME/.cargo/env"
module_path+=("$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting")

