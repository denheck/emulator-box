#!/bin/bash

######## Helper Functions ########

function msg()
{
  echo -e "$1"
}

function download_file ()
{
  local link_to_file=$1
  local file=$2

  if [ ! -e $file ]; then
    msg "Could not find existing \"$file\", installing latest from \"$link_to_file\"..."
    wget $link_to_file -O $file
  fi
}

function extract ()
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
