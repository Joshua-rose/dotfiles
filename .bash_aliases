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
alias gl="git log --oneline"

# navigation aliases
alias github="cd ~/Documents/GitHub"


# functions
branch-status(){
git for-each-ref --format="%(refname:short) %(upstream:short)" refs/heads | \
while read local remote
do
    [ -z "$remote" ] && echo "$local not found on remote" && continue
    git rev-list --left-right ${local}...${remote} -- 2>/dev/null >/tmp/git_upstream_status_delta ||continue
    LEFT_AHEAD=$(grep -c '^<' /tmp/git_upstream_status_delta)
    RIGHT_AHEAD=$(grep -c '^>' /tmp/git_upstream_status_delta)
    echo "$local (ahead $LEFT_AHEAD) | (behind $RIGHT_AHEAD) $remote"
done
}

gpushfirsttime(){
	
	git push -u origin "$(git rev-parse --abbrev-ref HEAD)"
}
