FROM ubuntu:16.04

MAINTAINER Victor Hugo de Souza Vieira "viih@live.fr"

RUN apt-get update && apt-get install -y tzdata && apt-get install -y apt-utils
RUN echo "Brazil/West" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && \
    apt-get install -y libmysqlclient-dev && \
    apt-get install -y nginx openssh-server git-core openssh-client curl nano build-essential openssl curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config sudo supervisor libpq-dev  libreadline-dev firefox

RUN addgroup -gid 1000 docker && adduser docker -gid 1000 --uid 1000 --disabled-password --gecos ""
RUN sudo sh -c "echo 'docker ALL=NOPASSWD: ALL' >> /etc/sudoers"

RUN cd
RUN git clone https://github.com/sstephenson/rbenv.git /usr/share/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/share/.rbenv/plugins/ruby-build
RUN /usr/share/.rbenv/plugins/ruby-build/install.sh
ENV PATH=/usr/share/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

ENV TZ=America/Sao_Paulo
RUN mkdir /var/www/mkt_connect
RUN chown -Rf docker:docker /var/www
USER docker
ENV PATH=/usr/share/.rbenv/bin:/usr/share/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN rbenv install 2.6.3
RUN rbenv global 2.6.3
RUN export RBENV_ROOT="${HOME}/.rbenv"
RUN export PATH="${RBENV_ROOT}/bin:${PATH}"
RUN sudo echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN /home/docker/.rbenv/shims/gem install bundler -v 2.0.0

RUN echo 'export PS1="\[\\033[38m\]\u\[\\033[32m\] \w\[\\033[31m\]\`git branch 2>/dev/null | grep \"^\*\" | sed -r \"s/\*\ (.*)/ \(\\1\)/\"\`\[\\033[37m\]$\[\\033[00m\] "' >> /home/docker/.bashrc

WORKDIR /var/www/mkt_connect
