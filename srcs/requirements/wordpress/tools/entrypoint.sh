#!/bin/bash
if [ ! -d /run/php ]
then
    service php7.4-fpm start
    service php7.4-fpm stop
fi

if [[ ${WP_USERNAME_ADMIN,,} == *"admin"* ]]
then
    echo "Erreur : le nom d'utilisateur administrateur ne peut pas contenir le mot 'admin'"
    exit
fi

if [[ ${WP_ADMIN_PASSWORD,,} == *${WP_USERNAME_ADMIN,,}* ]]
then
    echo "Erreur : le mot de passe administrateur ne peut pas contenir le nom d'utilisateur"
    exit
fi

sleep 12

if [ ! -f /var/www/html/wp-config.php ]
then
    echo "wp-config.php non trouvé : installation de WordPress"
    wp core download --allow-root --path=/var/www/html --locale=fr_FR
    wp config create --allow-root --dbname="${MARIADB_NAME}" --dbuser="${MARIADB_USER}" --dbpass="${MARIADB_PASSWORD}" --dbhost="${MARIADB_HOST}"
    wp core install --allow-root --url="https://edboutil.42.fr" --title="MY inception site" --admin_name="${WP_USERNAME_ADMIN}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_MAIL}" --skip-email
    wp user create --allow-root "${WP_USERNAME}" "${WP_USER_MAIL}" --user_pass="${WP_USER_PASSWORD}" --role=author
    #wp theme install twentytwentythree --activate --path=/var/www/html --allow-root
    echo "WordPress installé"
else
    echo "WordPress déjà téléchargé ; installation ignorée"
fi

echo "Lancement de PHP-FPM"
/usr/sbin/php-fpm7.4 -F
