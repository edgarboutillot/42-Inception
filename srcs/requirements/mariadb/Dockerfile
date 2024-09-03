FROM debian:bullseye

RUN apt-get update -y && apt-get -y upgrade
RUN apt-get install -y mariadb-server

COPY tools/entrypoint.sh entrypoint.sh
COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /entrypoint.sh && \ 
    chmod 600 /etc/mysql/mariadb.conf.d/50-server.cnf && \
    mkdir -p /var/run/mysqld && \
    chmod 777 /var/run/mysqld

EXPOSE 3306

ENTRYPOINT [ "/entrypoint.sh" ]
