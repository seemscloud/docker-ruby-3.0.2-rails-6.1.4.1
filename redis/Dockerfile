FROM ubuntu:focal

ARG VERSION
ARG APPDIR="/opt/app"

ENV DEBIAN_FRONTEND=noninteractive
ENV APPDIR="${APPDIR}"
ENV PATH="${APPDIR}/bin:${PATH}"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install wget make gcc pkgconf -y

WORKDIR /tmp

RUN wget https://download.redis.io/releases/redis-${VERSION}.tar.gz -O redis.tar.gz && \
    tar -xf redis.tar.gz -C . --strip-components=1 && \
    make

RUN useradd -s /bin/bash -m -d ${APPDIR} redis && \
    chmod 700 ${APPDIR}

WORKDIR ${APPDIR}

RUN mkdir bin etc var && \
    mv /tmp/src/redis-server bin && \
    mv /tmp/src/redis-cli bin && \
    mv /tmp/redis.conf etc && \
    chmod 700 bin etc var bin/* && \
    chmod 600 etc/* && \
    chown redis:redis -R ${APPDIR} && \
    rm -rf /tmp/*

WORKDIR ${APPDIR}
USER redis

COPY --chown=redis ./entrypoint.sh .

RUN chmod 600 entrypoint.sh

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]