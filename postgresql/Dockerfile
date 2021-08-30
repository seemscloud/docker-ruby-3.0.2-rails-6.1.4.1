FROM ubuntu:focal

ARG VERSION
ARG APPDIR="/opt/app"

ENV DEBIAN_FRONTEND=noninteractive
ENV APPDIR=${APPDIR}
ENV PATH="/opt/postgresql/${VERSION}/bin:${PATH}"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install wget gcc make libreadline-dev zlib1g-dev -y

WORKDIR /tmp

RUN useradd -s /bin/bash -m -d ${APPDIR} postgres && \
    chmod 700 ${APPDIR}

RUN mkdir -p /opt/postgresql/${VERSION} && \
    wget https://ftp.postgresql.org/pub/source/v${VERSION}/postgresql-${VERSION}.tar.gz -O postgresql.tar.gz && \
    tar -xf postgresql.tar.gz -C . --strip-components=1 && \
    ./configure --prefix=/opt/postgresql/${VERSION} && \
    make && \
    make install

WORKDIR ${APPDIR}
USER postgres

RUN mkdir data log dumps && \
    chmod 700 *

COPY --chown=postgres ./entrypoint.sh .

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]