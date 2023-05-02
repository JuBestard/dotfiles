# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# Simples aliases
alias gp="git push"
alias gpl="git pull"
alias gst="git status"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gd="git diff"
alias vpn="sudo openvpn --config ~/.config/openvpn/vpn-fr.ovpn"
#alias clean="make clean"
#alias make="make clean && make"
# Parametrized Aliases
add_commit()
{
    git add $1 && git commit -m $2
}


#. /home/julienb/apps/z/z.sh
source /home/julienb/apps/zsh-z/zsh-z.plugin.zsh
zstyle ':completion:*' menu select

# opam configuration
[[ ! -r /home/julienb/.opam/opam-init/init.zsh ]] || source /home/julienb/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

path+=/home/julienb/.cargo/bin
export PATH
