FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install curl -y

COPY ./entrypoint.sh .

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]