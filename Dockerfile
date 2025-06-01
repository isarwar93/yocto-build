FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install all system dependencies and sudo
RUN apt-get update && apt-get install -y \
    sudo gawk wget git git-core diffstat unzip texinfo gcc-multilib build-essential \
    chrpath socat cpio python3 python3-pip python3-pexpect \
    python3-git python3-jinja2 libegl1-mesa-dev pylint rsync bc bison \
    xz-utils debianutils iputils-ping libsdl1.2-dev xterm \
    language-pack-en coreutils texi2html file docbook-utils \
    help2man desktop-file-utils libgl1-mesa-dev libglu1-mesa-dev \
    mercurial autoconf automake groff curl lzop asciidoc u-boot-tools \
    libreoffice-writer sshpass ssh-askpass zip zstd liblz4-tool kpartx \
    vim screen && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Create non-root user with UID 1000
RUN useradd -m -u 1000 -s /bin/bash yoctouser && \
    echo "yoctouser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install Google's repo tool
RUN mkdir -p /home/yoctouser/bin && \
    curl -o /home/yoctouser/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && \
    chmod a+x /home/yoctouser/bin/repo && \
    chown -R yoctouser:yoctouser /home/yoctouser

# Switch to user and set env
USER yoctouser
ENV HOME=/home/yoctouser
ENV PATH="$HOME/bin:$PATH"

WORKDIR $HOME

CMD ["/bin/bash"]
