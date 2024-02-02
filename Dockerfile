FROM php:5.6.40-apache

COPY ./conf/mime.conf /etc/apache2/mods-available/mime.conf
RUN apt-get update && apt-get install -y \
        apache2-dev \
        build-essential \
        libc-client-dev \
        libedit-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libkrb5-dev \
        libmagickwand-dev \
        libmcrypt-dev \
        libmemcached-dev \
        libpspell-dev \
        libreadline-dev \
        librecode-dev \
        libwebp-dev \
        libxpm-dev \
        libxslt1-dev \
        unzip \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/ --with-freetype-dir=/usr/ --with-xpm-dir=/usr/ \
    && pecl install imagick-3.3.0 \
    && pecl install memcache-3.0.8 \
    && pecl install memcached-2.2.0 \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install \
        bcmath \
        bz2 \
        calendar \
        exif \
        gd \
        gettext \
        imap \
        intl \
        mcrypt \
        mysql \
        mysqli \
        pdo_mysql \
        pspell \
        readline \
        recode \
        shmop \
        soap \
        sockets \
        sysvmsg \
        wddx \
        xmlrpc \
        xsl \
        zip \
        sysvsem \
        sysvshm \
    && curl https://github.com/gnif/mod_rpaf/archive/stable.zip -L -o /tmp/stable.zip \
    && cd /tmp && unzip stable.zip && cd mod_rpaf-stable make && make install

RUN a2enmod actions expires include rewrite proxy_http ssl
