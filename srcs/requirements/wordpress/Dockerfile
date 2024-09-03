FROM debian:bullseye

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install \
    wget \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000

WORKDIR /var/www/html/

ENTRYPOINT [ "/entrypoint.sh" ]