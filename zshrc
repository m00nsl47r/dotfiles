#!/usr/bin/zsh
# ~/.zshrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTFILE=$ZSHD/histfile
HISTSIZE=5000
SAVEHIST=10000

# where we store specific zsh scripts
ZSHD_bin=$ZSHD/bin
# Path - add to path here
if (($+MY_ENVIRONMENT)); then # add login specific zsh pathing
    path=($ZSHD_bin $HOME/bin/scripts $path[@])
    # ADDED TO ENV -- fpath=($ZSHD/functions $fpath[@]) # this should really be in the env
fi


#theme settings
THEMEREPO="$ZSHD/themes/"
THEME="manual"

# source initialization sub-script
source $ZSHD/zshopt # initialize zsh first, maybe this should be env?
source $ZSHD/init-functions #todo: perhaps this should be an environment thing? or maybe there should be an env fnd and a shell fnd
source $ZSHD/init-alii
source $ZSHD/init-completions

#
# ANTIGEN/Finish Up -- TODO: maybe init antigen just after opts? 
#
ANTIGEND=$ZSHD/antigenp
ANTIGEN=$ANTIGEND/antigen.zsh
ANTIGENRC=$ANTIGEND/init-antigen
ADOTDIR=$ANTIGEND
# export ANTIGEN_COMPDUMPFILE=$ANTIGEND/

printf "%s\n" "Sourcing $ANTIGEN"
time source $ANTIGEN

printf "%s\n" "Init $ANTIGENRC"
#antigen init $ANTIGENRC
source $ANTIGENRC
# END ANTIGEN
