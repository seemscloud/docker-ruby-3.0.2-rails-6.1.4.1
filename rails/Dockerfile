FROM ubuntu:focal

ARG RUBY_VERSION
ARG NODE_VERSION
ARG YARN_VERSION
ARG APPDIR="/opt/app"
ARG GEM_HOME="${APPDIR}/.gem"
ARG GEM_PATH="${APPDIR}/.gem"

ENV DEBIAN_FRONTEND=noninteractive
ENV APPDIR="${APPDIR}"
ENV PATH="/opt/yarn/${YARN_VERSION}/bin:/opt/ruby/${RUBY_VERSION}/bin:/opt/node/${NODE_VERSION}/bin:/${APPDIR}/.gem/bin:${PATH}"
ENV GEM_HOME="${GEM_HOME}"
ENV GEM_PATH="${GEM_PATH}"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y wget make gcc g++ \
            libssl-dev libreadline-dev libgdbm-dev libgdbm-compat-dev libxml2-dev \
            postgresql-server-dev-all liblzma-dev libyaml-dev zlib1g-dev

WORKDIR /tmp

RUN mkdir -p /opt/node/${NODE_VERSION} && \
    wget https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz -O node.tar.xz && \
    tar -xf node.tar.xz -C /opt/node/${NODE_VERSION} --strip-components=1 && \
    rm -f node.tar.xz

RUN mkdir -p /opt/yarn/${YARN_VERSION} && \
    wget https://github.com/yarnpkg/yarn/releases/download/v${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz -O yarn.tar.gz && \
    tar -xf yarn.tar.gz -C /opt/yarn/${YARN_VERSION} --strip-components=1 && \
    rm -f yarn.tar.gz

RUN mkdir -p /opt/ruby/${RUBY_VERSION} && \
    wget https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION:0:3}/ruby-${RUBY_VERSION}.tar.gz -O ruby.tar.gz && \
    tar -xf ruby.tar.gz -C . --strip-components=1 && \
    rm -f ruby.tar.gz && \
    ./configure --prefix=/opt/ruby/${RUBY_VERSION} && \
    make && make install && rm -rf *

RUN useradd -s /bin/bash -m -d ${APPDIR} rails && \
    chmod 700 ${APPDIR}

WORKDIR ${APPDIR}
USER rails

COPY --chown=rails ./files/gemrc .gemrc
COPY --chown=rails ./project .

RUN gem install bundler && \
    bundle install

COPY --chown=rails ./entrypoint.sh .

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]