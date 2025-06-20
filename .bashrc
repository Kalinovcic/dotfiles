# If not defined in global profile, define here.
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_CACHE_HOME"  ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_DATA_HOME"   ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME"  ] && export XDG_STATE_HOME="$HOME/.local/state"
[ -z "$GNUPGHOME"       ] && export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# Add "$HOME/bin" to PATH
[ -d "$HOME/bin" ] &&
  export PATH="$HOME/bin:$PATH"

# Add "$XDG_DATA_HOME/git-extensions" to PATH
[ -d "$XDG_DATA_HOME/git-extensions" ] &&
  export PATH="$XDG_DATA_HOME/git-extensions:$PATH"

# Add cuda to PATH
[ -d /usr/local/cuda-12.6/bin ] &&
  export PATH="/usr/local/cuda-12.6/bin:$PATH"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

[ -z "$BASH_VERSION" ] && return              # Stop here if we're not bash
[[ $- != *i* ]]        && return              # Stop here if we're not interactive

# Set shell options
HISTSIZE=                                     # Store unlimited command history...
HISTFILESIZE=                                 # ...
HISTTIMEFORMAT="[%F %T] "                     # Prefix history with timestamps
HISTCONTROL=ignoreboth                        # Ignore duplicate lines and lines starting with space
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"  # Write history on each prompt (default is on session exit)
HISTFILE="${XDG_STATE_HOME}/bash/history"     # Store history out of home
mkdir -p $(dirname $HISTFILE)
shopt -s histappend                           # Append to history (default is overwriting)
shopt -s checkwinsize                         # Update LINES and COLUMNS after each prompt
shopt -s globstar                             # Allow ** matching subdirectories like in glob
shopt -s autocd                               # Enable changing directories by only typing the directory name

# Enable autocompletion
[ -f /usr/share/bash-completion/bash_completion ] &&
  source /usr/share/bash-completion/bash_completion

# Aesthetics
PS1="\n\[\e[90m\]\w\n\$ \[\e[0m\]"

[ -x /usr/bin/dircolors ] && eval "$(dircolors -b)"
alias ls="ls --color=auto"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Move configuration and session files out of the home directory
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
mkdir -p $(dirname $XINITRC)

export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
mkdir -p $(dirname $PYTHONSTARTUP)

export TMUX_TEMPDIR=$XDG_RUNTIME_DIR/tmux
mkdir -p $TMUX_TEMPDIR
alias tmux="tmux -f $TMUX_TEMPDIR/tmux.conf"

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
alias adb='HOME="$XDG_DATA_HOME/android" adb'

# Aliases
alias l="ls -lAh"
