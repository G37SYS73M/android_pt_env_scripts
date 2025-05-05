FROM kali:latest

ENV DEBIAN_FRONTEND=noninteractive

# Base dependencies
RUN apt update && apt install -y \
    openjdk-17-jdk \
    adb \
    git \
    wget \
    curl \
    unzip \
    python3 \
    python3-pip \
    python3-venv \
    pipx \
    sudo \
    build-essential \
    ca-certificates \
    libxext6 libxrender1 libxtst6 libxi6 \
    x11-apps xfce4 xfce4-goodies tightvncserver dbus-x11 \
    && apt clean

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:/root/.local/bin:$PATH"

# APKTool setup
RUN mkdir -p /opt/tools/apktool && \
    wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.9.3.jar -O /opt/tools/apktool/apktool.jar && \
    wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O /opt/tools/apktool/apktool && \
    chmod +x /opt/tools/apktool/apktool && \
    ln -s /opt/tools/apktool/apktool /usr/local/bin/apktool && \
    ln -s /opt/tools/apktool/apktool.jar /usr/local/bin/apktool.jar

# JADX
RUN git clone https://github.com/skylot/jadx.git /opt/tools/jadx && \
    cd /opt/tools/jadx && ./gradlew dist && \
    ln -s /opt/tools/jadx/build/jadx/bin/jadx /usr/local/bin/jadx && \
    ln -s /opt/tools/jadx/build/jadx/bin/jadx-gui /usr/local/bin/jadx-gui

# pidcat
RUN wget https://raw.githubusercontent.com/JakeWharton/pidcat/master/pidcat.py -O /usr/local/bin/pidcat && \
    chmod +x /usr/local/bin/pidcat

# Frida + Objection
RUN pipx install frida-tools && pipx install objection

# Burp Suite Community Edition (latest Linux installer)
RUN mkdir -p /opt/burp && \
    wget https://portswigger.net/burp/releases/download?product=community&version=2024.3.1.2&type=Linux -O /tmp/burp.sh && \
    chmod +x /tmp/burp.sh && \
    /tmp/burp.sh -q -dir /opt/burp && \
    ln -s /opt/burp/BurpSuiteCommunity /usr/local/bin/burp

# Set working directory
WORKDIR /opt/workspace

# Expose VNC port (optional)
EXPOSE 5901

# Default shell
CMD ["/bin/bash"]
