  export EDITOR=vim
  export BROWSER=links2
  export PAGER=less
  export LESS=aCeiM
  export SHELL=/bin/zsh
  DIRSTACKSIZE=30
  REPORTTIME=5
  HISTSIZE=2000
  SAVEHIST=2000
  HISTFILE=~/.zshhistfile
export TERM=xterexport TERM=xtermm
  export LS_COLORS='no=0:fi=0:di=32:ln=36:or=1;40:mi=1;40:pi=31:so=33:bd=44;37:cd=44;37:ex=35:*.jpg=1;32:*.jpeg=1;32:*.JPG=1;32:*.gif=1;32:*.png=1;32:*.jpeg=1;32:*.ppm=1;32:*.pgm=1;32:*.pbm=1;32:*.c=1;33:*.C=1;33:*.h=1;33:*.cc=1;33:*.awk=1;33:*.pl=1;33:*.bz2=1;35:*.gz=1;31:*.tar=1;31:*.zip=1;31:*.lha=1;31:*.lzh=1;31:*.arj=1;31:*.tgz=1;31:*.taz=1;31:*.html=1;34:*.htm=1;34:*.doc=1;34:*.txt=1;34:*.o=1;36:*.a=1;36:*.php3=1;31'
  export PS1="%n@%m:%~%# "

  if [ -e "$HOME/bin" ]; then
	  export PATH="$PATH:$HOME/bin/"
  fi

setopt \
NO_all_export \
   always_last_prompt \
   always_to_end \
   append_history \
   auto_cd \
   auto_list \
   auto_menu \
NO_auto_name_dirs \
   auto_param_keys \
   auto_param_slash \
   auto_pushd \
   auto_remove_slash \
NO_auto_resume \
   bad_pattern \
   bang_hist \
NO_beep \
   brace_ccl \
   correct_all \
NO_bsd_echo \
   cdable_vars \
NO_chase_links \
NO_clobber \
   complete_aliases \
   complete_in_word \
   correct \
   correct_all \
   csh_junkie_history \
NO_csh_junkie_loops \
NO_csh_junkie_quotes \
NO_csh_null_glob \
NO_dvorak \
   equals \
   extended_glob \
   extended_history \
   function_argzero \
   glob \
NO_glob_assign \
   glob_complete \
   glob_dots \
   glob_subst \
   hash_cmds \
   hash_dirs \
   hash_list_all \
   hist_allow_clobber \
   hist_beep \
   hist_ignore_dups \
   hist_ignore_space \
NO_hist_no_store \
NO_hist_save_no_dups \
   hist_verify \
NO_hup \
NO_ignore_braces \
NO_ignore_eof \
   interactive_comments \
NO_list_ambiguous \
NO_list_beep \
   list_types \
   long_list_jobs \
   magic_equal_subst \
NO_mail_warning \
NO_mark_dirs \
NO_menu_complete \
   multios \
NO_nomatch \
   notify \
NO_null_glob \
   numeric_glob_sort \
NO_overstrike \
   path_dirs \
   posix_builtins \
NO_print_exit_value \
NO_prompt_cr \
   prompt_subst \
   pushd_ignore_dups \
NO_pushd_minus \
NO_pushd_silent \
   pushd_to_home \
   rc_expand_param \
NO_rc_quotes \
NO_rm_star_silent \
NO_sh_file_expansion \
   sh_option_letters \
   short_loops \
NO_sh_word_split \
NO_single_line_zle \
NO_sun_keyboard_hack \
   unset \
NO_verbose \
NO_xtrace \
   zle

  alias a=alias
  alias ua=unalias

  alias  1='fg %1'
  alias  2='fg %2'
  alias  3='fg %3'
  alias  4='fg %4'
  alias  5='fg %5'
  alias  6='fg %6'

  alias 11='bg %1'
  alias 22='bg %2'
  alias 33='bg %3'
  alias 44='bg %4'
  alias 55='bg %5'
  alias 66='bg %6'

  alias  j='jobs -l'
  alias px='ps aufx'

  alias    ..='cd ..'
  alias   ...='cd ../..'
  alias  ....='cd ../../..'
  alias .....='cd ../../../..'
  alias d='dirs -v'

  alias -g G='| grep'
  alias -g L='| less'
  alias -g V='| vim -'
  alias -g H='| head'
  alias -g T='| tail'
  alias -g S='| sort'
  alias -g P='|'

  alias ls='ls --color=auto'
  alias la='ls -a'
  alias ll='ls -lA'
  alias lsd='ls -d'
  alias p='python'
  alias   S='screen'
  alias  sr='screen -r'
  alias sls='screen -ls'
  alias  sx='screen -x'

  alias grep='grep --color=auto'

  alias md='mkdir -p' # make parent, no errors

  alias  __='$EDITOR ~/.zshrc'
  alias ___='source  ~/.zshrc'

  alias ifconfig='nocorrect ifconfig'
  alias iwconfig='nocorrect iwconfig'
  alias iwlist='nocorrect iwlist'
  alias iwpriv='nocorrect iwpriv'
  alias tmux='tmux -u a || tmux -u'
autoload -U tetris
zle -N tetris
bindkey "^Xt" tetris # C-x t zum Spielen
  #autoload -U compinit ; compinit 
  zmodload -i zsh/complist

  compile=(install clean remove uninstall deinstall)
  compctl -k compile make

  compctl -g '*(-/)' + -g '.*(/)' cd chdir dirs pushd rmdir dircmp cl
  compctl -g '*.(gz|z|Z|t[agp]z|tarZ|tz)' + -g '*(-/)' gunzip gzcat zcat
  compctl -g "*.html *.htm" + -g "*(-/) .*(-/)" + -H 0 '' curl w3m lynx elinks wget opera EL O
  compctl -g '*.ps' + -g '*(-/)' lp gv

  zstyle ':completion:*:correct:*' original true
  zstyle ':completion:*:correct:*' insert-unambiguous true # RTFM :P

  zstyle ':completion:*' completer _complete _correct _approximate
  zstyle ':completion:*' glob true

  zstyle ':completion:*' verbose yes
  zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
  zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
  zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
  zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
  zstyle ':completion:*' group-name ''
  zstyle -e ':completion:*:approximate:*' max-errors \
      'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

  zstyle ':completion:*' list-colors ''
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

  zstyle ':completion:*' menu yes=long-list
  zstyle ':completion:*' menu select=2

  zstyle ':completion:*:ssh:*' group-order 'users' 'hosts'
  zstyle ':completion:*:*:rm:*' file-patterns '(*~|\\#*\\#):backup-files' \
    '*.zwc:zsh\ bytecompiled\ files' 'core(|.*):core\ files' '*:all-files'
  zstyle ':completion:*:kill:*' command 'ps xf -u $USER -o pid,%cpu,tty,cputime,cmd'
  zstyle ':completion:*:kill:*' insert-ids single
  zstyle ':completion:*:*:kill:*' menu yes select
  zstyle ':completion:*:kill:*' force-list always
  zstyle ':completion:*:*:less:*' menu yes select
  zstyle ':completion:*:*:mutt:*' menu yes select

# ---[ Terminal settings ]---------------------------------------------
  bindkey '\e[1~' beginning-of-line	# Home
  bindkey '\e[2~' overwrite-mode	# Insert
  bindkey '\e[3~' delete-char		# Del
  bindkey '\e[4~' end-of-line		# End
  bindkey '\e[5~' beginning-of-history  # pg-up
  bindkey '\e[6~' end-of-history	# pg-down
  bindkey '\e[7~' beginning-of-line	# home
  bindkey '\e[8~' end-of-line		# end
  bindkey '\e[5C' backward-word
  bindkey '\e[5D' forward-word

  #xterm specific
  bindkey '\e[H' beginning-of-line
  bindkey '\e[F' end-of-line
  bindkey '\e\e[C' forward-word
  bindkey '\e\e[D' backward-word


  #guake stuff
  bindkey 'OH' beginning-of-line
  bindkey 'OF' end-of-line
  bindkey '[1;5C' forward-word
  bindkey '[1;5D' backward-word

  #type only dirname to cd into it :)
  compctl -/ cd
  # prompt
  autoload -U colors
  colors
 
  function _colorize_prompt {
    PROMPT="%{%(?.$fg[green].$fg[red])%}%n@%m $reset_color$fg[yellow]%~%{$reset_color%}
%# "
  }
  _colorize_prompt
 
  # auto commands
  typeset -ga chpwd_functions
  typeset -ga precmd_functions
  typeset -ga preexec_functions
 
  # set directory name to screen
  function _screen_dirname() {
    if [ $WINDOW ]; then
        echo -ne "\ek$(basename "`pwd`")\e\\"
    fi
  }
 
  # set command name to screen
  function _screen_cmdname() {
    if [ $WINDOW ]; then
        echo -ne "\ek# $1\e\\"
    fi
  }
 
  # display current SCM in RPROMPT
  function _rprompt() {
    # git
    local -A git_res
    git_res=`git branch -a --no-color 2> /dev/null`
    if [ $? = "0" ]; then
        git_res=`echo $git_res | grep '^*' | tr -d '\* '`
        RPROMPT="%{$fg[cyan]%}git [$git_res]%{$reset_color%}"
        return
    fi
 
    # hg
    local -A hg_res
    hg_res=`hg branch 2> /dev/null`
    if [ $? = "0" ]; then
        RPROMPT="%{$fg[cyan]%}hg [$hg_res]%{$reset_color%}"
        return
    fi
 
    # svn
    if [ -d .svn ]; then
        RPROMPT="%{$fg[cyan]%}svn%{$reset_color%}"
        return
    fi
 
    # none
    RPROMPT=""
  }
 
  #fix sshfs
  #compdef sshfs=scp

export TERM=xterm
  #append functions to methods
  precmd_functions+=_colorize_prompt
  precmd_functions+=_rprompt
  precmd_functions+=_screen_dirname
  preexec_functions+=_screen_cmdname
  #should watch logins -> needs testing
  watch=(notme root)
  #load user settings :)
  if [ -e ~/.zshrc.local ]; then
    source ~/.zshrc.local
  fi
  if [ -d /etc/profile.d ]; then
  for file in /etc/profile.d/*.sh; do
	  source "$file"
  done

  fi

cd
