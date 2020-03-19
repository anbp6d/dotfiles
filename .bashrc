#!/usr/bin/env bash

# Load dotfiles like ~/.bash_prompt, etc…
#   ~/.extra is used for settings not committed to the repository,
for file in ~/.{extra,path,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done

# Start tmux if it exists on the system and we're not already in a session
if hash tmux 2>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux -2 new-session -A -s main
fi

# Setup dircolors
eval "$(dircolors)"

# Path to the bash it configuration
export BASH_IT="$HOME/.bash-it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
if ( [ "$TERM" == 'xterm-256color' ] || [ "$TERM" == 'cygwin' ] || [ "$TERM" == 'screen-256color' ] ) ; then
    export BASH_IT_THEME='powerline-multiline'
    export POWERLINE_LEFT_PROMPT="scm cwd"
    export POWERLINE_RIGHT_PROMPT="clock user_info"
else
    export BASH_IT_THEME='atomic'
fi

# Don't check mail when opening terminal.
unset MAILCHECK

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true
export SCM_GIT_SHOW_MINIMAL_INFO=true

case "$(uname -s)" in
    MSYS*|MINGW64*|CYGWIN*)
        #normalize windows paths to unix paths
        if hash python 2>/dev/null; then
            PYTHON_USER_BASE="$(cygpath $(python -m site --user-base))"
            PYTHON_HOME="$(cygpath $(python -c "import sys, os; print(os.path.split(sys.executable)[0])"))"
            export PIPENV_VENV_IN_PROJECT=1
        fi
        if [ -n "$PERLDIR" ]; then
            PERLDIR=$(cygpath $PERLDIR)
        else
            echo "Warning: PERLDIR is not set"
        fi
        export PATH="$PERLDIR:$PATH:$PYTHON_USER_BASE/scripts:$PYTHON_HOME/scripts"
        unset PYTHON_HOME
        ;;
    *)
        PYTHON_USER_BASE="$(python -m site --user-base)"
        PYTHON_HOME="$(python -c "import sys, os; print(os.path.split(sys.executable)[0])")"
        export PATH="$PATH:$PYTHON_USER_BASE/bin:$PYTHON_HOME/scripts"
        unset PYTHON_HOME
        ;;
esac

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source "$BASH_IT"/bash_it.sh
