FROM php:8.2-apache

RUN a2enmod rewrite

# Extensiones MySQL
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copia el proyecto
COPY . /var/www/

# Cambia el DocumentRoot a /var/www/Vista
RUN sed -i 's#/var/www/html#/var/www/Vista#g' /etc/apache2/sites-available/000-default.conf \
 && sed -i 's#<Directory /var/www/>#<Directory /var/www/Vista/>#g' /etc/apache2/apache2.conf \
 && echo '<Directory /var/www/Vista/>\nAllowOverride All\nRequire all granted\n</Directory>' >> /etc/apache2/apache2.conf

RUN chown -R www-data:www-data /var/www

EXPOSE 80
