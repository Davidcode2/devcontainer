FROM archlinux:latest as base

RUN pacman -Sy
RUN pacman -S --noconfirm neovim typescript git openssh zsh && \ 
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash 

COPY .config/nvim/ .config/zsh/ .config/shell/ /root/.config/
COPY .zshenv /root
COPY .bashrc /root
COPY .bash_profile /root
