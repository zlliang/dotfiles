# Docker image for development (Base)
# Repository: zlliang/dev:base
# Author: Zilong Liang

FROM debian:sid

RUN apt-get update

# Enable the UTF-8 encoding
RUN apt-get install -y locales \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8

# Install Fish shell and command line utilities
RUN apt-get install -y fish git exa bat ripgrep fd-find
COPY ./dev-fish/ /root/.config/fish/

CMD ["fish"]
