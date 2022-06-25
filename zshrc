# Enable Powerlevel13# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

zinit depth=1 lucid nocd for romkatv/powerlevel10k

zinit ice pick"init.sh"; zinit light b4b4r07/enhancd

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load git and debian
zinit wait lucid for \
    OMZP::git \
    OMZP::debian

# Load the docker plugin only if docker is available
if command -v docker > /dev/null ; then
    zinit ice as"completion"
    zinit snippet OMZP::docker/_docker
fi

# Load the tmux plugin only if tmux is available
command -v tmux > /dev/null && zinit snippet OMZP::tmux

zplg load $HOME/zshros

# Convenient bash settings pulled from bashrc
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# End of settings pulled from bashrc

# One command to clear the screen for less cognitive load working with WSL
alias cls='clear'

if [ -d "$HOME/anaconda3" ] ; then
    CONDA_ROOT="$HOME/anaconda3"
elif [ -f "$HOME/minconda3" ] ; then
    CONDA_ROOT="$HOME/miniconda3"
fi
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($CONDA_ROOT/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$CONDA_ROOT/etc/profile.d/conda.sh" ]; then
        . "$CONDA_ROOT/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_ROOT/bin:$PATH"
    fi
fi

unset __conda_setup
# <<< conda initialize <<<

case "$(command -v lsb_release > /dev/null && lsb_release -sc)" in
    *"bionic"* )
        ROSSOURCE="/opt/ros/melodic/setup.zsh"
        ;;
    *"focal"* )
        ROSSOURCE="/opt/ros/noetic/setup.zsh"
        ;;
    * )
        ;;
esac
[[ ! -f $ROSSOURCE ]] || source $ROSSOURCE

for CATKINSOURCE in "$HOME/catkin_ws/install/local_setup.zsh" \
    "$HOME/catkin_ws/devel/setup.zsh" \
    "$HOME/dev_ws/install/local_setup.zsh" ; do
    if [[ -f $CATKINSOURCE ]] ; then
        source $CATKINSOURCE
        break
    fi
done

command -v colcon > /dev/null && source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh

if [ ! -z ${VCPKG_ROOT+x} ] ; then
    source $VCPKG_ROOT/scripts/vcpkg_completion.zsh
fi

if [ ! -z ${PX4_ROOT+x} ] ; then
    typeset -T ROS_PACKAGE_PATH ros_package_path :
    ros_package_path+=("$ROS_PACKAGE_PATH" "$PX4_ROOT" "$PX4_ROOT/Tools/sitl_gazebo")
    source $PX4_ROOT/Tools/setup_gazebo.bash $PX4_ROOT $PX4_ROOT/build/px4_sitl_default > /dev/null 2>&1
fi

alias gzkill="killall gzserver gzclient"

if which QGroundControl > /dev/null ; then
    alias QGroundControl='QGroundControl > /dev/null 2>&1 &'
fi

extract () {
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf "$1" ;;
            *.tar.gz)    tar xvzf "$1" ;;
            *.tar.xz)    tar xvJf "$1" ;;
            *.bz2)       bunzip2 "$1" ;;
            *.rar)       unrar x "$1" ;;
            *.gz)        gunzip "$1" ;;
            *.tar)       tar xvf "$1" ;;
            *.tbz2)      tar xvjf "$1" ;;
            *.tgz)       tar xvzf "$1" ;;
            *.zip)       unzip "$1" ;;
            *.jar)       unzip "$1" ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1" ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
