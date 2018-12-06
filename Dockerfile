FROM php:7.1-apache

RUN a2enmod rewrite \
    && mkdir -p /app \
    && rm -fr /var/www/html \
    && ln -s /app/public /var/www/html

WORKDIR /app
COPY . /app
RUN chown -R www-data:www-data /app
