FROM php:7

ADD sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    git
RUN docker-php-ext-install pdo_mysql
RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
RUN curl -sS https://install.phpcomposer.com/installer  | php
RUN php composer-setup.php
RUN mv composer.phar /usr/local/bin/composer
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
RUN git clone https://github.com/DBDiff/DBDiff.git
WORKDIR /DBDiff
VOLUME /DBDiff/config
RUN composer update -vvv
