#
#      _               _                          __ _ _
#     | |             | |                        / _(_) |
#     | |__   __ _ ___| |__      _ __  _ __ ___ | |_ _| | ___
#     | '_ \ / _` / __| '_ \    | '_ \| '__/ _ \|  _| | |/ _ \
#    _| |_) | (_| \__ \ | | |   | |_) | | | (_) | | | | |  __/
#   (_)_.__/ \__,_|___/_| |_|   | .__/|_|  \___/|_| |_|_|\___|
#                         ______| |
#                        |______|_|
#   ~/.bash_profile
#   Used by interactive login shells, or non interactive with --login;
#       Order: /etc/profile, ~/.bash_profile, ~/.bash_login, ~/.profile
#       the first one found will be executed.
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
[[ -f ~/.profile ]] && . ~/.profile

# I let .profile call .bashrc
#[[ -f ~/.bashrc ]] && . ~/.bashrc

#https://stackoverflow.com/questions/9953005/should-the-bashrc-in-the-home-directory-load-automatically/9954208#9954208
#
                     # +-----------------+   +------FIRST-------+   +-----------------+
                     # |                 |   | ~/.bash_profile  |   |                 |
# login shell -------->|  /etc/profile   |-->| ~/.bash_login ------>|  ~/.bashrc      |
                     # |                 |   | ~/.profile       |   |                 |
                     # +-----------------+   +------------------+   +-----------------+
                     # +-----------------+   +-----------------+
                     # |                 |   |                 |
# interactive shell -->|  ~/.bashrc -------->| /etc/bashrc     |
                     # |                 |   |                 |
                     # +-----------------+   +-----------------+
                     # +-----------------+
                     # |                 |
# logout shell ------->|  ~/.bash_logout |
                     # |                 |
                     # +-----------------+

# [] ----> [] source by workflow (automatically)
# [ ----> [] source by convention (manually. Ignored otherwise
# FIRST : find the first available, ignore the rest

###EOF### vim: ft=bash
