FROM java:openjdk-8u72-jdk

# Locale setup
RUN apt-get update && \
    apt-get install -yq locales ca-certificates wget sudo && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Add dev user
RUN useradd user -d /home/user -s /bin/bash && cp -r /etc/skel /home/user && chown user.user -R /home/user && echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# RabbitMQ
RUN echo 'deb http://www.rabbitmq.com/debian/ testing main' | tee /etc/apt/sources.list.d/rabbitmq.list && \
          wget -O- https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add -

# Dependencies
RUN apt-get update && apt-get install -yq \
                                      tmux vim curl bash \
                                      rabbitmq-server \
                                      postgresql-9.4 postgresql-client-9.4 postgresql-contrib-9.4 && \
                                      rm -rf /var/cache/apt/*

# Enable rabbitmq admin plugin
RUN /etc/init.d/rabbitmq-server start && \
    rabbitmq-plugins enable rabbitmq_management && \
    /etc/init.d/rabbitmq-server stop && \
    echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

# SDK Man
USER user
RUN curl -s get.sdkman.io | bash

# Configure database
USER root
COPY files/pg_hba.conf /etc/postgresql/9.4/main/pg_hba.conf
RUN /etc/init.d/postgresql start && \
    createuser -s reverseapp -U postgres && \
    createdb -U reverseapp reverseapp && \
    /etc/init.d/postgresql stop

EXPOSE 8080 15672

USER user
WORKDIR /home/user
COPY ["files/start-services.sh", "/home/user/"]
COPY ["files/tmux.conf", "/home/user/.tmux.conf"]
