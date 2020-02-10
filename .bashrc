#!/usr/bin/env bash

# Load dotfiles like ~/.bash_prompt, etc…
#   ~/.extra is used for settings not committed to the repository,
for file in ~/.{extra,path,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done

# Path to the bash it configuration
export BASH_IT="$HOME/.bash-it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
if ( [ "$TERM" == 'xterm' ] || [ "$TERM" == 'xterm-256color' ] || [ "$TERM" == 'cygwin' ] ) ; then
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
        PYTHON_USER_BASE="$(cygpath $(python -m site --user-base))"
        PYTHON_HOME="$(cygpath $(python -c "import sys, os; print(os.path.split(sys.executable)[0])"))"
        PERLDIR=$(cygpath $PERLDIR)
        export PATH="$PERLDIR:$PATH:$PYTHON_USER_BASE/scripts:$PYTHON_HOME/scripts"
        export PIPENV_VENV_IN_PROJECT=1
        unset PYTHON_HOME
        export ANDROID_NDK_ROOT=D:\\Android_NDK\\android-ndk-r16b
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
