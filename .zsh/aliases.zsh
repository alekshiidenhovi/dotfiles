# Git shortcuts
alias lg='lazygit'
alias gst='git status'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpuom='git push -u origin main'
alias gmain='git branch -m main'
alias glog='git log --oneline --graph --decorate --all --date=relative'
alias gamend='git commit --no-edit --amend'

gundo() {
    if [ -z "$1" ]; then
        echo "No number of commits specified. Undoing the last 1 commit (--soft)."
        git reset --soft HEAD~1
    elif ! [[ "$1" =~ ^[1-9]+$ ]]; then
        echo "Error: Argument must be a positive integer."
        echo "Usage: gundo <number_of_commits>"
        return 1
    else
        echo "Undoing the last $1 commit(s) (--soft)."
        git reset --soft "HEAD~$1"
    fi
}

# General navigation
alias fvim='nvim $(fzf -m --preview="bat --color=always {}")'
alias ffile='fzf --preview="bat --color=always {}"'
alias ...='cd ../..'
alias ..='cd ..'

# Repo navigation
alias repos='cd $HOME/repos'
alias dots='repos && cd dotfiles'


# LS with colours
alias ll='ls -lG'   # list long, human-readable, classify
alias la='ls -lAG'  # include hidden
