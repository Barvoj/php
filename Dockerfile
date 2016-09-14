FROM php:7.0-fpm
MAINTAINER Vojtech Bartos <docker@vojtechbartos.com>

# Install blackfire
RUN curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/70 \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && echo "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini

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