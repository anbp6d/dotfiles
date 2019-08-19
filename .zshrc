# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/booka/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# antigen configuration
source ~/.antigen/antigen.zsh

antigen use oh-my-zsh
antigen init .antigenrc

# load common dotfiles
source ~/.bash_profile
