#!/usr/bin/env bash
# Github codespaces setup

function link_files() {
	mv "$HOME/.gitconfig" "$HOME/.gitconfig_cs_default"
	rm "$HOME/.zshrc"
	rm "$HOME/.zsh_aliases"
	stow -t "$HOME" .
	rm "$HOME/.gitconfig"
	mv ./.gitconfig_codespaces "$HOME/.gitconfig"
	if [ -d /workspaces/github ]; then
	  sudo ln -sf /workspaces/github/bin/rubocop /usr/local/bin/rubocop
	  sudo ln -sf /workspaces/github/bin/srb /usr/local/bin/srb
	  sudo ln -sf /workspaces/github/bin/bundle /usr/local/bin/bundle
	  sudo ln -sf /workspaces/github/bin/solargraph /usr/local/bin/solargraph
	  sudo ln -sf /workspaces/github/bin/safe-ruby /usr/local/bin/safe-ruby
	  sudo update-locale LANG=en_US.UTF-8 LC_TYPE=en_US.UTF-8 LC_ALL=en_US.UTF-8
	  # Configure ruby with rbenv
	  ruby_latest="$(rbenv install -l | grep -v - | tail -1)"
	  rbenv install --skip-existing "$ruby_latest"
	  rbenv global "$ruby_latest"
	fi
}

function install_software(){
	sudo apt install -y stow fzf
	sudo apt remove -y ripgrep
	export PATH="$PATH:$HOME/.local/bin"
	cargo install ripgrep
}

function setup_software(){
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
	echo "TMUX plugins installed" >> ~/install.log
	date +"%Y-%m-%d %T" >> ~/install.log;
	nvim --headless "+Lazy! sync" +qa >> ~/install.log 
}


echo '💽 Installing software' >> ~/install.log;
date +"%Y-%m-%d %T" >> ~/install.log;
install_software
echo '🔗 Linking files.' >> ~/install.log;
date +"%Y-%m-%d %T" >> ~/install.log;
link_files
echo '👩<200d>🔧 configure software' >> ~/install.log;
date +"%Y-%m-%d %T" >> ~/install.log;
setup_software
echo '✅ Done!' >> ~/install.log;
date +"%Y-%m-%d %T" >> ~/install.log;
