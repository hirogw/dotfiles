# ロケールの設定
export LANG=ja_JP.UTF-8

# パスの設定
BIN_PATH=~/.dotfiles/bin
[ -d $BIN_PATH ] && export PATH=$PATH:$BIN_PATH

zstyle ':completion:*:*:git:*' script ~/.dotfiles/bin/git-completion.sh
zstyle ':completion:*' matcher-list '' 'r:|[-_.]=**'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%U%F{red}%d%f%u%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# rbenvの設定
export RBENV_ROOT=$HOME/.rbenv
if [ -d $RBENV_ROOT ]; then
    export PATH=$RBENV_ROOT/bin:$PATH
    eval "$(rbenv init -)"
fi

# プロンプトの設定
autoload colors
colors
PROMPT="%{${fg[blue]}%}[%n@%m] %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[blue]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"

# VCSのブランチ名を右プロンプトに表示
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# C-wでパス区切り削除(元のWORDCHARSから/を抜いた)
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# 補完機能
autoload -U compinit
compinit

# コマンド履歴(100000件保持)
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# コマンド履歴の検索(C-pとC-n)
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# setopt関連
setopt hist_ignore_dups # 重複したコマンド履歴を無視する
setopt share_history    # コマンド履歴をターミナル毎に共有
setopt auto_pushd       # 移動したディレクトリを記録
setopt list_packed      # 補完候補を詰めて表示
setopt nolistbeep       # ビープ音を消す

# alias関連
alias g="git"
alias r="rails"
alias be="bundle exec"
[ `uname` = "Darwin" ] && alias tmux="tmux_wrapper_for_mac.sh"

# autojump読み込み
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

# マシン固有の設定があれば読み込む
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
