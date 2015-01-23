autoload -U colors && colors
autoload -U compinit && compinit

. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
    z --add "$(pwd -P)"
}

alias v='vagrant'
alias r='rails'
alias ls='ls -G'
 
setopt auto_cd
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%b|%F{1}%a '
zstyle ':vcs_info:*' formats       \
    '%b '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}on%{$reset_color%} ${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}

# Postgres.app preference
export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

export RPROMPT=''

export PROMPT="
%~
$fg[cyan]☁ $reset_color > "

export PROMPT="
%~
☁️  $fg[cyan]>$reset_color "

export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"

fpath=(/usr/local/share/zsh-completions $fpath)
