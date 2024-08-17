# Используем образ PHP 8.2
FROM php:8.2-fpm

# Установка необходимых пакетов и расширений
RUN apt-get update --fix-missing && \
    apt-get install -y \
    nano vim procps git iproute2 wget unzip \
    # acllocal
    autotools-dev automake \
    libmemcached-dev \
    libzip-dev \
    # для intl
    libicu-dev \
    # для xml и soap
    libxml2-dev \
    # zmq
    libzmq3-dev \
    # для gd
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    # для imap
    libc-client-dev \
    libkrb5-dev && rm -r /var/lib/apt/lists/* \
    # установка модулей
    && pecl install xdebug-3.2.1 \
    && docker-php-ext-enable xdebug \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && docker-php-ext-install zip \
    && docker-php-ext-install exif \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install intl \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install soap \
    && docker-php-ext-install sockets \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap

# Установка и активация ZMQ
RUN git clone https://github.com/zeromq/php-zmq.git \
    && cd php-zmq \
    && phpize && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -fr php-zmq \
    && docker-php-ext-enable zmq

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN chmod +x /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER=1

# Установка PHPStan
RUN composer global require phpstan/phpstan

# Дополнительные настройки PHP
COPY ./php-additional.ini /usr/local/etc/php/conf.d/php-additional.ini

# Рабочая директория
WORKDIR /var/www/html

# Добавляем директорию глобального Composer-пакета в PATH
ENV PATH="${PATH}:/root/.composer/vendor/bin"
