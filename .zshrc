#
# Example .zshrc file for zsh 4.0
#
# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

# THIS FILE IS NOT INTENDED TO BE USED AS /etc/zshrc, NOR WITHOUT EDITING
#return 0	# Remove this line after editing this file as appropriate

# Search path for the cd command
#cdpath=(.. ~ /etc /mnt ~/.config )

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s
#ulimit -m 786432
#ulimit -v 1572864 

umask 022

#eval `dircolors -b`

#########################################################################################
# Set up aliases
#########################################################################################

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias e=' exit'
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias rm='nocorrect rm' # no spelling correction on rm
alias j=jobs
alias pu=' pushd'
alias po=' popd'
alias d=' dirs -v'
alias h=history
alias grep=egrep
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
#alias tvbrowser='wmname LG3D && tvbrowser'
alias jdownloader='wmname LG3D && jdownloader'
#alias magicdraw='wmname LG3D && magicdraw'

# List only directories and symbolic
# links that point to directories
alias lsd='ls -ld *(-/DN)'

# List only file beginning with "."
alias lsa='ls -ld .*'

alias dgit='git --git-dir=$HOME'

# User specials

#alias eclipse="/opt/eclipse/eclipse -vm $JAVA_HOME/bin/java -clean -vmargs -Xms256M -Xmx512M -XX:MaxPermSize=512M"
#alias firefox="firefox -P default"
alias sd='sudo'
alias mount='sudo mount'
alias umount='sudo umount'
alias scr='screen -S foo'
alias sdr='screen -dRR foo'
alias rboot='sudo /sbin/shutdown -r now'
alias sdown='sudo /sbin/shutdown -h now'
alias sx=' startx'
alias dfh='df -hT'
alias su='su -'

#alias mvn='mvn-3.0'

#alias mplayer='mplayer2'
#alias chrome='google-chrome --disk-cache-dir="/tmp"'
#alias chromium='chromium --disk-cache-dir="/tmp"'

# suffix aliases
alias -s pdf=evince
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$EDITOR
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s gz=tar -xzvf
alias -s bz2=tar -xjvf
alias -s java=$EDITOR
alias -s txt=$EDITOR

# Tomcat
alias tstart=${CATALINA_HOME}bin/startup.sh
alias tstop=${CATALINA_HOME}bin/shutdown.sh

#########################################################################################
# Global aliases -- These do not have to be
# at the beginning of the command line.
#########################################################################################

alias -g G='|grep'
alias -g H='|head'
alias -g L='|less'
alias -g M='|more'
alias -g T='|tail'

#########################################################################################
# Shell functions
#########################################################################################

setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done } 
# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc /usr/local/share/zsh/4.3.9/functions/Completion)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

#local _myhosts
#_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )

case $TERM in
	*rxvt*)
    	precmd () {{ print -Pn '\e]0;%n@%m: %~\a' } 2>/dev/null }
#	precmd() { [[ -t 0 && -w 0 ]] && print -Pn '\e]2;%~\a' }
	;;
	screen)
    	precmd () {print -Pn "\e]0;%n@%m: %~\a"}
	;;
esac

#compctl -K listMavenCompletions mvn

#########################################################################################
# Set/unset  shell options
#########################################################################################

#setopt   notify globdots correct pushdtohome cdablevars autolist
#setopt   correctall autocd recexact longlistjobs
#setopt   autoresume histignoredups pushdsilent noclobber
#setopt   autopushd pushdminus extendedglob rcquotes mailwarning
# Changing Directories
setopt autocd auto_pushd pushd_ignore_dups
# Expansion and Globbing
setopt extendedglob
# History
setopt inc_append_history extended_history hist_ignore_all_dups hist_ignore_space share_history
# Input/Output
setopt correct_all rm_star_wait  
unsetopt bgnice autoparamslash

#########################################################################################
# Autoload zsh modules
#########################################################################################

autoload -Uz promptinit zmv
promptinit; prompt user

#########################################################################################
# Autoload zsh modules when they are referenced
#########################################################################################

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

#########################################################################################
# Line Editor Extensions
#########################################################################################

#}

# If I am using vi keys, I want to know what mode I'm currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
#function zle-keymap-select {
#	VIMODE="${${KEYMAP/vicmd/ M:command}/(main|viins)/}"
#	zle reset-prompt
#}

#zle -N zle-keymap-select

#function zle-line-init zle-keymap-select {
#    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#    RPS2=$RPS1
#    zle reset-prompt
#}
#zle -N zle-line-init
#alias-space () {
#  local a="$LBUFFER[(w)-1]"
#  [[ -n $a ]] && LBUFFER[(w)-1]="${${aliases[$a]}:-$a}"
#  zle self-insert
#}
#zle -N alias-space
zle -N zle-keymap-select

zle -N arith-eval-echo
zle -N hex-2-dec

#########################################################################################
# key bindings
#########################################################################################

#bindkey -v               # vi key bindings
bindkey -e               # emacs key bindings
#bindkey -a vicmd
#bindkey -v viins

bindkey '^X^Z' universal-argument ' ' magic-space
bindkey '^X^A' vi-find-prev-char-skip
bindkey '^Xa' _expand_alias
bindkey '^Z' accept-and-hold
bindkey -s '\M-/' \\\\
bindkey -s '\M-=' \|

bindkey ' ' magic-space    # also do history expansion on space
#bindkey ' ' alias-space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

# for linux console and RH/Debian xterm
# allow the use of the Home/End keys
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[H' beginning-of-line
bindkey '\eOw' end-of-line

# mappings for "page up" and "page down" to step to the beginning/end 
# of the history
bindkey '\e[5~' history-search-backward
bindkey '\e[6~' history-search-forward

bindkey '\e[5^' history-incremental-search-backward
bindkey '\e[6^' history-incremental-search-forward

# allow the use of the Delete/Insert keys
bindkey '\e[3~' delete-char
bindkey '\e[2~' quoted-insert
# control + arrow with console
#bindkey '\eC' forward-word
#bindkey '\eD' backward-word
# control + arrow with urxvt
bindkey '\eOc' forward-word
bindkey '\eOd' backward-word
# allow the use of the Home/End keys (urxvt)
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line

# F10 for calculation widget
bindkey '^[[21~' arith-eval-echo
bindkey '^[[23~' hex-2-dec

bindkey '\eq' push-line

#########################################################################################
# Completion Styles
#########################################################################################

# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit; compinit
# farbige completion
zmodload -i zsh/complist

# zstyle 'completion:function:completer:command:argument:tag' property value[s]

# enable cache for the completions
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;42
zstyle ':completion:*' menu select

# list of completers to use
zstyle ':completion:*::::' completer _complete _match _approximate _expand_alias

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# SSH - Erst User, dann Host.
zstyle ':completion:*:ssh:*' group-order 'users' 'hosts'
zstyle ':completion:*:(ssh|scp):*:users' list-rows-first true


# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle ':completion:*:*:*' hosts $hosts
zstyle ':completion:*:*:*' users $users
#zstyle ':completion:*' hosts $_myhosts

zstyle ':completion:*:*:kill:*:jobs' verbose yes
zstyle ':completion:*:kill:*' force-list always

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# create new list of installed programms in $PATH
zstyle ':completion::complete:*' rehash true

zstyle ':completion:*:mvn:*' show-all-phases true

#   * To have a better presentation of completions:

zstyle ':completion:*:*:mvn:*:matches' group 'yes'
zstyle ':completion:*:*:mvn:*:options' description 'yes'
zstyle ':completion:*:*:mvn:*:options' auto-description '%d'
zstyle ':completion:*:*:mvn:*:descriptions' format $'\e[1m -- %d --\e[22m'
zstyle ':completion:*:*:mvn:*:messages' format $'\e[1m -- %d --\e[22m'
zstyle ':completion:*:*:mvn:*:warnings' format $'\e[1m -- No matches found --\e[22m'
