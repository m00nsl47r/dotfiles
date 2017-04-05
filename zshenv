#!/usr/bin/zsh
export location=$(hostname)
export ZSHD=$HOME/.zshd

export SHELL="/usr/bin/zsh"
export EDITOR="/usr/local/bin/emacs"
export LC_ALL="en_US.UTF-8"

if ! (($+MY_ENVIRONMENT)); then # so the path doesnt get fucking wrecked with multiple invocations of zsh
    # Path - add to path here
    path=($HOME/bin $HOME/.gem/ruby/2.4.0/bin $path[@]) 
    fpath=($ZSHD/functions $ZSHD/completions $fpath[@])

    export MY_ENVIRONMENT=yes
fi
