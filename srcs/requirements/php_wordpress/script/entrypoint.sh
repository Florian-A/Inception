#!/bin/sh

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: f██████ <f██████@student.42lyon.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/03 12:33:02 by f██████           #+#    #+#              #
#    Updated: 2023/03/29 16:48:09 by f██████          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if [ ! -f "/var/www/localhost/wp-config.php" ]; then

    echo "Installing wordpress";

    # Copy wordpress tmp to localhost
    cp -R /tmp/wordpress/* /var/www/localhost/;

    # Create wp-config.php file with database informations
    wp-cli.phar config create \
    --dbname=$DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$DB_PASSWORD \
    --dbhost=$DB_HOST \
    --dbprefix=wp_ \
    --path=/var/www/localhost/ \
    --allow-root;

    # Install wordpress and add superadmin user
    wp-cli.phar core install \
    --url=$WP_URL \
    --title=$WP_TITLE \
    --admin_user=$WP_SUPERADMIN_USER \
    --admin_email=$WP_SUPERADMIN_EMAIL \
    --admin_password=$WP_SUPERADMIN_PASSWORD \
    --path=/var/www/localhost/ \
    --allow-root ;

    # Create admin user
    wp-cli.phar user create $WP_ADMIN_USER $WP_ADMIN_EMAIL \
    --user_pass=$WP_ADMIN_PASSWORD \
    --role=administrator \
    --path=/var/www/localhost/ \
    --allow-root ;

    # Install Redis Object Cache plugin
    wp-cli.phar config set --allow-root --path=/var/www/localhost --anchor="/**#@+" --separator="\n\n" WP_REDIS_HOST redis
    wp-cli.phar config set --allow-root --path=/var/www/localhost --anchor="/**#@+" --separator="\n\n" --raw WP_REDIS_PASSWORD $REDIS_PASSWORD
    wp-cli.phar config set --allow-root --path=/var/www/localhost --anchor="/**#@+" --separator="\n\n" --raw WP_REDIS_PORT 6379
    wp-cli.phar config set --allow-root --path=/var/www/localhost --anchor="/**#@+" --separator="\n\n" --raw WP_REDIS_TIMEOUT 1
    wp-cli.phar config set --allow-root --path=/var/www/localhost --anchor="/**#@+" --separator="\n\n" --raw WP_REDIS_READ_TIMEOUT 1
    wp-cli.phar config set --allow-root --path=/var/www/localhost --anchor="/**#@+" --separator="\n\n" --raw WP_REDIS_DATABASE 0

    wp-cli.phar plugin install redis-cache \
    --activate \
    --path=/var/www/localhost/ \
    --allow-root ;

    wp-cli.phar redis enable \
    --path=/var/www/localhost/ \
    --allow-root ;

    # Install twentytwenty theme
    wp-cli.phar theme install twentytwenty \
    --activate \
    --path=/var/www/localhost/ \
    --allow-root ;

    # Delete all posts and pages
    wp-cli.phar post delete $(wp-cli.phar post list --posts_per_page=1 --format=ids --allow-root --path=/var/www/localhost/) --allow-root --path=/var/www/localhost/;
    wp-cli.phar post delete $(wp-cli.phar post list --post_type=page --format=ids --allow-root --path=/var/www/localhost/) --allow-root --path=/var/www/localhost/;

    # Delete all widgets
    wp-cli.phar widget reset --all --allow-root --path=/var/www/localhost/;

    # Disable comments
    wp-cli.phar option set default_comment_status closed --allow-root --path=/var/www/localhost/;

    # Create new funny post
    wp-cli.phar post create --post_type='post' --post_status=publish --post_title='Pourquoi je mérite un outstanding project !' --post_content="Je suis fier de vous présenter mon projet, qui selon moi mérite d'être récompensé avec un 'outstanding project'.
    
J'ai travaillé dur pour réaliser ce projet et j'ai également réalisé les bonus proposés, ce qui a demandé encore plus de temps et d'efforts.

Je tiens à souligner que je suis quelqu'un de très sérieux dans mon travail, je suis méthodique, organisé et je sais prendre des décisions rapidement en cas de besoin. J'ai une grande capacité d'adaptation, ce qui m'a permis de m'adapter rapidement aux changements qui se sont présentés pendant le développement du projet.

En outre, je suis une personne de confiance et j'ai toujours été à l'écoute des membres de l'équipe. J'ai su créer une bonne dynamique de groupe et encourager chacun à donner le meilleur de lui-même. De plus, j'ai toujours été disponible pour répondre aux questions et pour aider mes collègues à résoudre les problèmes.

Enfin, je tiens à vous rappeler que j'ai réalisé tous les bonus proposés, ce qui montre mon engagement envers ce projet et ma volonté de faire en sorte qu'il soit un succès. J'ai travaillé avec acharnement pour m'assurer que toutes les fonctionnalités soient opérationnelles et que le projet soit livré dans les délais impartis.

En somme, je pense que mon projet mérite vraiment d'être récompensé avec un 'outstanding project'." --post_thumbnail_id=7 --post_author=2 --path=/var/www/localhost/ --allow-root;

    # Add image to new post
    wp-cli.phar media import /var/www/localhost/image1.jpg --title="Image 1" --post_id=7 --allow-root --path=/var/www/localhost/
    wp-cli.phar post meta set 7 _thumbnail_id 8 --allow-root --path=/var/www/localhost/;

    # Change owner of wordpress files
    chown -R www-data:www-data /var/www/localhost;
    chmod -R 755 /var/www/localhost;
fi

php-fpm7.3 -F;