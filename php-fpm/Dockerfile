FROM pvlltvk/ubuntu-trusty-php-fpm-5.6
RUN mkdir /tmp/xdebug
WORKDIR /tmp/xdebug
RUN apt-get install -y wget && wget http://xdebug.org/files/xdebug-2.3.3.tgz && tar -xvzf xdebug-2.3.3.tgz
WORKDIR /tmp/xdebug/xdebug-2.3.3
RUN echo "Dpkg::Options {\
   "--force-confdef";\
   "--force-confold";\
}" >  /etc/apt/apt.conf.d/local 

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --force-yes libc6=2.19-0ubuntu6 libtool libssl1.0.0=1.0.1f-1ubuntu2 php5-dev && DEBIAN_FRONTEND=noninteractive phpize && ./configure && make && cp modules/xdebug.so /usr/lib/php5/20131226 && echo "zend_extension = /usr/lib/php5/20131226/xdebug.so" > /etc/php5/cli/php.ini