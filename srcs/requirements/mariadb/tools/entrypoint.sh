#!/bin/bash
chown -R mysql:mysql /var/lib/mysql
mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test-db >> /dev/null

echo "Initialisation de la base de données"
mysqld --user=mysql --bootstrap --silent-startup << _EOF_
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS \`${MARIADB_NAME}\`;
CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MARIADB_NAME}\`.* TO \`${MARIADB_USER}\`@'%';

ALTER USER \`root\`@\`localhost\` IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;
_EOF_

echo "Base de données initialisée"
exec mysqld_safe