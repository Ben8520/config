#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ls colors
alias ls='ls --color=auto'

# Definition colors
# di = directory
# fi = file
# ln = symbolic link
# pi = fifo file
# so = socket file
# bd = block (buffered) special file
# cd = character (unbuffered) special file
# or = symbolic link pointing to a non-existent file (orphan)
# mi = non-existent file pointed to by a symbolic link (visible when you type ls -l)
# ex = file which is executable (ie. has 'x' set in permissions)

# 0   = default colour
# 1   = bold
# 4   = underlined
# 5   = flashing text
# 7   = reverse field
# 31  = red
# 32  = green
# 33  = orange
# 34  = blue
# 35  = purple
# 36  = cyan
# 37  = grey
# 40  = black background
# 41  = red background
# 42  = green background
# 43  = orange background
# 44  = blue background
# 45  = purple background
# 46  = cyan background
# 47  = grey background
# 90  = dark grey
# 91  = light red
# 92  = light green
# 93  = yellow
# 94  = light blue
# 95  = light purple
# 96  = turquoise
# 100 = dark grey background
# 101 = light red background
# 102 = light green background
# 103 = yellow background
# 104 = light blue background
# 105 = light purple background
# 106 = turquoise background

LS_COLORS='di=31:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS

PS1='[\u@\h \W]\$ '

# Path variable
export PATH=$PATH:/home/ben/.bin/

# Aliases for Pacman
alias pacClean='sudo pacman -Rns $(sudo pacman -Qtdq) 2>/dev/null && sudo pacman -Sc'
alias pacUpdate='sudo pacman -Suy && pacClean'
alias pacInstall='sudo pacman -S $1'
alias pacDelete='sudo pacman -Rns $1'

# Aliases for GoPro
alias GoProClean='goPro.sh --clean'

screenfetch
