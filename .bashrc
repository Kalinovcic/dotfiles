# Add ~/bin to PATH
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# CUDA stuff
[ -d /usr/local/cuda-12.6/bin ] && export PATH="/usr/local/cuda-12.6/bin:$PATH"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

[ -z "$BASH_VERSION" ] && return  # Stop here if we're not bash (we can use bash syntax after this line)
[[ $- != *i* ]]        && return  # Stop here if we're not interactive (this is bash syntax, order of checks matters)

# Store unlimited command history
HISTSIZE=
HISTFILESIZE=
HISTTIMEFORMAT="[%F %T] "                     # Prefix history with timestamps
HISTFILE="${XDG_STATE_HOME}/bash/history"     # Store history in a more stable location, and move it out of home
HISTCONTROL=ignoreboth                        # Ignore duplicate lines and lines starting with space
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"  # Write history on each prompt (default is on session exit)
shopt -s histappend                           # Append to history (default is overwriting)

# Set shell options
shopt -s checkwinsize                         # Update LINES and COLUMNS after each prompt
shopt -s globstar                             # Allow ** matching subdirectories like in glob
shopt -s autocd                               # Enable changing directories by only typing the directory name

# Enable autocompletion
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion

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
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

export TMUX_TEMPDIR=$XDG_RUNTIME_DIR/tmux
mkdir -p $XDG_RUNTIME_DIR/tmux
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

# Aliases
alias l="ls -lAh"
