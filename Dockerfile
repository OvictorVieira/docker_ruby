FROM ubuntu:16.04

MAINTAINER Victor Hugo de Souza Vieira "viih@live.fr"

RUN apt-get update && apt-get install -y tzdata apt-transport-https apt-utils curl
RUN echo "Brazil/West" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
RUN curl -sL https://deb.nodesource.com/setup_12.x
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
    apt-get install -y git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs npm


RUN addgroup -gid 1000 docker && adduser docker -gid 1000 --uid 1000 --disabled-password --gecos ""
RUN sh -c "echo 'docker ALL=NOPASSWD: ALL' >> /etc/sudoers"

RUN cd
RUN git clone https://github.com/rbenv/rbenv.git /usr/share/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git /usr/share/.rbenv/plugins/ruby-build
RUN /usr/share/.rbenv/plugins/ruby-build/install.sh
ENV PATH=/usr/share/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

ENV TZ=America/Sao_Paulo
RUN mkdir -p /var/www/html/
RUN chown -Rf docker:docker /var/www/html/
USER docker
ENV PATH=/usr/share/.rbenv/bin:/usr/share/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN rbenv install 2.6.3
RUN rbenv global 2.6.3
RUN export RBENV_ROOT="${HOME}/.rbenv"
RUN export PATH="${RBENV_ROOT}/bin:${PATH}"
RUN /home/docker/.rbenv/shims/gem install bundler

RUN echo 'export PS1="\[\\033[38m\]\u\[\\033[32m\] \w\[\\033[31m\]\`git branch 2>/dev/null | grep \"^\*\" | sed -r \"s/\*\ (.*)/ \(\\1\)/\"\`\[\\033[37m\]$\[\\033[00m\] "' >> /home/docker/.bashrc

WORKDIR /var/www/html/
