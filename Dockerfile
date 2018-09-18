FROM php:7.1-apache

# apt-get install php dependency
RUN apt-get update \
    && apt-get install -y \
        libmcrypt-dev \
        libz-dev \
        git \
        wget \

    # install php dependency
    && docker-php-ext-install \
        mcrypt \
        mbstring \
        pdo_mysql \
        zip \

    # clean
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

    #install composer
    && curl -sS https://getcomposer.org/installer \
        | php -- --install-dir=/usr/local/bin --filename=composer \
        && composer config -g repo.packagist composer https://packagist.phpcomposer.com

# create app dir
RUN a2enmod rewrite \
    && mkdir -p /app \
    && rm -fr /var/www/html \
    && ln -s /app/public /var/www/html

WORKDIR /app

# composer install first
#COPY ./composer.json /app/
#COPY ./composer.lock /app/

# install with no code
#RUN composer install  --no-autoloader --no-scripts

# copy project
COPY . /app

RUN composer install \
    && chown -R www-data:www-data /app \
    # && chmod -R 0777 /app/storage
