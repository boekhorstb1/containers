FROM opensuse/leap:15.3 as base-runtime-74

# set working directory for all subsequent steps (and images derived from this one)
WORKDIR /srv/www/horde

# copy scripts, like entrypoint and various helper scripts into the image
COPY ./base/bin/* /usr/local/bin/
RUN chmod -R +x /usr/local/bin/*

# installs required packages git, unzip and php extensions
# then cleans up zypper cache
# then installs composer
# then creates the target directory for horde and clones the deployment

RUN zypper --non-interactive ref && zypper --non-interactive install --no-recommends --no-confirm \
    git-core \
    gzip \
    php7 \
    php7-bcmath \
    php7-bz2 \
    php7-ctype \
    php7-calendar \
    php7-curl \
    php7-dom \
    php7-gd \
    php7-gettext \
    php7-iconv \
    php7-imagick \
    php7-intl \
    php7-json \
    php7-ldap \
    php7-mbstring \
    php7-mysql \
    php7-opcache \
    php7-openssl \
    php7-pcntl \
    php7-pdo \
    php7-pear \
    php7-phar \
    php7-posix \
    php7-redis \
    php7-soap \
    php7-sockets \
    php7-sqlite \
    php7-tokenizer \
    php7-xmlrpc \
    php7-xmlwriter \
    php7-xmlreader \
    php7-zip \
    php7-zlib \
    tar \
    unzip \
    gettext-tools \
    ## This step is needed because the docker base image's locale is crippled to save space. Horde NLS needs them
    && zypper --non-interactive -v install --no-recommends --no-confirm -f glibc-locale glibc-locale-base \
    && zypper clean -a \
    && mkdir -p /srv/www/horde \
    && /usr/local/bin/composer-installer \
    && mkdir -p /srv/original_config/apps \
    && git clone --depth 5 https://github.com/boekhorstb1/horde-deployment -b FRAMEWORK_6_0 /srv/www/horde \
    && composer --no-interaction install \
    && composer --no-interaction clear-cache \
    && rm -rf /root/.composer/cache \
    && chown -R wwwrun:www /srv/www/horde

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]


FROM opensuse/tumbleweed as base-runtime-81

# set working directory for all subsequent steps (and images derived from this one)
WORKDIR /srv/www/horde

# copy scripts, like entrypoint and various helper scripts into the image
COPY ./base/bin/* /usr/local/bin/
RUN chmod -R +x /usr/local/bin/*

# installs required packages git, unzip and php extensions
# then cleans up zypper cache
# then installs composer
# then creates the target directory for horde and clones the deployment

RUN zypper --non-interactive ref && zypper --non-interactive install --no-recommends --no-confirm \
    git-core \
    system-user-wwwrun \
    gzip \
    php8 \
    php8-bcmath \
    php8-bz2 \
    php8-ctype \
    php8-calendar \
    php8-curl \
    php8-dom \
    php8-gd \
    php8-gettext \
    php8-iconv \
    php8-imagick \
    php8-intl \
    php8-ldap \
    php8-mbstring \
    php8-mysql \
    php8-opcache \
    php8-openssl \
    php8-pcntl \
    php8-pdo \
    php8-pear \
    php8-phar \
    php8-posix \
    php8-redis \
    php8-soap \
    php8-sockets \
    php8-sqlite \
    php8-tokenizer \
    php8-xmlwriter \
    php8-xmlreader \
    php8-zip \
    php8-zlib \
    tar \
    unzip \
    gettext-tools \
    ## This step is needed because the docker base image's locale is crippled to save space. Horde NLS needs them
    && zypper --non-interactive -v install --no-recommends --no-confirm -f glibc-locale glibc-locale-base \
    && zypper clean -a \
    && mkdir -p /srv/www/horde \
    && /usr/local/bin/composer-installer \
    && mkdir -p /srv/original_config/apps \
    && git clone --depth 5 https://github.com/boekhorstb1/horde-deployment -b FRAMEWORK_6_0 /srv/www/horde \
    && composer --no-interaction install \
    && composer --no-interaction clear-cache \
    && rm -rf /root/.composer/cache \
    && chown -R wwwrun:www /srv/www/horde

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
