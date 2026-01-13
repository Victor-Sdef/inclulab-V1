FROM php:8.2-apache

# Habilita mod_rewrite (por si tu app usa rutas amigables)
RUN a2enmod rewrite

# Instala extensiones comunes (mysqli/pdo_mysql)
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copia tu proyecto al servidor web
COPY . /var/www/html/

# Permisos (a veces necesario si hay uploads)
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
