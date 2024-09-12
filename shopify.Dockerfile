FROM fedora:40
LABEL org.opencontainers.image.source=https://github.com/ThomasSiggaard/boh

# Install necessary packages

RUN dnf install -y wget tar git curl xdg-utils

# Install NVM, Node.js, and Shopify CLI

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash \
 && export NVM_DIR="$HOME/.nvm" \
  && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
 && nvm install 20 \
 && npm install -g @shopify/cli@latest

# Install cloudflared from https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-x86_64.rpm
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-x86_64.rpm \
 && dnf install -y ./cloudflared-linux-x86_64.rpm \
 && rm -f cloudflared-linux-x86_64.rpm

# Set up environment variables for the root user

RUN echo 'export NVM_DIR="$HOME/.nvm"' >> /root/.bashrc \
  && echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /root/.bashrc \
 && echo 'export PS1="\u@\h:\w\$ "' >> /root/.bashrc


