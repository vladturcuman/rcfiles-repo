
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 4 numeric
zstyle ':completion:*' prompt 'Maybe try:'
zstyle :compinstall filename '/home/vturcuman/.zshrc'

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000000
setopt autocd extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
setopt vi
KEYTIMEOUT=1
# change cursor shape in vi mode
zle-keymap-select () {
if [[ $KEYMAP == vicmd ]]; then
    # the command mode for vi
    echo -ne "\e[2 q"
else
    # the insert mode for vi
    echo -ne "\e[5 q"
fi
}
precmd_functions+=(zle-keymap-select)
zle -N zle-keymap-select



# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[blue]%}%n %{$fg[yellow]%}%~%{$fg[red]%}]%{$reset_color%}"$'\n'"$%b "

# Enable autocomplete
autoload -U compinit; compinit

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

alias vim=vimx

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set up autocomplete
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
    echo "clone"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# Set up rust
PATH=$PATH:~/.cargo/bin
if  (( ! $+commands[rustup] )); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Start SSH Agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    ssh-add ~/.ssh/git
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock


if [[ $1 == eval ]]; then
    "${(q)@}"
    set --
fi
