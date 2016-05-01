FROM php:7.0-fpm
MAINTAINER Vojtech Bartos <docker@vojtechbartos.com>

# Install modules
RUN apt-get update && docker-php-ext-install mysqli

CMD ["php-fpm"]