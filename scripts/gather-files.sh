#!/usr/bin/zsh
# mode: zsh; 
# script to gather all files from the file list (./list or supplied with --list=) and
# move them to $repo/hosts/$HOSTNAME/ for processing
DEBUG=1
printf "%b\n" ${DEBUG+
"Entering Script
Script:$PWD/$0
ARGC:$#
ARGV:\n${*[@]}
UID:$UID
EUID:$EUID
HOST:$HOST"}

# (A)ll: archive AND generate output files
# (c)opy only: just copy modified host files to the store
# (g)enerate only: just generate files from those already in the store
# (R)irectory=REPO_DIR: the repo 
# (S)tore=PLATFORM_DIR: platform store 
# (L)istfile=LIST_FILE: the file containing the list of files to sync (relative to repo)
while getopts "AcgR:S:L:h" opt $@; do 
    case $opt in
	A);;	
	c);;
	g);;
	R)if [[ -d $OPTARG ]]; then
	      repo=${OPTARG}
	  else
	      err_not-found $OPTARG
	  fi
	  ;;
	S)if [[ -d $OPTARG ]]; then
	      platform_store=${OPTARG};
	  else
	      err_not-found $OPTARG
	      exit 1
	  fi
	  ;;
	L)if [[ -e $OPTARG ]]; then
	      listfile=${OPTARG};
	  else
	      err_not-found $OPTARG
	      exit 1
	  fi
	  ;;
	h) display_help && exit 0;;
	\?) printf " Error: %s is not a valid option!\n" $opt
	    display_help
	    exit 1
	  ;;
    esac;    
done

# Set vars (${name=word} sets name to word if unset. if they were set above, unaffected)
# assumes $repo=pwd and that $repo/scripts and $repo/scripts/list exist unless provided
${repo=$(pwd)}
${platform=$(uname)}
${platform_files=${repo}/platforms/${platform}/}
${host=$(uname -n)}
${host_store=${repo}/hosts/${host}/} 
${listfile=${repo}/scripts/list} # this lists the files we are paying attention too. In the future maybe use git versioning integration and sub-repos (theres a plugin)

# get all files from list and add to $files
# files=${(@f)$(cat $LISTFILE)} # each line contains a filename (abs or variables, no relative paths accepted

#for file of $files[@]; do
 
#done

###
# 
# Functions
#


##
# Utility Functions

function err_not-found () {
    printf "Error: %s cannot be found. \n" $1
}

# the help string!
gather_HELP="This script gathers the files listed under some script, and stores them for processing by its sibling scripts merge_files and deploy_files.\n\n
It takes a few options:
   (A)ll OR (g)enerate only OR (c)opy only (NOT IMPLEMENTED)
   R (repo-dir): sets \$repo to \$repo-dir
   S (store-dir): sets \$store to \$store-dir
   L (list-file): sets \$listfile to \$list-file
   h: this help

Have a nice day."

function display_help () {
    printf "\n" $gather_HELP
}
