#!/bin/bash

WP_FOLDER="/var/www/html/wordpress"
WP_CONFIG="${WP_FOLDER}/wp-config.php"
echo "WP_FOLDER: $WP_FOLDER"
echo "WP_CONFIG: $WP_CONFIG"


if [ ! -f "$WP_CONFIG" ]; then
    echo "wp-config.php not found in $WP_FOLDER"
    exit 1
fi

DB_NAME=$(grep -E "^define\('DB_NAME'" "$WP_CONFIG" |  cut -d"'" -f 4)
DB_USER=$(grep -E "^define\('DB_USER'" "$WP_CONFIG" |  cut -d"'" -f 4)
DB_PASSWORD=$(grep -E "^define\('DB_PASSWORD'" "$WP_CONFIG" |  cut -d"'" -f 4)
DB_HOST=$(grep -E "^define\('DB_HOST'" "$WP_CONFIG" | cut -d"'" -f 4)

echo "DB_USER: $DB_USER"
echo "DB_NAME: $DB_NAME"
echo "DB_PASS: $DB_PASSWORD"
echo "DB_HOST: $DB_HOST"

mysqldump  -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" > /home/scripts/mysqldump.sql
zip  Wordpress.zip "$WP_FOLDER" /home/scripts/mysqldump.sql



