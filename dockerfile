# Utiliser l'image PHP avec Apache
FROM php:8.2-apache

# Installer les extensions PHP requises
RUN docker-php-ext-install mysqli pdo pdo_mysql && \
    apt-get update && \
    apt-get install -y git unzip && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier le contenu du projet
COPY . .

# Donner les bonnes permissions
RUN chown -R www-data:www-data /var/www/html

# Exposer le port Apache
EXPOSE 80

# Lancer Apache
CMD ["apache2-foreground"]
