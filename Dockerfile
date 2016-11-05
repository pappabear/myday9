FROM ubuntu:trusty
MAINTAINER chip.irek@gmail.com

RUN mkdir -p /app
WORKDIR /app

RUN apt-get update && \
    apt-get install -y autoconf \
                       bison \
                       build-essential \
                       curl \
                       git \
                       libffi-dev \
                       libgdbm-dev \
                       libgdbm3 \
                       libncurses5-dev \
                       libpq-dev \
                       libreadline6-dev \
                       libssl-dev \
                       libyaml-dev \
                       nodejs \
                       libsqlite3-dev \
                       zlib1g-dev && \
    apt-get autoremove -y && \
    apt-get clean


COPY Gemfile ./ 
RUN git clone --depth 1 https://github.com/sstephenson/rbenv.git /root/.rbenv && \
    git clone --depth 1 https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build && \
    rm -rfv /root/.rbenv/plugins/ruby-build/.git && \
    rm -rfv /root/.rbenv/.git && \
    export PATH="/root/.rbenv/bin:$PATH" && \
    eval "$(rbenv init -)" && \
    rbenv install '2.3.1' && \
    rbenv global '2.3.1' && \
    gem install bundler --no-ri --no-rdoc && \
    rbenv rehash && \
    gem install rails -v '>= 5.0.0' --no-ri --no-rdoc && \
    rbenv rehash && \
    bundle install   

ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
RUN echo "export PATH=$PATH" >> /root/.bashrc

EXPOSE 3000
