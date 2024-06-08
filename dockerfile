FROM archlinux:latest as base

RUN pacman -Sy
RUN pacman -S --noconfirm --needed neovim fzf nodejs npm typescript git openssh zsh tmux man tldr 

WORKDIR /root

RUN touch .bashrc

# install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash 

# nvm 
RUN echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" \
   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> .bashrc

# Plug
RUN echo -e 'if [ ! -f ${HOME}/.local/share/nvim/site/autoload/plug.vim ]; \n \
     then curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \n \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ; \n \
   fi \n' >> .bashrc 
  
# clone dotfiles into bare repo
RUN echo "alias config='/usr/bin/git --git-dir=.cfg/ --work-tree=/root'" >> .bashrc
ARG config='/usr/bin/git --git-dir=.cfg/ --work-tree=/root'
RUN touch .gitignore && echo ".cfg" >> .gitignore
RUN git clone --bare https://github.com/Davidcode2/dotfiles.git -b wayland .cfg 
RUN alias config=$config >> .bashrc && \
  $config checkout -f && \
  $config config --local status.showUntrackedFiles no

# change default shell to zsh
RUN echo -e 'chsh -s /bin/zsh \n' >> .bashrc

RUN echo "source .config/shell/aliasrc" >> .bashrc
RUN echo "source .config/zsh/.zshrc" >> .bashrc
RUN cp .bashrc .zshrc

WORKDIR workspace
