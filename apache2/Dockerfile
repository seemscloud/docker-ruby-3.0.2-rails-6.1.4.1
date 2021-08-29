FROM ubuntu:focal

ARG LISTEN_PORT

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install apache2 -y

RUN a2dissite 000-default.conf && \
    rm -f /etc/apache2/sites-available/default-ssl.conf && \
    rm -f /etc/apache2/sites-available/000-default.conf

COPY ./files/default.conf /etc/apache2/sites-available/
COPY ./files/ports.conf /etc/apache2/

RUN sed -i "s/LISTEN_PORT/${LISTEN_PORT}/g" /etc/apache2/ports.conf && \
    sed -i "s/LISTEN_PORT/${LISTEN_PORT}/g" /etc/apache2/sites-available/default.conf && \
    echo "${LISTEN_PORT}" && \
    cat /etc/apache2/ports.conf

RUN a2ensite default.conf

RUN ln -sf /proc/$$/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/$$/fd/2 /var/log/apache2/error.log

CMD ["apachectl", "-D", "FOREGROUND", "-e", "debug"]