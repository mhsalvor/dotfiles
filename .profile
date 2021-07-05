#
#                       __ _ _
#                      / _(_) |
#      _ __  _ __ ___ | |_ _| | ___
#     | '_ \| '__/ _ \|  _| | |/ _ \
#    _| |_) | | | (_) | | | | |  __/
#   (_) .__/|_|  \___/|_| |_|_|\___|
#     | |
#     |_|
#
#   ~/.profile
#   This files runs once at login.
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

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

#=== Locales ===#

export LANG=it_IT.UTF-8
export LANGUAGE=it_IT.UTF-8:en_US-UTF-8
export LC_ALL=it_IT.UTF-8
export GROFF_ENCODING=utf8

#=== Path ===#

# Adds ~/.local/bin and all the subdirectories to $PATH
#[[ -d "$HOME/.local/bin" ]] && PATH="$PATH:$(du "$HOME/.local/bin/" |cut -f2 | tr '\n' ':' | sed 's/:*$//')"
PATH="${PATH}:$HOME/.local/bin"
#export PATH="$PATH"
# remove duplicate path entries
export PATH=$(echo $PATH | awk -F: '{ for (i = 1; i <= NF; i++) arr[$i]; } END { for (i in arr) printf "%s:" , i; printf "\n"; } ')

#--- XDG
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}
export XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS:="/usr/etc/xdg:/etc/xdg"}

#--- Config files : keep $HOME clean!
# Aspell
export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf;\
    personal $XDG_CONFIG_HOME/aspell/en.pws;\
    repl $XDG_CONFIG_HOME/aspell/en.prepl"
# Bash Completion
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion
# Ruby#Bundler
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
# Ruby#RubyGems
### make sure to remove "--unsr-isntall" from /etc/gemrc
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
# Rust#Cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo
# Ryst#Rustup
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
# Conky
#alias conky='conky --config="$XDG_CONFIG_HOME"/conky/conkyrc'
# dircolors
export MY_DIRCOLORS="${XDG_CONFIG_HOME}/dir_colors"
eval $(dircolors $MY_DIRCOLORS)
# Go
export GOPATH="$XDG_DATA_HOME"/go
# GTK 1
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
# GTK 2
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
# npmrc
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# nvidia-settings
alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'
# nvm
export NVM_DIR="$XDG_DATA_HOME"/nvm
# pass
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
# readline
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
# TeX Live
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
# urxvtd
export RXVT_SOCKET="$XDG_RUNTIME_DIR"/urxvtd
# Wine
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
# nvim -- thist helps with "sudo -e"
export MYVIMRC="$HOME/.config/nvim/init.vim"
# svn
alias svn='svn --config-dir "$XDG_CONFIG_HOME"/subversion'
# Weechat
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
# WIP - TODO
# export SUDO_ASKPASS="$HOME/.local/bin/tools/dmenupass"

#=== Preferred Applications ===#

export CODEEDITOR="/usr/bin/vscodium"
export BROWSER="/usr/bin/firefox"   # fix fpr "xdg-open fork-bomb"
export PBROWSER="/usr/bin/firefox --private-window"
export EDITOR="/usr/bin/nvim"
export VISUAL="$EDITOR"
export FILEGUI="/usr/bin/pcmanfm"
export FILE="/usr/bin/ranger"
export TERMINAL="/usr/bin/alacritty"
export CALENDAR="/usr/bin/calcurse"
export MAILER="/usr/bin/neomutt"
export PAGER="/usr/bin/less"        # I may switch to most
export READER="/usr/bin/zathura"
export GIT_EDITOR="nvim"
export GIT_PAGER=less

#=== App specific settings ===#

export DOTNET_CLI_TELEMETRY_OPTOUT=1    # Disable .NET telemetry
export TERM="xterm-256color"            # This is needed for colors to work in alacritty
export COLORTERM="truecolor"            # tells neovim what color settings to use
#export RANGER_LOAD_DEFAULT_RC=FALSE
export QT_QPA_PLATFORMTHEME="qt5ct"     # qt5 theme toolkit
#--- Improve the awful Java Gui
export JAVA_FONTS="/usr/share/fonts/TTF"
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd_hrgb"
#--- Add colors to the less and man commands. TODO
export LESSHISTFILE='-'    # remove less history
export LESS="-R"
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"      # begin blink
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"      # begin bold
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"         # reset bold/blink
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"  # begin reverse video
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"         # reset reverse video
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"      # begin underline
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"         # reset underline

#=== Compiler Options ===#

export njobs=$(getconf _NPROCESSORS_ONLN)   # Compile using as many parallel jobs as possible
export NUMJOBS="-j$njobs"
export MAKEFLAG="$NUMJOBS"


###---= Final cleaning =---###

unset TERMCAP # Termcap is outdated, old, and crusty, kill it.
unset MANPATH # Man is much better than us at figuring this out

#=== Configure Interactive shells ===#
[[ -f ~/.bashrc ]] && source ~/.bashrc  # Source user bash config


####
# EXPERIMENTAL
###
# [ ! -f ~/.config/shortcutrc ] && shortcuts >/dev/null 2>&1
# Switch escape and caps if tty:
# sudo -n loadkeys ~/.local/bin/ttymaps.kmap 2>/dev/null

###EOF### vim: ft=bash
