!/bin/bash


# Inspration was based on the following:
# See attached for how to set up a dev environment: https://www.taniarascia.com/setting-up-a-brand-new-mac-for-development/
#########################
# Creating SSH Keys  
# Install SSH Keys: ssh-keygen see documentation at https://www.ssh.com/ssh/keygen/
#########################

  #REQUIREMENTS
  # Make sure you are running High Sierra+
  # Update Location Settings in Preferences
  # Update Location Settings in Outlook
  # iTerm: Change Font to Meslo and Theme to Solarized
  # Copy (If you have any) Config Files for .ssh; .aws; .zshrc (and comment out ZSHRC section); and neofetch
  # See the bottom section if you want to Java or Ruby over Python.

#########################

# Run outstanding system updates
echo "Updating system install..."
softwareupdate -ia --verbose
echo ""

# Install xcode cli development tools
echo "Installing xcode cli development tools..."
xcode-select --install
echo ""

#####################################################################
# Install brew apps
#####################################################################

# Install homebrew
echo "Installing homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo ""
echo "Installing HomeBrew apps..."
echo ""

# Dev cli apps
brew install ack                               # Faster Grep - Grep for programmers
brew install bat                               # Syntax Highlighting
brew install bench                             # Benchmarking Tool for Code
brew install openssl                           # SSL
brew install flake8                            # Python Linter
brew install fzf                               # Fuzzy String Search
brew install git                               # Version control
brew install git-secrets                       # Checks for Credential Exposure
brew install gnupg                             # GPG Suite
brew install htop                              # Performance Monitoring
brew install iftop                             # Network Monitoring
brew install libksba                           # GPG Package
brew install libyaml                           # A C library for parsing and emitting YAML
brew install mas                               # MAS Install
brew install neofetch                          # iterm Machine Description
brew install neovim                            # Modern VIM
brew install node                              # NodeJS
brew install postgresql                        # PostgreSQL and tools
brew install reattach-to-user-namespace        # Needed for clipboard integration from vim and tmux
brew install sshuttle                          # VPN via SSH
brew install telnet                            # Telnet
brew install terraform                         # Terraform
brew install tmux                              # Terminal multiplexer
brew install tree                              # Tree Command
brew install wget                              # Retrieve web files
brew install z                                 # Jump Around based on directories

# Dev gui apps
brew cask install balenaetcher                 # Burn raspberry pi images
brew cask install caffeine                     # Keep your screen on
brew cask install cyberduck                    # SFTP Client
brew cask install docker                       # Container tooling
brew cask install drawio                       # Icon/Graphic Creator
brew cask install firefox                      # Firefox -  SignIn/Import Settings about:support. Open "Show In Finder" Copy and Replace
brew cask install gimp                         # Graphics editor
brew cask install gitup                        # Visual Git
brew cask install google-chrome                # Chrome web browser
brew cask install iterm2                       # A better terminal: change bash to /bin/bash -l in Preferences/Profile
brew cask install mountain-duck                # Drive Mounter
brew cask install postman                      # GUI for testing apis
brew cask install pycharm-ce                   # Text based IDE
brew cask install sublime-text                 # Text Editor
brew cask install vagrant                      # Virtual Boxes CLI
brew cask install veracrypt                    # Encryption Gear
brew cask install virtualbox                   # VirtualBox
brew cask install wireshark                    # Wireshark
brew cask install zenmap                       # NMAP Client

# Personal gui apps
brew install syncthing                         # Backup Software
brew services start syncthing
brew cask install hazel                        # Folder Cleanup
open /Applications/Hazel.app/
brew cask install quickhash                    # Hashing Program
brew cask install safeincloud-password-manager # Password Manager

# Communication
brew cask install quip                         # Quip for Collaboration
brew cask install riot                         # IRC Client
brew cask install signal                       # Signal
 

# Productivity gui apps
brew cask install alfred                       # Mac os helper
open /Applications/Alfred\ 3.app/
brew cask install flux                         # Blue light solution
open /Applications/Flux.app/


echo ""

#####################################################################
# Install mac app store apps
#
# NOTE: The mas commands will only work if you are:
#   - on High Sierra+
#   - have downloaded the app from the store previously
#   - are currently logged into the app store app
#####################################################################

echo "Installing mas cli..."
brew install mas                               # Mac App Store CLI
echo ""

echo "Installing mas apps..."
echo ""

# Dev gui apps
mas install 497799835                         # Xcode, ios/osx app dev env
sudo xcodebuild -license accept
mas install 1295203466                        # Microsoft Remote Desktop, rdp into windows
mas install 1451685025

# Work gui apps
mas install 866773894                         # Quiver PAID Notetaking
mas install 1211707701                        # Fudget PAID Bugeting

#####################################################################
# Pimp zsh
#
# NOTE: To use the bullet-train theme with zsh you will need to
# change Terminal/iterm2 to use one of the powerline fonts installed
# with the first set of commands below.
#####################################################################

# Install powerline fonts (needed by bullet train theme)
git clone https://github.com/powerline/fonts.git ~/tmp/fonts
sudo ~/tmp/fonts/install.sh
rm -rf ~/tmp/fonts

# Install bullet-train theme
# mkdir -p ~/.zsh-custom/themes
# sudo curl -L -o ~/.zsh-custom/themes/bullet-train.zsh-theme https://raw.githubusercontent.com/caiogondim/bullet-train.zsh/master/bullet-train.zsh-theme

# Install oh-my-zsh theme
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Customise oh my zsh to use agnoster theme
sed -i -e 's/ZSH_THEME="\(.*\)"/ZSH_THEME="agnoster"/' ~/.zshrc
sed -i -e 's/^# ZSH_CUSTOM=\(.*\)/ZSH_CUSTOM=~\/.zsh-custom/' ~/.zshrc

#####################################################################
# ZSH Preferences
#####################################################################
echo 'alias upd="brew update; brew upgrade; brew cask upgrade; mas upgrade; brew cleanup --prune-prefix; brew doctor; brew cleanup;' >> ~/.zshrc
echo 'alias weather="curl wttr.in/Tarrytown:NewYork"' >> ~/.zshrc
echo 'alias gitc="git ls-files | xargs cat | wc -l"' >> ~/.zshrc
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

echo '# Base32 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"' >> ~/.zshrc

source ~/.zshrc

#####################################################################
# Git Configuration
#####################################################################
echo ""
echo "Creating Git Configuration"
echo ""

touch ~/.gitconfig

cat << EOT >> ~/.gitconfig
[user]
    name = FIRST_NAME LAST_Name
    email = EMAIL
[github]
    user = USERNAME 
[alias]
    a = add
    ca = commit -a
    cam = commit -am
    s = status
    pom = push origin master
    pog = push origin gh-pages
    puom = pull origin master
    puog = pull origin gh-pages
    cob = checkout -b
[credential]
    helper = osxkeychain
[secrets]
    providers = git secrets --aws-provider
    patterns = [A-Z0-9]{20}
    patterns = (\"|')?(AWS|aws|Aws)?_?(SECRET|secret|Secret)?_?(ACCESS|access|Access)?_?(KEY|key|Key)(\"|')?\\s*(:|=>|=)\\s*(\"|')?[A-Za-z0-9/\\+=]{40}(\"|')?
    patterns = (\"|')?(AWS|aws|Aws)?_?(ACCOUNT|account|Account)_?(ID|id|Id)?(\"|')?\\s*(:|=>|=)\\s*(\"|')?[0-9]{4}\\-?[0-9]{4}\\-?[0-9]{4}(\"|')?
    allowed = AKIAIOSFODNN7EXAMPLE
    allowed = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
EOT

#####################################################################
# SSH Configuration
#####################################################################
echo ""
echo "Configuring SSH"
echo ""

touch ~/.ssh/config

cat << EOT >> ~/.ssh/config
ANY SSH CONFIG INFO YOU WANT.

EOT
#####################################################################
# Creating Email Cert
#####################################################################
echo ''
echo 'go to Outlook and/or Apple Mail and configure to have "alias" cert sign all messages and encrypt(if needed)'
echo ''

#####################################################################
# Install the devtool version managers
#####################################################################

# # Install Sdkman (manage jvm related build tools)
# if [ ! -f ~/.sdkman/bin/sdkman-init.sh ]; then
#   echo "Installing Sdkman"
#   curl -s "https://get.sdkman.io" | bash
#   source ~/.sdkman/bin/sdkman-init.sh

#   sdk install java 8.0.181-zulu
#   sdk install gradle
#   sdk install maven
#   sdk install sbt
#   sdk install visualvm
# fi

# Install Node Version Manager
if [ ! -f ~/.nvm/nvm.sh ]; then
  echo "Installing Node Version Manager"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

  cat << EOT >> ~/.zshrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOT

  source ~/.zshrc
  nvm install node
fi

#####################################################################
# Python Installer
#####################################################################
# Python Env and Global ENV
brew install pyenv                             # Python ENV
brew install pyenv-virtualenv                  # PythonEnv VirualEnv
echo '#Python Env'
echo 'eval $(pyenv init -)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
exec $SHELL
pyenv
pyenv install 3.7.4
pyenv global 3.7.4
pyenv virtualenv 3.7.4 global-venv
pyenv global global-venv
pip install ansible awscli boto3 boto
source ~/.zshrc

sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target / # Install zlib for pyenv

#####################################################################
# Ruby
#####################################################################

# Install Ruby I've decided to use rbenv.
brew install rbenv
rbenv init
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
brew upgrade rbenv ruby-build
rbenv install 2.6.1
rbenv global 2.6.1
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
rbenv rehash

#####################################################################
# Ruby Gems for Install
#####################################################################
gem install bundler jekyll

#####################################################################
# RVM Option
#####################################################################

# Install Ruby Version Manager if you want to use this Ruby Version Manager
# if [ ! -f ~/.rvm/scripts/rvm ]; then
#   echo "Installing RVM"
#   curl -L -o rvm-installer https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer
#   chmod +x ./rvm-installer
#   ./rvm-installer
#   rm rvm-installer

#   source ~/.zshrc
#   rvm install ruby --latest --default
# fi

#####################################################################
# Configurations
#####################################################################

chflags nohidden ~/Library #Show Library
defaults write com.apple.finder AppleShowAllFiles YES #Show Hidden Files
defaults write com.apple.finder ShowPathbar -bool true #Show Path Bar
defaults write com.apple.finder ShowStatusBar -bool true #Show status Bar
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE #Removing two finger "go back" from Chrome
defaults write com.mozilla.Firefox AppleEnableSwipeNavigateWithScrolls -bool FALSE #Removing two finder "go back" from Chrome
sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target / # Install zlib for pyenv

exec $SHELL