#!/usr/bin/env bash
# vim: ft=bash
#           _       _ _
#          (_)     (_) |
#     __  ___ _ __  _| |_ _ __ ___
#     \ \/ / | '_ \| | __| '__/ __|
#    _ >  <| | | | | | |_| | | (__
#   (_)_/\_\_|_| |_|_|\__|_|  \___|
#
#   ~/.xinitrc
#   Executed by startx (run your window manager from here)
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

#=== Source .xprofile ===#

[[ -f "$HOME/.xprofile" ]] && . "$HOME/.xprofile"

#=== Set the right options ===#
DEFAULT_SESSION='i3 --shmlog-size 0'

get_session(){
    local dbus_args=(--sh-syntax --exit-with-session)
    case $1 in
        awesome) dbus_args+=(awesome) ;;
        bspwm) dbus_args+=(bspwm-session) ;;
        budgie) dbus_args+=(budgie-desktop) ;;
        cinnamon) dbus_args+=(cinnamon-session) ;;
        deepin) dbus_args+=(startdde) ;;
        enlightenment) dbus_args+=(enlightenment_start) ;;
        fluxbox) dbus_args+=(startfluxbox) ;;
        gnome) dbus_args+=(gnome-session) ;;
        i3|i3wm) dbus_args+=(i3 --shmlog-size 0) ;;
        jwm) dbus_args+=(jwm) ;;
        kde) dbus_args+=(startplasma-x11) ;;
        lxde) dbus_args+=(startlxde) ;;
        lxqt) dbus_args+=(lxqt-session) ;;
        mate) dbus_args+=(mate-session) ;;
        xfce) dbus_args+=(xfce4-session) ;;
        openbox) dbus_args+=(openbox-session) ;;
        *) dbus_args+=($DEFAULT_SESSION) ;;
    esac
    echo "dbus-launch ${dbus_args[*]}"
}

#=== Start a few things  ===#

# Polkit authentication
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

#=== Start Session ===#
exec $(get_session "$1")

###EOF###
