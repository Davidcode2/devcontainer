FROM archlinux:latest as base

RUN pacman -Sy
RUN pacman -S --noconfirm --needed neovim nodejs npm typescript git openssh zsh tmux man tldr && \ 
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash 

COPY .config/nvim  /root/.config/nvim 
COPY .config/zsh /root/.config/zsh
COPY .config/shell /root/.config/shell
COPY .config/tmuxinator /root.config/tmuxinator
COPY .zshenv /root
COPY .bashrc /root
COPY .bash_profile /root

RUN echo 'chsh -s /bin/zsh' >> /root/.bashrc

RUN echo 'if [ ! -f ${HOME}/.local/share/nvim/site/autoload/plug.vim ]; \
     then curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ; \
   fi' >> /root/.bashrc 
  
RUN echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" \
   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> /root/.bashrc


