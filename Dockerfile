FROM php:7.0-fpm
MAINTAINER Vojtech Bartos <docker@vojtechbartos.com>

# Install modules
RUN apt-get update \
    && apt-get install -y git zlib1g-dev \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install zip \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=1"        >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=1"  >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=9000"       >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \

CMD ["php-fpm"]