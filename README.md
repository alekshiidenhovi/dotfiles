# Aleks' personal dotfiles

My personal, version-controlled configuration dotfiles.

## Setup

### Automatic installation

In order to setup your new machine, you need to execute the following commands:
1. Install Homebrew by executing:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
2. Install nix-darwin via the Determinate Systems installer: 
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
3. Clone the dotfiles repository by executing the following commands:
```bash
mkdir -p ~/repos
git clone git@github.com:alekshiidenhovi/dotfiles.git ~/repos/dotfiles
```
4. Boostrap the nix-darwin environment by running (you may need to run `sudo` depending on your setup):
```bash
cd ~/repos/dotfiles/
nix run nix-darwin -- switch --flake .config/nix#aleks-nix-darwin
```

After the bootstrapping is complete, the following things have been setup to your Mac:
- Zsh + Antidote plugins + Oh My Posh (managed by nix-darwin)
- Neovim + lazy.nvim (managed by nix-darwin)
- CLI applications (managed by nix-darwin)
- GUI applications (managed by nix-darwin through Homebrew)
- Symlinks from ~/repos/dotfiles to the home directory (managed by home-manager)

Final post-installation steps:
- Within `.config/nvim`, copy the `.env.template` file as `.env`. Set up the `GEMINI_API_KEY` environment variable to enable codecompanion AI completions.
```bash
cp ~/repos/dotfiles/.config/nvim/.env.template ~/repos/dotfiles/.config/nvim/.env
```

### Post-installation

Whenever you modify the `flake.nix` or any other files within `~/repos/dotfiles`, apply the changes by running: `darwin-rebuild switch --flake .config/nix#aleks-nix-darwin`.

## Main software / plugins

### MacOS

- [nix-darwin](https://github.com/nix-darwin/nix-darwin) is the MacOS configuration manager and Homebrew replacement for installing packages.
- [home-manager](https://github.com/nix-community/home-manager) is responsible for symlinking the dotfiles to the home directory.

### Editor

- [Neovim](https://neovim.io/) is the editor of choice.
- [lazy.nvim](https://github.com/folke/lazy.nvim) is the chosen plugin manager for Neovim.

### Terminal

- [Antidote](https://antidote.sh/) is the zsh plugin manager of choice for this project. It is a spiritual successor of plugin managers [Antigen](https://github.com/zsh-users/antigen) and [Antibody](https://github.com/getantibody/antibody). 
- [Oh My Posh](https://ohmyposh.dev/) is a prompt theme engine for any shell. 
- [zoxide](https://github.com/ajeetdsouza/zoxide) is an extended cd command, that collect cd usage statistics, allowing smarter jumping between directories. 
- [Fzf](https://github.com/junegunn/fzf) is an interactive filter program that cuts down searching speed by implementing a fast fuzzy algorithm for file and directory search. 
- [fd](https://github.com/sharkdp/fd) is a simple, fast and user-friendly alternative to find.
- [ripgrep](https://github.com/BurntSushi/ripgrep) is a fast grepping tool. 
- [Hack](https://www.programmingfonts.org/#hack) [Nerd Font](https://www.nerdfonts.com/#home) is used to provide nice looking icons and symbols for the terminal.
