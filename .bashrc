# vim: ft=bash
#      _               _
#     | |             | |
#     | |__   __ _ ___| |__  _ __ ___
#     | '_ \ / _` / __| '_ \| '__/ __|
#    _| |_) | (_| \__ \ | | | | | (__
#   (_)_.__/ \__,_|___/_| |_|_|  \___|
#
#   ~/.bashrc
#   This file is sourced by all *interactive* bsah shells on startup,
#   including some apparently interactive shells such as scp and rcp
#   that can't tolerate any output, and is called by login ones via
#       ~/.bash_profile
#
# Wrtitten to work on *most* GNU/Linux distributions.
# Things not working or WIP are commented out. Unless I forgot.
# Much of what follows has been "stolen" from many places over the years and
# tweaked to suit my workflow and personal preferences; feel free to do the same.
#
# Remember, like with all of my work, I am only able to provide the following
# assurance(s):
# It is almost certainly going to work until it breaks; although I have to
# admit it may never work and that would be sad.
# When/if it does break, you may keep all of the pieces.
# If you find my materials helpful, both you & I will be happy, at least for a
# little while.
# My advice is worth every penny you paid for it!
#
# by:
# Giuseppe (mhsalvor) Molinaro
# g.molinaro@linuxmail.org
# https://githup.com/mhsalvor
###

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
 export SHELL

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

#=== Shell Options ==#

#-- set
set -o notify   # immediate background job termination notification
#--- bind
#-- Internal
shopt -s autocd # navigate directories without cd
shopt -s cdspell # autocorrect cd misplelling
shopt -s checkhash # look for commands in the hash table first, then PATH
shopt -s checkwinsize # Make sure display get updated when terminal window get resized
shopt -s cmdhist # save multi-line commands in history as a single line
shopt -s complete_fullquote # bash quotes ALL metaharacters in filenames and dir names
shopt -s dotglob # include .files in the expasion of *
shopt -s expand_aliases # exspand aliases in non iteractive (i.e. scripts) shells
shopt -s extglob # Turn on the extended pattern matching features
shopt -s extquote # $'string' / $"string" quoting within ${parameter} expansions in ""
shopt -s force_fignore # respect the FIGNORE shell variable during completion
shopt -s globasciiranges # ignore current locale collating sequence in range exp
shopt -s histappend # Enable history appending instead of overwriting.
shopt -s hostcomplete # attempt do complete hostnames
shopt -s interactive_comments # enable comments in interactive shells
shopt -s promptvars # prompt strings undergo paramater expansion/command substitution etc..
shopt -s sourcepath # the source (.) builtin uses PATH to find the argument
#-- History
export HISTSIZE=10000 # store 10000 commands in history buffer
export HISTFILESIZE=${HISTSIZE} # do the same for the history file
export HISTCONTROL=ignoreboth:erasedupes # ignorespace:ignoredupes; avoid duplicates in history
export HISTCONTROL=$HISTCONTROL # bug in shell
export HISTIGNORE="&:pwd:exit:clear"
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   " # Add a timestamp to each command
export SAVEHIST=1 # save history regardless of number of terminals
#-- Completion
complete -cf sudo       # enable <TAB> completion with sudo
complete -A alias       alias unalias
complete -A command     which
complete -A export      export printenv
complete -A hostname    ssh telnet ftp ncftp ping dig nmap
complete -A helptopic   help
complete -A job -P '%'  fg jobs
complete -A setopt      set
complete -A shopt       shopt
complete -A signal      kill killall
complete -A user        su userdel passwd
complete -A group       groupdel groupmod newgrp
complete -A directory   cd rmdir
complete -f -X '!*.@(gif|GIF|jpg|JPG|jpeg|JPEG|png|PNG|xcf)' gimp
complete -W "$(echo `cat ~/.bash_history | egrep '^ssh ' | sort | uniq | sed 's/^ssh //'`;)" ssh # autocomplete ssh commands
#-- Permissions
xhost +local:root > /dev/null 2>&1  # Allow root to make connections to the X server

#=== Checks ===#

# Use user defined colors if found
[[ -x /usr/bin/dircolors ]] && eval $(dircolors -b $HOME/.dir_colors) ||\
    eval $(dircolors -b)

# Use bash-completion if present
[[ -r /usr/share/bash-completion/bash_completion ]] && ! shopt -oq posix &&\
    source /usr/share/bash-completion/bash_completion

# same for git completion
[[ -s /usr/share/git/completion/git-completion.bash ]] &&\
    source /usr/share/git/completion/git-completion.bash

# make less more friendly for non-text input files. Lists files inside archives etc...
[[ -x /usr/bin/lesspipe.sh ]] && eval "$(SHELL=/bin/sh lesspipe.sh)"

# Change the window title of X terminals
case ${TERM} in
    xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
    screen*)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
        ;;
esac

#=== Prompt ===#

use_color=true

getExitStatus() {
    if [[ $? == 0 ]]; then
        echo -e "\e[01;32m"
    else
        echo -e "\e[01;33m"
    fi
}

# WIP -- TODO: add git branch/status indicator to PS1
#parseGitBranch() {
#    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
#}

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
    && type -P dircolors >/dev/null \
    && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
    # Enable colors.  Prefer ~/.dir_colors #64489
    if type -P dircolors >/dev/null ; then
        if [[ -f ~/.dir_colors ]] ; then
            eval $(dircolors -b ~/.dir_colors)
        elif [[ -f /etc/DIR_COLORS ]] ; then
            eval $(dircolors -b /etc/DIR_COLORS)
        fi
    fi

    if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[01;31m\][\u@\h\[\033[01;36m\] \W\[\033[01;31m\]]\[$(getExitStatus)\]\$\[\033[00m\] '
    else
        PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\[$(getExitStatus)\]\$\[\033[00m\] '
    fi

else
    if [[ ${EUID} == 0 ]] ; then
        # show root@ when we don't have colors
        PS1='\u@\h \W \$ '
    else
        PS1='\u@\h \w \$ '
    fi
fi

unset use_color safe_term match_lhs sh

#=== External files ===#

# load aliases
[[ -f "$HOME/.aliasrc" ]] && source "$HOME/.aliasrc"
# # lod functions
[[ -f "$HOME/.functions" ]] && source "$HOME/.functions"

##== Fun ===#

if [ -e "/usr/games/fortune" ]; then
    echo "Fortune: "
    /usr/games/fortune
    echo
fi

###EOF###
