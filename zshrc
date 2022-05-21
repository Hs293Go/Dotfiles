# Enable Powerlevel12k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hs293go/.zshrc'

autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
# End of lines added by compinstall

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
zplugin ice depth=1; zplugin light romkatv/powerlevel10k

zinit wait'!0' light-mode for \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting

zinit ice pick"init.sh"; zinit light b4b4r07/enhancd

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit snippet OMZP::git
zinit snippet OMZP::tmux
zinit snippet OMZP::docker
zinit snippet OMZP::debian
zplg load $HOME/zshros

case $(lsb_release -sc) in
    *"bionic"* )
        source /opt/ros/melodic/setup.zsh
        ;;
    *"focal"* )
        source /opt/ros/noetic/setup.zsh
        ;;
    * )
        ;;
esac

if [ -d "$HOME/catkin_ws/install/local_setup.sh" ] ; then
    source $HOME/catkin_ws/install/local_setup.zsh
fi

if which colcon > /dev/null ; then
    source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
fi

if [ ! -z ${ARDUPILOT_ROOT+x} ] ; then
    path+=("$ARDUPILOT_ROOT/Tools/autotest")    
    source $ARDUPILOT_ROOT/Tools/completion/completion.zsh
fi

if [ ! -z ${VCPKG_ROOT+x} ] ; then
    source $VCPKG_ROOT/scripts/vcpkg_completion.zsh
fi

if [ ! -z ${PX4_ROOT+x} ] ; then
    typeset -T ROS_PACKAGE_PATH ros_package_path :
    ros_package_path+=("$ROS_PACKAGE_PATH" "$PX4_ROOT" "$PX4_ROOT/Tools/sitl_gazebo")
    source $PX4_ROOT/Tools/setup_gazebo.bash $PX4_ROOT $PX4_ROOT/build/px4_sitl_default > /dev/null 2>&1
fi

alias cls="clear"
alias gzkill="killall gzserver gzclient"
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

QGroundControl() {
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/hs293go/QtProjects/build-qgroundcontrol-Desktop_Qt_5_15_2_GCC_64bit-Debug/libs/airmap-platform-sdk/linux/Qt.5.15:/home/hs293go/Qt/5.15.2/gcc_64/lib
    ~/QtProjects/build-qgroundcontrol-Desktop_Qt_5_15_2_GCC_64bit-Debug/staging/QGroundControl > /dev/null 2>&1 &
}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hs293go/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/hs293go/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/hs293go/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/hs293go/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

