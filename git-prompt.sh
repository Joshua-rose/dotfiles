PS1='\[\033]0;Git-Bash => ${PWD//[^[:ascii:]]/?}\007\]' # set window title                # current working directory
if test -z "$WINELOADERNOEXEC"; then
    GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
    COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
    COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
    COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
    if test -f "$COMPLETION_PATH/git-prompt.sh"; then
        . "$COMPLETION_PATH/git-completion.bash"
        . "$COMPLETION_PATH/git-prompt.sh"
        PS1="$PS1"'\[\033[36m\]'    # change color to cyan
        PS1="$PS1"'\n`__git_ps1`\n' # bash function
    fi
fi
PS1="$PS1"'\[\033[33m\]'
PS1="$PS1"' \W '
PS1="$PS1"'\[\033[36m\]' # change color
PS1="$PS1"'$ '           # prompt: always $
PS1="$PS1"'\[\033[0m\]'

# git aliases
alias ga='git add'
alias gA="git add --all"
alias gc="git commit -m "
alias gac="git add --all && git commit -m "
alias gs="git status"
alias gp="git push"
alias gundo="git reset HEAD^"
# alias gpushfirsttime="git push -u origin $(git rev-parse --abbrev-ref HEAD)"
alias gpft="gpushfirsttime"
alias gstashlist="git stash list --pretty='format:%gd%s %n -- Created %ar%n--------------------------'"
alias gsl="gstashlist"
alias git-bash-here='/git-bash.exe & > /dev/null'

# navigation aliases
alias github="cd ~/Documents/GitHub"
alias gtd="cd ~/Development"

# functions
branch-status() {
    git for-each-ref --format="%(refname:short) %(upstream:short)" refs/heads |
        while read local remote; do
            [ -z "$remote" ] && echo "$local not found on remote" && continue
            git rev-list --left-right ${local}...${remote} -- 2>/dev/null >/tmp/git_upstream_status_delta || continue
            LEFT_AHEAD=$(grep -c '^<' /tmp/git_upstream_status_delta)
            RIGHT_AHEAD=$(grep -c '^>' /tmp/git_upstream_status_delta)
            echo "$local (ahead $LEFT_AHEAD) | (behind $RIGHT_AHEAD) $remote"
        done
}

gpushfirsttime() {

    git push -u origin "$(git rev-parse --abbrev-ref HEAD)"
}
