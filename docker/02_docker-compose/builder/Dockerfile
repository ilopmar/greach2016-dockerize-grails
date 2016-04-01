FROM java:openjdk-8u72-jdk

# Locale setup
RUN apt-get update && \
    apt-get install -yq locales ca-certificates wget sudo && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Docker
RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list && \
    apt-get update && apt-get install -yq docker.io && \
    rm -rf /var/lib/apt/lists/*

# Add user
RUN useradd user -d /home/user -s /bin/bash && \
    cp -r /etc/skel /home/user && \
    chown user.user -R /home/user && \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER user
WORKDIR /home/user

COPY files/entrypoint.sh /home/user/
COPY files/postgresql /home/user/postgresql
COPY files/rabbitmq /home/user/rabbitmq
