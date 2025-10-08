# Link local configuration, such as PATH exports 
if [ -f ~/.zshrc.local ]; then
    . ~/.zshrc.local
fi

export EDITOR="nvim"
export CC=$HOMEBREW_PREFIX/opt/llvm/bin/clang
export CXX=$HOMEBREW_PREFIX/opt/llvm/bin/clang++
export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"

export SDKROOT=$(xcrun --show-sdk-path)
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/llvm/lib/c++ -L$HOMEBREW_PREFIX/opt/llvm/lib/unwind -lunwind"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/llvm/include -isysroot $SDKROOT"
export CMAKE_PREFIX_PATH="$HOMEBREW_PREFIX/opt/llvm"

# Init prompt
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/default_config.toml)"
fi

# Install packages

source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

antidote load $HOME/.zsh/plugins.txt
autoload -U compinit && compinit 

# Add aliases
if [ -f ~/.zsh/aliases.zsh ]; then
  source ~/.zsh/aliases.zsh
fi

source ~/.zsh/keybindings.zsh
source ~/.zsh/history_config.zsh

source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
