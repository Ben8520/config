# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/ben/.zshrc'

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
# End of lines added by compinstall

autoload -Uz colors && colors
PROMPT="%{$fg_bold[white]%}%n@%m:%2~/ >%{$reset_color%} "

# ls colors
alias ls='ls --color=auto'
LS_COLORS='di=31:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS

# Aliases for Pacman
alias pacClean='sudo pacman -Rns $(sudo pacman -Qtdq) 2>/dev/null && sudo pacman -Sc'
alias pacUpdate='sudo pacman -Suy && pacClean'
alias pacInstall='sudo pacman -S $1'
alias pacDelete='sudo pacman -Rns $1'
alias pacList='comm -23 <(pacman -Qeq | sort) <(pacman -Qgq base base-devel | sort)'
alias pacMirror='sudo reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# Alias for GitHub
alias upload='make clean && git ss && git add . && git cam "Update file(s)" && git ps'

# Alias for emacs
alias emacs='emacs -nw -q'
alias journal='emacs -nw -q .log.org'
