# ctx_ Demo Environment
# Lightweight container with ctx pre-installed and demo contexts ready

FROM alpine:latest

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    git \
    openssh-client \
    ncurses \
    ca-certificates

# Install ctx using install script
RUN curl -fsSL https://github.com/vlebo/ctx/releases/latest/download/install.sh | sh

# Create demo user
RUN adduser -D -s /bin/bash demo && \
    mkdir -p /home/demo/.config/ctx/contexts

# Copy demo contexts
COPY contexts/*.yaml /home/demo/.config/ctx/contexts/
COPY scripts/demo.sh /home/demo/demo.sh
COPY scripts/bashrc /home/demo/.bashrc

# Set proper ownership
RUN chown -R demo:demo /home/demo

# Switch to demo user
USER demo
WORKDIR /home/demo

CMD ["/bin/bash"]
