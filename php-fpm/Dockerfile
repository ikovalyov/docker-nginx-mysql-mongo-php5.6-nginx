FROM php:7-fpm
COPY config/php.ini /usr/local/etc/php/

RUN mkdir /tmp/xdebug
WORKDIR /tmp/xdebug
RUN apt-get update && apt-get install -y wget && wget https://xdebug.org/files/xdebug-2.4.0.tgz && tar -xvzf xdebug-2.4.0.tgz
WORKDIR /tmp/xdebug/xdebug-2.4.0
RUN echo "Dpkg::Options {\
   "--force-confdef";\
   "--force-confold";\
}" >  /etc/apt/apt.conf.d/local 

#RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --force-yes libc6 libtool libssl1.0.0=1.0.1f-1ubuntu2 php5-dev && DEBIAN_FRONTEND=noninteractive phpize && \
#		./configure && make && cp modules/xdebug.so /usr/lib/php5/20131226 && echo "zend_extension = /usr/lib/php5/20131226/xdebug.so" > /etc/php5/cli/php.ini && \
#		echo "zend_extension = /usr/lib/php5/20131226/xdebug.so" > /etc/php5/fpm/php.ini

RUN /usr/local/bin/phpize
RUN ./configure --enable-xdebug
RUN make && make test
RUN cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20151012/
RUN docker-php-ext-enable xdebug
		
# Configure xdebug
RUN mkdir /etc/php7/
RUN mkdir /etc/php7/mods-available/
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_host=172.17.42.1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini		
RUN echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN cp /etc/php7/mods-available/xdebug.ini /usr/local/etc/php/20-xdebug.ini
#RUN cp /etc/php7/mods-available/xdebug.ini /usr/local/etc/php/20-xdebug.ini
EXPOSE 9001

#configure SSH
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

#supervisor
RUN apt-get -y install gettext libgettextpo-dev supervisor 
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#composer
RUN wget http://getcomposer.org/installer && php installer && mv composer.phar /usr/local/bin/composer && rm installer

#git
RUN apt-get install -y --force-yes libcurl4-openssl-dev pkg-config libssl-dev
RUN pecl install mongodb && docker-php-ext-enable mongodb
#RUN echo "extension=mongodb.so" >> /usr/local/etc/php/php.ini
RUN apt-get install -y --force-yes git && apt-get install -y curl && curl --silent --location https://deb.nodesource.com/setup_4.x | bash - && \
  apt-get install -y nodejs && npm install -g bower
  
#zip
RUN pecl install zip && docker-php-ext-enable zip

#mysql
RUN docker-php-ext-install mysqli && docker-php-ext-install pdo_mysql && docker-php-ext-install gettext

#apcu
RUN pecl install apcu && docker-php-ext-enable apcu
  
#other
RUN apt-get install -y vim nano

#PHPUnit
WORKDIR /tmp/
RUN wget https://phar.phpunit.de/phpunit.phar && chmod +x phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit

ENTRYPOINT ["/bin/sh","-c"]

CMD ["/usr/bin/supervisord", "-n"]
