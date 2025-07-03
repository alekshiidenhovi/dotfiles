# Git shortcuts
alias gst='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpuom='git push -u origin main'
alias gmain='git branch -m main'
alias glog='git log --oneline --graph --decorate --all --date=relative'
alias gundo='git reset --soft HEAD^'
alias gamend='git commit --no-edit --amend'

# General navigation

# Repo navigation
alias repos='cd $HOME/repos'
alias dots='repos && cd dotfiles'

# LS with colours
alias ll='ls -lG'   # list long, human-readable, classify
alias la='ls -lAG'  # include hidden
