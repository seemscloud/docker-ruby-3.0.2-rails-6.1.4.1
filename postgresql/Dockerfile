FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install postgresql -y

COPY ./files/pg_hba.conf /etc/postgresql/12/main/



USER postgres

RUN cat /etc/postgresql/12/main/pg_hba.conf