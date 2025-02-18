#!/usr/bin/env bash
# Github codespaces setup

function link_files() {
	rm "$HOME/.gitconfig"
	rm "$HOME/.zshrc"
	rm "$HOME/.zsh_aliases"
	stow -t "$HOME" .
	if [ -d /workspaces/github ]; then
	  sudo ln -sf /workspaces/github/bin/rubocop /usr/local/bin/rubocop
	  sudo ln -sf /workspaces/github/bin/srb /usr/local/bin/srb
	  sudo ln -sf /workspaces/github/bin/bundle /usr/local/bin/bundle
	  sudo ln -sf /workspaces/github/bin/solargraph /usr/local/bin/solargraph
	  sudo ln -sf /workspaces/github/bin/safe-ruby /usr/local/bin/safe-ruby
	  sudo update-locale LANG=en_US.UTF-8 LC_TYPE=en_US.UTF-8 LC_ALL=en_US.UTF-8
	fi
}
function install_software(){
	sudo apt install -y stow fzf
	sudo apt remove -y ripgrep
	export PATH="$PATH:$HOME/.local/bin"
	cargo install ripgrep
    sudo gem install neovim-ruby-host
}

function setup_software(){
	nvim --headless "+Lazy! sync" +qa >> ~/install.log 
}


echo '🔗 Linking files.' >> ~/install.log;
echo `date +"%Y-%m-%d %T"` >> ~/install.log;
link_files
echo '💽 Installing software' >> ~/install.log;
echo `date +"%Y-%m-%d %T"` >> ~/install.log;
install_software
echo '👩<200d>🔧 configure software' >> ~/install.log;
echo `date +"%Y-%m-%d %T"` >> ~/install.log;
setup_software
echo '✅ Done!' >> ~/install.log;
echo `date +"%Y-%m-%d %T"` >> ~/install.log;
