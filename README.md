# Aleks' personal dotfiles

My personal, version-controlled configuration dotfiles.

## Dependencies

Make sure the following dependencies are installed on your system.

### Nix

[Nix](https://github.com/NixOS/nix) is a deterministic, declarative and package manager that makes builds reliable and reproducible. 

For MacOS, we need to install [nix-darwin](https://github.com/nix-darwin/nix-darwin) version of Nix. We use [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer#determinate-nix-installer) since the official Nix installer does not come with an automated installer. 

#### 0. Nix installation

Install Nix by running `curl -fsSL https://install.determinate.systems/nix | sh -s -- install`. When prompted, out out of Determinate Nix distribution by explicitly typing `no`. 

#### 1. Nix flakes setup

After Nix has been installed, execute the following commands:
```
sudo mkdir -p /etc/nix-darwin
sudo chown $(id -nu):$(id -ng) /etc/nix-darwin
cd /etc/nix-darwin

# To use Nixpkgs unstable:
nix flake init -t nix-darwin/master

sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix
```
- `sudo mkdir -p /etc/nix-darwin` creates a directory called `/etc/nix-darwin`
- `sudo chown $(id -nu):$(id -ng) /etc/nix-darwin` changes ownership of `/etc/nix-darwin` by substituting the user and group with your current user and group
- `nix flake init -t nix-darwin/master` initializes a new Nix flake project using unstable Nixpkgs.
- `sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix` edits `flake.nix` in place with no backup file defined by `''`. It substitutes (s) string simple with the result from `$(scutil --get LocalHostName)`

#### 2. Installing nix-darwin
As darwin-rebuild won't be installed in your PATH at this point, you can use the following command:
# To use Nixpkgs unstable:
sudo nix run nix-darwin/master#darwin-rebuild -- switch

#### 3. Using nix-darwin
After install `nix-darwin`, you can run `darwin-rebuild` to apply changes to your system:
`sudo darwin-rebuild switch`

### Homebrew

[Homebrew](https://brew.sh) is the OS-wide package manager. Install Homebrew following the official website install instructions.

### Oh My Posh

[Oh My Posh](https://ohmyposh.dev/) is a prompt theme engine for any shell. [Install Oh My Posh](https://ohmyposh.dev/docs/installation/macos) it using Brew by running `brew install jandedobbeleer/oh-my-posh/oh-my-posh` 

### Git

Most Mac and Linux systems come pre-installed with git. If not, you can [install git](https://formulae.brew.sh/formula/git) by running `brew install git`

### Stow
[Stow](https://www.gnu.org/software/stow/) is a symlink manager that creates symlinks from target to source directory's subfolders and files. Stow is used to manage and link dotfiles in this project. [Install Stow](https://formulae.brew.sh/formula/stow) by running `brew install stow`

After stow has been installed, you can sync symlinks from HOME directory to your dotfiles by running: `stow --target="$HOME" .`

### Antidote
[Antidote](https://antidote.sh/) is the zsh plugin manager of choice for this project. It is a spiritual successor of plugin managers [Antigen](https://github.com/zsh-users/antigen) and [Antibody](https://github.com/getantibody/antibody). [Install Antidote](https://antidote.sh/install) by running `brew install antidote`

### Zoxide
[Zoxide]/(https://github.com/ajeetdsouza/zoxide) is an extended cd command, that collect cd usage statistics, allowing smarter jumping between directories. [Install Zoxide](https://github.com/ajeetdsouza/zoxide#installation) running `brew install zoxide`

### Fzf
[Fzf](https://github.com/junegunn/fzf) is an interactive filter program that cuts down searching speed by implementing a fast fuzzy algorithm for file and directory search. [Install fzf](https://github.com/junegunn/fzf#using-homebrew) running `brew install fzf`

### Nerd Font
This config uses the [Hack](https://www.programmingfonts.org/#hack) [Nerd Font](https://www.nerdfonts.com/#home). On MacOS, [install](https://formulae.brew.sh/cask/font-hack-nerd-font) Hack Nerd Font by running `brew install --cask font-hack-nerd-font`.
