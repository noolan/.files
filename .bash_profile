if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi

    # include .bash_local if it exists
    if [ -f "$HOME/.bash_local" ]; then
    . "$HOME/.bash_local"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
fi

NONE="\[\033[0m\]"    # unsets color to term fg color

# regular colors
K="\[\033[0;30m\]"    # black
R="\[\033[0;31m\]"    # red
G="\[\033[0;32m\]"    # green
Y="\[\033[0;33m\]"    # yellow
B="\[\033[0;34m\]"    # blue
M="\[\033[0;35m\]"    # magenta
C="\[\033[0;36m\]"    # cyan
W="\[\033[0;37m\]"    # white

# emphasized (bolded) colors
EMK="\[\033[1;30m\]"
EMR="\[\033[1;31m\]"
EMG="\[\033[1;32m\]"
EMY="\[\033[1;33m\]"
EMB="\[\033[1;34m\]"
EMM="\[\033[1;35m\]"
EMC="\[\033[1;36m\]"
EMW="\[\033[1;37m\]"

# background colors
BGK="\[\033[40m\]"
BGR="\[\033[41m\]"
BGG="\[\033[42m\]"
BGY="\[\033[43m\]"
BGB="\[\033[44m\]"
BGM="\[\033[45m\]"
BGC="\[\033[46m\]"
BGW="\[\033[47m\]"


# displays only the last 25 characters of pwd
set_new_pwd() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=25
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}


# the name of the git branch in the current directory
set_git_branch() {
    unset GIT_BRANCH
    local branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`;


    if test $branch
        then
            local tracking=`git branch -vv 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' | awk '{print $3}' | sed -e '/^[^\[]/d'`;

            track="";
            if test $tracking
            then
                track="${W}(t)"
                local behind=`git status | sed -ne "/Your branch is behind/p" | grep -oE " [0-9]+ " | sed -e "s/ *//g"`;
                local ahead=`git status | sed -ne "/Your branch is ahead/p" | grep -oE " [0-9]+ " | sed -e "s/ *//g"`;
                if test $behind
                then
                    track="${W}(${R}-$behind${W})";
                fi
                if test $ahead
                then
                    track="${W}(${G}+$ahead${W})";
                fi
            fi
            GIT_BRANCH="${K}[${M}$branch$track${K}]"
    fi
}

is_git_branch_tracking() {
    unset GIT_BRANCH_TRACKING
    local tracking=`git branch -vv | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' | awk '{print $3}' | sed -e '/^[^\[]/d'`;
}

update_prompt() {
    set_new_pwd
    set_git_branch
    
    PS1="\[\e]0;\u@\h: \w\a\]\[${EMG}\u@\h${EMB}:${NONE}${NEW_PWD}${GIT_BRANCH}${B}\$ ${NONE}"
}

PROMPT_COMMAND=update_prompt
