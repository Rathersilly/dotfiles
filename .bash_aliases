# ~/.bash_aliases - sourced by ~/.bashrc

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -pv'
alias h='history'
alias j='jobs -l'
alias rm='rm -I --preserve-root'
alias ff='firefox'
alias chrome='google-chrome'

alias vi=nvim
alias vis='nvim -S'

alias py=python3
alias dr='dragonruby .'lias definitions.
alias untar='tar -zxvf '
alias ppath='tr ":" "\n" <<< "$PATH"' # pretty print path variable
#
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# alias rails='bin/rails'
alias rs='rails server'
alias rc='rails console'
alias rcs='rails console --sandbox'
alias rt='rails test'
alias rti='rails test:integration'
alias bx='bundle exec'
alias be='bundle exec'
alias ber='bundle exec ruby'
alias bxs='bundle exec bin/rails server'
alias bxc='bundle exec bin/rails console'

# alias gac="git add -A && git commit -m \'$1\'" check the interpolation here
alias ga='git add -A'
alias gcm='git commit -m'
alias glo="git log --oneline"
alias gs="git status"

# type g instead of git. typing just g runs git status
g() {
	if [[ $# -gt 0 ]]; then # $# is number of positional parameters eg "git a b c" has 3
		git "$@"               # $@ is array of positional parameters
	else
		git status
	fi
}

# entering a symlinked directory takes you to the proper file path
# https://superuser.com/questions/1312196/linux-symbolic-links-how-to-go-to-the-pointed-to-directory
function cdl {
	local dir=$(readlink -e $1)
	[[ -n "$dir" ]] && cd $dir
}

function mcd() {
	mkdir -p "$1" && cd "$1"
}
