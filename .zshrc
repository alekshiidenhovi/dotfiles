
# Init prompt
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/default_config.toml)"
fi

# Install packages

source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

antidote load $HOME/.zsh/plugins.txt

# Add aliases

if [ -f ~/.zsh/aliases.zsh ]; then
  source ~/.zsh/aliases.zsh
fi

# Bind custom keys
bindkey '^[[9674;7u' autosuggest-accept
bindkey '^[[8710;7u' autosuggest-clear

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source ~/.zsh/history_config.zsh
