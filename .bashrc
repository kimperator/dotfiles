#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

export EDITOR="vim"
export TERMINAL="lxterm"
export BROWSER="links"
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export JAVA_FONTS=/usr/share/fonts/TTF
export TERM=screen-256color
export MAIL=~/.mail/


if [ "$(uname -s)" == "Darwin" ]; then
    # Do something under OS X platform
    export PATH="/usr/local/bin:$PATH:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin"
    alias rm='rm -i'
    alias octave='PATH=/usr/local/octave/3.8.0/bin:/usr/local/octave/3.8.0/sbin:${PATH}  octave'
    # set up homebrew cask for global install
    export HOMEBREW_CASK_OPTS="--appdir=/Applications --prefpanedir=/Library/PreferencePanes --qlplugindir=/Library/QuickLook --fontdir=/Library/Fonts --input_methoddir=/Library/Input\ Methods --screen_saverdir=/Library/Screen\ Savers"
    alias vim='vi'


elif [ "$(uname -s)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    alias ls='ls --color=auto'
    alias rm='rm -I'

    # bug fixed in coreutils - no longer needed for termite!
    # eval $(dircolors ~/.dircolors.ansi-dark)

    # simple stopwatch function
    function stopwatch(){ local tempdate=`date +%s`; while true; do echo -ne "$(date -u --date @$((`date +%s` - $tempdate)) +'   %H:%M:%S')\r"; sleep 0.2; done };
fi



export HISTFILESIZE=5000
export HISTSIZE=5000
export HISTTIMEFORMAT="[%F %T] "
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
# fixed according to https://savannah.gnu.org/patch/index.php?8676#history
# PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export HISTCONTROL=ignoreboth
shopt -s histappend

alias tgz='tar -pczf'
alias grep='grep --color=always'
function mkcd () {
	  mkdir -p "$1"
	    cd "$1"
    }

[[ -f ~/.bashrc_local ]] && . ~/.bashrc_local


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
