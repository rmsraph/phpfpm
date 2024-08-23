FROM php:8.1.29-fpm-alpine3.20

RUN apk update --no-cache

RUN apk add icu-dev

RUN apk add oniguruma-dev

RUN apk add tzdata

RUN apk add zlib-dev

RUN apk add gd

RUN apk add libpng

RUN apk add libpng-dev

RUN apk add libzip

RUN apk add libzip-dev

RUN docker-php-ext-install intl

RUN docker-php-ext-install pcntl

RUN docker-php-ext-install pdo_mysql

RUN docker-php-ext-install mbstring

RUN docker-php-ext-install zip

RUN docker-php-ext-install gd

RUN docker-php-ext-install exif

RUN rm -rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

CMD ["php-fpm"]