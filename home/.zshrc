#----------------------------------------
## 基本設定
#----------------------------------------
#環境変数
export EDITOR=vim
export GIT_EDITOR=vim

#history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt correct
# Ctrl+R is incremental search like a bash.
 bindkey "^R" history-incremental-search-backward
 # do not use rm
 to_trash() {
     for file in $@
     do
         mv $file ~/.trash
     done
 }
 alias rm="to_trash" 
#----------------------------------------
## ディスプレイ
#----------------------------------------
#色を使用出来るようにする
autoload -Uz colors
colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

alias ls="ls -GF"
alias gls="gls --color"
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
#プロンプト
# 1行表示
#git表示
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
	psvar=()
	LANG=en_US.UTF-8 vcs_info
	[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"
#----------------------------------------
## 補完
#----------------------------------------
# 補完機能を有効にする
autoload -Uz compinit
compinit
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
     /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
#setu pcake command
PROTON_HOME=~/proton
PATH=${PATH}:${PROTON_HOME}/src/server/node_modules/coffee-script/bin
PATH=${PATH}:${PROTON_HOME}/src/server/node_modules/.bin
PATH=${PATH}:${HOME}/.nvm/v0.4.12/bin:~/bin
export PATH
export NODE_PATH=/usr/lib/nodejs
#----------------------------------------
## コマンド
#----------------------------------------
#戻る系
alias dc='cd ../'
alias ddc='cd ../../'
alias dddc='cd ../../../'
alias ddddc='cd ../../../../'
alias dddddc='cd ../../../../../'
#tmux
alias tmux='tmux -u'
#grep
alias grep='grep --color=auto'
alias gfind='find . -type -f | xargs grep'
#git
alias gs='git status'
alias ga='git add'
alias glog='git log --graph --pretty=oneline'
alias gc='git commit -v'
alias gch='git checkout'
#----------------------------------------
## vimモード
#--------------"--------------------------
function zle-line-init zle-keymap-select {
case $KEYMAP in
    vicmd)
        PROMPT="%{$fg[red]%}[%{$reset_color%}%n@%m/%{$fg_bold[red]%}NOR%{$reset_color%}%{$fg[red]%}]%#%{$reset_color%} %{${fg[yellow]}%}%~%{${reset_color}%}"
        ;;
    main|viins)
        PROMPT="%{$fg[red]%}[%{$reset_color%}%n@%m/%{$fg_bold[cyan]%}INS%{$reset_color%}%{$fg[red]%}]%#%{$reset_color%} %{${fg[yellow]}%}%~%{${reset_color}%} "
        ;;
esac
zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
